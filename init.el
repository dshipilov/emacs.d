;;; init.el --- emacs initialization file

;; Author: Denis Shipilov <denis.shipilov@gmail.com>

;; Keep only generic definitions/bootstraping code here
;; All the configuration details are factorized into separate rc-scripts

(require 'cl)

(defsubst ds/profile-item (item)
  (expand-file-name (concat user-emacs-directory item)))

(defsubst ds/prepend-load-path (path-list)
  (setq load-path (append path-list load-path)))

(defun ds/scan-directories (dir filter)
  (append
   (if (funcall filter dir) (list dir))
   (reduce (lambda (acc elm)
             (append acc
                     (if (file-directory-p elm)
                         (ds/scan-directories elm filter))))
           (directory-files dir t "\\w[a-zA-Z0-9.-]*$")
           :initial-value nil)))

(defun ds/elisp-files (dir &optional full)
  (directory-files dir full "\\.elc?$"))

;; rc scripts list
(defconst ds/rc-scripts
  '("defs"
    "generic"
    "misc-bindings"
    "text-modes"
    "prog-modes"
    "snippets"
    "platform"))

;; direct customizations into separate file
(setq custom-file (ds/profile-item "settings.el"))
(load custom-file 'noerror)

;; setup load path
(ds/prepend-load-path
 (ds/scan-directories (ds/profile-item "packages/site-lisp/") 'ds/elisp-files))

;; initialize elpa packages
(setq package-user-dir (ds/profile-item "packages/elpa"))
(when (require 'package "package.el")
  (package-initialize))

;; run rc-scripts
(mapc (lambda (entry)
        (let
            ((rc-file (ds/profile-item (concat "rc/" entry))))
          (load (file-name-sans-extension rc-file) t)))
      ds/rc-scripts)
