;;; text-modes.el --- common pieces for text editing modes
;;
;; Author: Denis Shipilov <denis.shipilov@gmail.com>
;;

;; Fundamental mode

;; Text mode

;; nXML mode
(require 'rng-loc)
(add-to-list 'rng-schema-locating-files (ds/profile-item "etc/schema/schemas.xml"))
