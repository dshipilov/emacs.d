;;; bindings.el -- miscilleneous key bindings
;;
;; Author: Denis Shipilov <denis.shipilov@gmail.com>
;;

;; toggle several UI controls
(define-key global-map (kbd "<f12>") 'speedbar-frame-mode)
(define-key global-map (kbd "C-<f10>") 'menu-bar-mode)

(define-key global-map (kbd "C-x C-b") 'ibuffer)
(define-key global-map (kbd "C-<tab>") 'other-window)

;; font size
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; ibuffer
(define-key global-map (kbd "C-`") 'ibuffer)
(add-hook 'ibuffer-hook
          (lambda ()
            (define-key ibuffer-mode-map (kbd "C-`") 'ibuffer-quit)))

;; fast buffer switching
(define-key global-map (kbd "C-<f1>")
  (lambda ()
    (interactive)
    (switch-to-buffer "*scratch*")))

(define-key global-map (kbd "C-<f12>")
  (lambda ()
    (interactive)
    (let ((buf (dired user-emacs-directory)))
      (with-current-buffer buf
        (dired-insert-subdir "rc")))))

(define-key global-map (kbd "M-<f12>")
  (lambda ()
    (interactive)
    (dired default-directory)))

(define-key global-map (kbd "C-m") 'newline-and-indent)

(define-key global-map [C-return] 'hippie-expand)

(define-key minibuffer-local-map [C-return]
  (lambda ()
    (interactive)
    (let*
        ((b (window-buffer (minibuffer-selected-window)))
         (fname (buffer-file-name b))
         (bname (buffer-name b)))
      (if fname
          (insert fname)
        (insert bname)))))
