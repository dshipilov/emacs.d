;;; defs.el --- utility definitions
;;
;; Author: Denis Shipilov <denis.shipilov@gmail.com>
;;

(defun ds/init-reload ()
  "Reload emacs configuration."
  (interactive)
  (progn
    (setq debug-on-error t)
    (load (ds/profile-item "init"))))

(defalias 'ini 'ds/init-reload)

(defun ds/byte-recompile ()
  "Recompiles all elisp files in the packages directory"
  (interactive)
  (require 'bytecomp)
  (byte-recompile-directory (ds/profile-item "packages/elpa/") 0)
  (byte-recompile-directory (ds/profile-item "packages/site-lisp/") 0)
  (byte-recompile-directory (ds/profile-item "rc/") 0))

(defun ds/lorem ()
  "Insert a lorem ipsum."
  (interactive)
  (insert "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do "
          "eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim"
          "ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut "
          "aliquip ex ea commodo consequat. Duis aute irure dolor in "
          "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla "
          "pariatur. Excepteur sint occaecat cupidatat non proident, sunt in "
          "culpa qui officia deserunt mollit anim id est laborum."))

(defun ds/buffer-untabify ()
  "Replace tabs with spaces across entire current buffer."
  (interactive)
  (untabify (point-min) (point-max)))

(defun ds/buffer-indent ()
  "Indent lines in the current buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun ds/buffer-cleanup ()
  "Indent, untabify and remove any trailing whispace."
  (interactive)
  (ds/buffer-untabify)
  (delete-trailing-whitespace))

(defun* ds/ring-rotate (rn &optional (n 1))
  "Bring n-th ring element to the top position scrolling ring accordingly."
  (let* ((rn-len (ring-length rn))
        (n-mod-len (if (not (zerop rn-len)) (mod n rn-len) rn-len))))
    (if (> n-mod-len 0)
      (dotimes (i n-mod-len (ring-ref rn 0))
        (ring-insert-at-beginning rn (ring-remove rn 0)))))

(defconst ds/cyrillic-coding-systems
  (list 'iso-8859-5 'koi8-r 'cp866 'windows-1251))
