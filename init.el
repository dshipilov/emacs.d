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

;; important rc scripts
(defconst ds/rc-main
  '("common-defs.el"
    "common-prog.el"
    "editor.el")
  "Important startup scripts")

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
      (delete-duplicates
       (append ds/rc-main (ds/elisp-files (ds/profile-item "rc/")))))

;; direct customizations into separate files
(setq custom-file (ds/profile-item "settings.el"))

(defvar customization-files
  (list custom-file)
  "Customization target alternatives")

;; yet another file for machine-specific customizations
(add-to-list 'customization-files
 (let* ((sys-name (downcase (system-name)))
         (host-name
          (progn
            (string-match "\\([^.]+\\)" sys-name)
            (match-string 1 sys-name)))
         (os-name
          (case system-type
            ('windows-nt 'cygwin "winnt")
            ('gnu/linux "linux")
            ('darwin "macos")
            (otherwise "unix"))))
    (ds/profile-item (format "%s-%s-settings.el"
                             host-name os-name)))
 t)

;; load customization files in order
(mapc (lambda (file)
        (load file 'noerror))
      customization-files)
