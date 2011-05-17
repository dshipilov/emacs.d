;;; prog-modes.el --- programming modes setup
;;
;; Author: Denis Shipilov <denis.shipilov@gmail.com>
;;

;; elisp-mode
(defun ds/elisp-mode-hook ()
  (eldoc-mode 1)
  (auto-fill-mode 1)
  ;;(enable-paredit-mode 1)
  (setq tab-width 2))
(ds/add-prog-hook 'emacs-lisp-mode-hook 'ds/elisp-mode-hook)

;; list-interaction-mode
(add-hook 'lisp-interaction-mode-hook
          (lambda ()
            (local-set-key [M-return] 'eval-print-last-sexp)))

;; fsharp-mode
(autoload 'fsharp-mode "fsharp" "Major mode for editing F# code." t)
(autoload 'run-fsharp "inferior-fsharp" "F# Interactive." t)

(add-to-list 'auto-mode-alist '("\\.fs[iylx]?$" . fsharp-mode))

(defun ds/fsharp-mode-hook () t)
(ds/add-prog-hook 'fsharp-mode-hook 'ds/fsharp-mode-hook)

;; haskell-mode
(when (load "haskell-site-file" t)
  (defun ds/haskell-mode-hook ()
    (turn-on-haskell-doc-mode)
    (turn-on-haskell-indentation))

  (ds/add-prog-hook 'haskell-mode-hook 'ds/haskell-mode-hook))
