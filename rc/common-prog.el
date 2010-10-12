;;; common-prog.el --- common definitions for programming modes
;;
;; Author: Denis Shipilov <denis.shipilov@gmail.com>
;;

;; common hook
(defun ds/prog-common-hook ()
  (local-set-key [return] 'newline-and-indent)
  (local-set-key (kbd "C-c C-c") 'comment-dwim)
  ;; (local-set-key (kbd "C-c ;") 'comment-add)
  (setq tab-width 4)
  (setq indent-tabs-mode nil)
  (add-hook 'before-save-hook 'ds/buffer-cleanup))

(defsubst ds/add-prog-hook (prog-major-mode hook)
  (add-hook prog-major-mode 'ds/prog-common-hook)
  (add-hook prog-major-mode hook))
