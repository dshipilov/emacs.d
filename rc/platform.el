;;; platform.el --- platform specific settings
;;
;; Author: Denis Shipilov <denis.shipilov@gmail.com>
;;

(defun ds/setup-on-linux ())

(defun ds/setup-on-mac ())

(defun ds/setup-on-windows ()
  (prefer-coding-system 'windows-1251))

(case system-type
  (windows-nt (ds/setup-on-windows))
  (gnu/linux (ds/setup-on-linux))
  (darwin (ds/setup-on-mac)))

(if ds/bin-path-list
    (setenv "PATH" (concat (getenv "PATH")
                           (ds/pack-path-list ds/bin-path-list))))
