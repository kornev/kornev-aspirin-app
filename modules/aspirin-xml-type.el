;;; -*- coding: utf-8; lexical-binding: t -*-
;;
;; This file is NOT part of Emacs.
;; Copyright (C) 2017  Vadim Kornev
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;
;;; aspirin-xml-type.el

(push '("\\.plist$" . nxml-mode) auto-mode-alist)
(push '("\\.pom$" . nxml-mode) auto-mode-alist)

(aspirin-add-hook 'nxml-mode-hook
  (setq-local mode-name "XML")
  (setq-local nxml-slash-auto-complete-flag t)
  (setq-local nxml-child-indent 4))

(provide 'aspirin-xml-type)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-xml-type.el ends here
