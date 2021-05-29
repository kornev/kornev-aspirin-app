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
;;; aspirin-js-lang.el

(aspirin-install 'js2-mode
  (push '("\\.js$" . js2-mode) auto-mode-alist)
  (aspirin-add-hook 'js2-mode-hook
    (setq-local mode-name "JS")))

(aspirin-install 'company-tern
  (aspirin-add-hook 'js2-mode-hook
    (setq-local company-backends '((company-tern :with company-yasnippet)))
    (progn
      (tern-mode)
      (aspirin-diminish 'tern-mode))))

(provide 'aspirin-js-lang)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-js-lang.el ends here
