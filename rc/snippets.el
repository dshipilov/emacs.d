;;; snippets.el --- configuration for yasnippets
;;
;; Author: Denis Shipilov <denis.shipilov@gmail.com>
;;

(when (require 'yasnippet)
  (defconst ds/templates-root (ds/profile-item "etc/templates"))

  (setq
   yas/ignore-filnames-as-triggers nil
   yas/wrap-around-region t
   yas/indent-line 'auto
   yas/also-auto-indent-first-line t
   yas/trigger-key nil)

  (add-to-list 'hippie-expand-try-functions-list 'yas/hippie-try-expand)

  (setq yas/root-directory
        (list
         (ds/profile-item "etc/snippets"))
        ds/templates-root)

  (yas/initialize)
  (mapc 'yas/load-directory yas/root-directory)
)
