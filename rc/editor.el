;;; editor.el --- emacs editing configuration
;;
;; Author: Denis Shipilov <denis.shipilov@gmail.com>
;;

;; enable answering yes/no questions with just one character
(defalias 'yes-or-no-p 'y-or-n-p)

;; scrolling behaviour
(setq
  scroll-margin 0
  scroll-conservatively 100000
  scroll-up-aggresively 0
  scroll-down-aggresively 0
  scroll-preserve-screen-position t)

;; ibuffer
(require 'ibuffer)

(setq
  ibuffer-default-shrink-to-minimum-size t)

;; uniquify
(require 'uniquify)

(setq
  uniquify-buffer-name-style 'post-forward
  uniquify-strip-common-suffix t
  uniquify-ignore-buffers-re "^\\*")

;; minibuffer completions with ido
(require 'ido)

(ido-mode 'both) ;; use for buffers and files/directories
(setq
  ido-confirm-unique-completion t
  ido-enable-last-directory-history t
  ido-save-directory-list-file (ds/profile-item "tmp/ido-history"))

;; dired
(setq dired-recursive-copies 'always
      dired-recursive-deletes 'top
      dired-dwim-target t)

(add-hook 'dired-mode-hook
          (lambda ()
            (define-key dired-mode-map (kbd "<return>")
              'dired-find-alternate-file)
            (define-key dired-mode-map (kbd "a")
              'dired-advertised-find-file)
            (define-key dired-mode-map (kbd "^")
              (lambda ()
                (interactive)
                (find-alternate-file "..")))))

(put 'dired-find-alternate-file 'disabled nil)

;; misc settings
(setq
 default-major-mode 'text-mode
 initial-scratch-message ";; try some elisp code here\n\n"
 kill-whole-line t
 require-final-newline t)

;; tweaks to simplify editing files with local root permissions
(defconst ds/tramp-root-file-prefix "/sudo:root@localhost:")
(defvar ds/root-editing-mode nil)

;; (add-hook 'find-file-hook
;;           (lambda ()
;;             (if (string-match
;;                  (concat "^" ds/tramp-root-file-prefix) buffer-file-name)
;;                 (face-remap-set-base 'mode-line 'ds/mode-line-root-mode)
;;                 )
;;             ))
