;;; -*- coding: utf-8; lexical-binding: t -*-
;;
;; This file is part of Aspirin.
;; Copyright (C) 2018  Vadim Kornev
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
;;; aspirin-lua-lang.el

(aspirin-prepare 'lua-mode
  (aspirin-add-hook 'lua-mode-hook
    (progn
      (setq-local lua-indent-level 3)
      (aspirin-tab-width-local 3))
    (progn
      (setq-local lua-documentation-function 'eww)
      (setq-local lua-documentation-url "http://www.lua.org/manual/5.3/manual.html"))
    (setq-local lua-indent-string-contents t)

    ;(defcustom lua-jump-on-traceback t
    ;(defvar lua-electric-flag t

    ))

(aspirin-install 'company-lua
  (with-eval-after-load 'lua-mode
    (aspirin-add-hook 'lua-mode-hook
      (setq-local company-backends '((company-lua :with company-yasnippet))))))

(with-eval-after-load 'lua-mode
  (aspirin-add-hook 'lua-mode-hook
    (aspirin-nmap "K" #'lua-search-documentation)))

(provide 'aspirin-lua-lang)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-lua-lang.el ends here
