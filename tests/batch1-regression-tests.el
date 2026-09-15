;;; batch1-regression-tests.el --- Batch 1 configuration regressions -*- lexical-binding: t; -*-

(require 'cl-lib)
(require 'ert)

(defvar straight-current-profile)

(defconst my/batch1--config-file
  (expand-file-name "../lit.org" (file-name-directory (or load-file-name buffer-file-name)))
  "Path to the literate configuration under test.")

(defun my/batch1--eval-definition (name)
  "Read and evaluate the DEFUN named NAME from `my/batch1--config-file'."
  (with-temp-buffer
    (insert-file-contents my/batch1--config-file)
    (goto-char (point-min))
    (unless (re-search-forward
             (concat "^[ \t]*(defun " (regexp-quote name) "\\(?:[ \t\n]\\)") nil t)
      (ert-fail (format "Definition %s was not found" name)))
    (goto-char (match-beginning 0))
    (skip-chars-forward " \t")
    (eval (read (current-buffer)))))

(defun my/batch1--load-package-management-definitions ()
  "Load only the package-management forms needed by these tests."
  (dolist (name '("my/straight-lockfile"
                  "my/straight-check-modifications"
                  "my/straight-prune-build"
                  "my/straight-rebuild-package"
                  "my/straight-lockfile-backup-directory"
                  "my/straight-backup-lockfile"
                  "my/straight-restore-lockfile"
                  "my/straight-commit-lockfile"
                  "my/straight-diff-lockfile"))
    (my/batch1--eval-definition name)))

(ert-deftest my/batch1-removed-in-emacs-ai-and-vault-automation ()
  "The removed integrations stay absent while terminal and Org-roam features remain."
  (with-temp-buffer
    (insert-file-contents my/batch1--config-file)
    (let ((source (buffer-string)))
      (should-not (string-match-p "gptel\\|mcp\\|git-auto-commit-mode\\|C-c g" source))
      (should (string-match-p "my/ai-term-launch" source))
      (should (string-match-p "C-c a" source))
      (should (string-match-p (regexp-quote "(use-package org-roam") source))
      (should (string-match-p "org-roam-capture-templates" source))
      (should (string-match-p
               (regexp-quote "(\"C-c n c\" . org-roam-capture)") source)))))

(ert-deftest my/batch1-lockfile-resolver-uses-current-profile ()
  "Lockfile lookup must follow `straight-current-profile'."
  (my/batch1--eval-definition "my/straight-lockfile")
  (let ((straight-current-profile 'work))
    (cl-letf (((symbol-function 'straight--versions-lockfile)
               (lambda (profile) (format "/tmp/%s-lockfile.el" profile))))
      (should (equal (my/straight-lockfile) "/tmp/work-lockfile.el")))))

(ert-deftest my/batch1-lockfile-backups-are-profile-scoped ()
  "Backup selection is isolated to the active Straight profile."
  (my/batch1--eval-definition "my/straight-lockfile-backup-directory")
  (cl-letf (((symbol-function 'straight--dir) (lambda () "/straight")))
    (let ((straight-current-profile 'work))
      (should (equal (my/straight-lockfile-backup-directory)
                     "/straight/versions/backups/work")))
    (let ((straight-current-profile 'personal))
      (should (equal (my/straight-lockfile-backup-directory)
                     "/straight/versions/backups/personal")))))

(ert-deftest my/batch1-maintenance-wrappers-use-public-commands ()
  "Check and rebuild delegate to Straight; pruning requires confirmation."
  (my/batch1--load-package-management-definitions)
  (let (checked rebuilt pruned)
    (cl-letf (((symbol-function 'straight-check-all)
               (lambda () (setq checked t)))
              ((symbol-function 'call-interactively)
               (lambda (command) (setq rebuilt command)))
              ((symbol-function 'yes-or-no-p)
               (lambda (_prompt) t))
              ((symbol-function 'straight-prune-build)
               (lambda () (setq pruned t))))
      (my/straight-check-modifications)
      (my/straight-rebuild-package)
      (my/straight-prune-build)
      (should checked)
      (should (eq rebuilt 'straight-rebuild-package))
      (should pruned))
    (setq pruned nil)
    (cl-letf (((symbol-function 'yes-or-no-p)
               (lambda (_prompt) nil))
              ((symbol-function 'straight-prune-build)
               (lambda () (setq pruned t))))
      (my/straight-prune-build)
      (should-not pruned))))

(ert-deftest my/batch1-lockfile-commands-use-resolver-and-safe-fixtures ()
  "Backup, restore, review, and diff use the resolver without Git mutations."
  (require 'magit-status)
  (my/batch1--load-package-management-definitions)
  (let* ((root (make-temp-file "batch1-lockfile-" t))
         (repository-root (expand-file-name "repository" root))
         (lockfile-directory (file-name-as-directory
                              (expand-file-name "versions" repository-root)))
         (lockfile (expand-file-name "work.el" lockfile-directory))
         (backup-dir (expand-file-name "versions/backups/work" root))
         (backup-name "lockfile-test.el")
         (resolver-calls 0)
         magit-directory diff-args diff-directory)
    (unwind-protect
        (progn
          (make-directory lockfile-directory t)
          (with-temp-file lockfile (insert "current"))
          (make-directory backup-dir t)
          (with-temp-file (expand-file-name backup-name backup-dir) (insert "backup"))
          (let ((straight-current-profile 'work))
            (cl-letf (((symbol-function 'my/straight-lockfile)
                       (lambda () (setq resolver-calls (1+ resolver-calls)) lockfile))
                      ((symbol-function 'straight--dir) (lambda () root))
                      ((symbol-function 'completing-read)
                       (lambda (_prompt collection predicate require-match &rest _)
                         (should require-match)
                         (should-not predicate)
                         (should (member backup-name collection))
                         backup-name))
                      ((symbol-function 'yes-or-no-p) (lambda (&rest _) t))
                      ((symbol-function 'magit-toplevel)
                       (lambda (directory)
                         (should (equal directory lockfile-directory))
                         repository-root))
                      ((symbol-function 'magit-status)
                       (lambda (directory) (setq magit-directory directory)))
                      ((symbol-function 'vc-backend) (lambda (_) 'Git))
                      ((symbol-function 'vc-diff)
                       (lambda (&rest args)
                         (setq diff-args args
                               diff-directory default-directory))))
              (my/straight-backup-lockfile)
              (with-temp-file lockfile (insert "current"))
              (my/straight-restore-lockfile)
              (my/straight-commit-lockfile)
              (my/straight-diff-lockfile)))
          (should (= resolver-calls 4))
          (should (equal (with-temp-buffer
                           (insert-file-contents lockfile)
                           (buffer-string))
                         "backup"))
          (should (file-exists-p (expand-file-name backup-name backup-dir)))
          (should (equal magit-directory repository-root))
          (should (equal diff-args (list nil t (list 'Git (list lockfile)))))
          (should (equal diff-directory lockfile-directory)))
      (delete-directory root t))))

(ert-deftest my/batch1-lockfile-review-rejects-non-repository-without-prompt ()
  "Reviewing a lockfile outside Git must not offer to initialize a repository."
  (require 'magit-status)
  (my/batch1--eval-definition "my/straight-commit-lockfile")
  (let* ((root (make-temp-file "batch1-lockfile-no-repository-" t))
         (lockfile (expand-file-name "default.el" root)))
    (unwind-protect
        (progn
          (with-temp-file lockfile (insert "lockfile"))
          (cl-letf (((symbol-function 'my/straight-lockfile) (lambda () lockfile))
                    ((symbol-function 'magit-toplevel) (lambda (_) nil))
                    ((symbol-function 'magit-status)
                     (lambda (&rest _) (ert-fail "Magit status must not run")))
                    ((symbol-function 'y-or-n-p)
                     (lambda (&rest _) (ert-fail "Repository initialization was prompted"))))
            (should-error (my/straight-commit-lockfile) :type 'user-error)))
      (delete-directory root t))))

(defun my/batch1--git (directory &rest arguments)
  "Run Git with DIRECTORY as its working directory or fail the current test."
  (with-temp-buffer
    (let* ((default-directory (file-name-as-directory directory))
           (status (apply #'process-file "git" nil (current-buffer) nil arguments)))
      (unless (eq status 0)
        (ert-fail (format "git %s failed: %s"
                          (mapconcat #'identity arguments " ")
                          (buffer-string)))))))

(ert-deftest my/batch1-lockfile-integration-uses-repository-root-and-fileset ()
  "Real Magit and VC review only the modified lockfile in a disposable clone.

Reuse existing local history because VC Git compares against HEAD.  The
fixture creates no commits and never changes signing configuration."
  (skip-unless (executable-find "git"))
  (require 'magit-status)
  (require 'vc)
  (my/batch1--load-package-management-definitions)
  (let* ((root (make-temp-file "batch1-lockfile-integration-" t))
         (versions-directory (expand-file-name "straight/versions" root))
         (lockfile (expand-file-name "default.el" versions-directory))
         (unrelated-file (expand-file-name "init.el" root))
         (nested-git-directory (expand-file-name ".git" versions-directory)))
    (unwind-protect
        (progn
          (my/batch1--git root "clone" "--quiet" "--shared"
                          (file-name-directory my/batch1--config-file) root)
          (should (file-exists-p lockfile))
          (should (file-exists-p unrelated-file))
          (with-temp-file lockfile (insert "modified lockfile\n"))
          (with-temp-file unrelated-file (insert "modified unrelated file\n"))
          (when (get-buffer "*vc-diff*")
            (kill-buffer "*vc-diff*"))
          (cl-letf (((symbol-function 'my/straight-lockfile) (lambda () lockfile))
                    ((symbol-function 'y-or-n-p)
                     (lambda (&rest _) (ert-fail "Repository initialization was prompted"))))
            (my/straight-commit-lockfile)
            (should-not (file-exists-p nested-git-directory))
            (my/straight-diff-lockfile))
          (let ((diff-buffer (get-buffer "*vc-diff*")))
            (should diff-buffer)
            (dotimes (_ 100)
              (when-let ((process (get-buffer-process diff-buffer)))
                (accept-process-output process 0.1)))
            (should-not (get-buffer-process diff-buffer))
            (with-current-buffer diff-buffer
              (should (string-match-p (regexp-quote "default.el") (buffer-string)))
              (should-not (string-match-p (regexp-quote "init.el") (buffer-string))))))
      (when (get-buffer "*vc-diff*")
        (kill-buffer "*vc-diff*"))
      (delete-directory root t))))

;;; batch1-regression-tests.el ends here
