;;; packages.el --- emacs packages initialization

;; Author: Denis Shipilov <denis.shipilov@gmail.com>

;; el-get
(add-to-list 'load-path (ds/profile-item "packages/el-get"))
(setq el-get-dir (ds/profile-item "packages/site-lisp"))
(setq el-get-sources
      '(clojure-mode
        paredit
        magit))

(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dshipilov/el-get/raw/master/el-get-my-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

(el-get)

;; ELPA
(setq package-user-dir (ds/profile-item "packages/elpa"))
(setq package-archives '(("ELPA" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")))

(add-to-list 'load-path (ds/profile-item "packages/"))
(when (require 'package "package.el")
  (package-initialize))

