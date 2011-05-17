;;; init.el --- emacs initialization file

;; Author: Denis Shipilov <denis.shipilov@gmail.com>

;; Keep only generic definitions/bootstraping code here
;; All the configuration details are factorized into separate rc-scripts

(defsubst ds/profile-item (item)
  (expand-file-name (concat user-emacs-directory item)))

(defsubst ds/elisp-files (dir &optional full)
  (directory-files dir full "\\.elc?$"))

;; main rc scripts
(defconst ds/rc-main
  '("common-defs.el"
    "packages.el"
    "common-prog.el"
    "faces.el"
    "editor.el")
  "Main startup scripts.")

;; run rc-scripts
(let 
    ((load-entry
      (lambda (entry)
        (let
            ((rc-file (ds/profile-item (concat "rc/" entry))))
          (load (file-name-sans-extension rc-file) t)))))
  (mapc load-entry
	ds/rc-main)
  (mapc (lambda (entry)
	  (if (not (memq entry ds/rc-main))
	      (funcall load-entry entry)))
	(ds/elisp-files (ds/profile-item "rc/"))))

;; load customizations
(setq custom-file (ds/profile-item "settings.el"))
(load custom-file)

;; load machine-specific customizations
(load ds/machine-settings-name t)
