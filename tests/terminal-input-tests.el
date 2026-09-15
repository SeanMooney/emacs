;;; terminal-input-tests.el --- AI terminal Ghostel input transport tests -*- lexical-binding: t; -*-

(require 'cl-lib)
(require 'ert)

(defconst my/terminal-input--config-file
  (expand-file-name "../lit.org" (file-name-directory (or load-file-name buffer-file-name)))
  "Path to the literate configuration under test.")

(defvar my/ai-term-backend 'ghostel)
(defvar my/ai-term-ghostel-delay 0)
(defvar-local ghostel--process nil)

(defun my/terminal-input--eval-definition (name)
  "Read and evaluate the DEFUN named NAME from the literate configuration."
  (with-temp-buffer
    (insert-file-contents my/terminal-input--config-file)
    (goto-char (point-min))
    (unless (re-search-forward
             (concat "^[ \t]*(defun " (regexp-quote name) "\\(?:[ \t\n]\\)") nil t)
      (ert-fail (format "Definition %s was not found" name)))
    (goto-char (match-beginning 0))
    (skip-chars-forward " \t")
    (eval (read (current-buffer)))))

(defun my/terminal-input--load-definitions ()
  "Load only the launcher definitions covered by these transport tests."
  (dolist (name '("my/ai-term--shell-command"
                  "my/ai-term--make-ghostel"
                  "my/ai-term--send"))
    (my/terminal-input--eval-definition name)))

(ert-deftest my/ai-term-ghostel-launch-callback-uses-public-input-api ()
  "The delayed Ghostel launcher callback sends through `ghostel-send-string'."
  (my/terminal-input--load-definitions)
  (let (timer-call sent started buffer)
    (unwind-protect
        (cl-letf (((symbol-function 'my/ai-term--ensure-ghostel-module)
                   (lambda () nil))
                  ((symbol-function 'ghostel--init-buffer)
                   (lambda (&rest _)
                     (setq-local ghostel--process 'event-pipe)))
                  ((symbol-function 'ghostel--start-process)
                   (lambda () (setq started t)))
                  ((symbol-function 'run-with-timer)
                   (lambda (_delay _repeat function &rest args)
                     (setq timer-call (cons function args))
                     'mock-timer))
                  ((symbol-function 'process-live-p)
                   (lambda (process) (eq process 'event-pipe)))
                  ((symbol-function 'ghostel-send-string)
                   (lambda (string) (push (cons (current-buffer) string) sent)))
                  ((symbol-function 'process-send-string)
                   (lambda (&rest _)
                     (ert-fail "Ghostel input must not use process-send-string"))))
          (setq buffer (my/ai-term--make-ghostel
                        " *my-ai-term-ghostel-launch-test*" default-directory
                        '("agent" "--flag")))
          (should started)
          (should timer-call)
          (apply (car timer-call) (cdr timer-call))
          (should (equal sent (list (cons buffer "agent --flag\n")))))
      (when (buffer-live-p buffer)
        (kill-buffer buffer)))))

(ert-deftest my/ai-term-ghostel-send-helper-uses-public-input-api ()
  "The command helper sends Ghostel input through `ghostel-send-string'."
  (my/terminal-input--load-definitions)
  (let ((my/ai-term-backend 'ghostel)
        sent)
    (with-temp-buffer
      (setq-local ghostel--process 'event-pipe)
      (cl-letf (((symbol-function 'process-live-p)
                 (lambda (process) (eq process 'event-pipe)))
                ((symbol-function 'ghostel-send-string)
                 (lambda (string) (push (cons (current-buffer) string) sent)))
                ((symbol-function 'process-send-string)
                 (lambda (&rest _)
                   (ert-fail "Ghostel input must not use process-send-string"))))
        (my/ai-term--send (current-buffer) "status")
        (should (equal sent (list (cons (current-buffer) "status\n"))))))))

;;; terminal-input-tests.el ends here
