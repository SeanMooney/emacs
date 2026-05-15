;; -*- lexical-binding: t; -*-

;;early init
;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

;; Profile emacs startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s seconds with %d garbage collections."
                     (emacs-init-time "%.2f")
                     gcs-done)))

;; Silence compiler warnings as they can be pretty disruptive
(when (boundp 'native-comp-async-report-warnings-errors)
  (setq native-comp-async-report-warnings-errors nil))

;; Set the right directory to store the native comp cache
(when (boundp 'native-comp-eln-load-path)
  (add-to-list 'native-comp-eln-load-path (expand-file-name "eln-cache/" user-emacs-directory)))


;; Bootstrap straight.el before loading Org.  `org-babel-load-file' would
;; otherwise load Emacs' built-in Org first, then straight.el may later load a
;; newer Org checkout, causing repeated "Org version mismatch" warnings.
(setq straight-use-package-by-default t)

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el"
                         (or (bound-and-true-p straight-base-dir)
                             user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(require 'use-package)
(straight-use-package-mode 1)
(straight-use-package 'org)

;; load org package and our lit.org file
(require 'org)
(org-babel-load-file (expand-file-name "lit.org" user-emacs-directory))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ignored-local-variable-values '((encoding . utf-8)))
 '(straight-recipe-overrides
   '((nil
      (nongnu-elpa :type git :repo "https://github.com/emacsmirror/nongnu_elpa"
		   :depth (full single-branch) :local-repo "nongnu-elpa" :build
		   nil)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
