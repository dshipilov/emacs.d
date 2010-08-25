;;; prog-modes.el --- common pieces for programming modes
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

;; elisp-mode
(defun ds/elisp-mode-hook ()
  (eldoc-mode 1)
  (auto-fill-mode 1)
  (paredit-mode 1)
  (setq tab-width 2))
(ds/add-prog-hook 'emacs-lisp-mode-hook 'ds/elisp-mode-hook)

;; fsharp-mode
(autoload 'fsharp-mode "fsharp" "Major mode for editing F# code." t)
(autoload 'run-fsharp "inferior-fsharp" "F# Interactive." t)

(add-to-list 'auto-mode-alist '("\\.fs[iylx]?$" . fsharp-mode))

(defun ds/fsharp-mode-hook () t)
(ds/add-prog-hook 'fsharp-mode-hook 'ds/fsharp-mode-hook)

;; haskell-mode
(load "haskell-site-file")

(defun ds/haskell-mode-hook ()
  (turn-on-haskell-doc-mode)
  (turn-on-haskell-identation))

(ds/add-prog-hook 'haskell-mode-hook 'ds/haskell-mode-hook)
