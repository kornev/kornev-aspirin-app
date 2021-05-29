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
;;; aspirin-typescript-lang.el

(aspirin-install 'typescript-mode
  (aspirin-add-hook 'typescript-mode-hook
    (progn
      (aspirin-tab-width-local 2)
      (setq-local typescript-indent-level 2))
    (setq-local mode-name "TypeScript")))

(aspirin-install 'tide
  (aspirin-add-hook 'typescript-mode-hook
    (tide-setup)
    (aspirin-diminish 'tide-mode)
    (setq-local company-backends '((company-tide :with company-yasnippet)))
    (add-hook 'before-save-hook #'tide-format-before-save nil t))
  (aspirin-add-hook 'tide-mode-hook
    (aspirin-nmap (kbd "C-]") #'tide-jump-to-definition)
    (aspirin-nmap (kbd "C-t") #'tide-jump-back)
    (aspirin-nmap "K" #'tide-documentation-at-point)))

(provide 'aspirin-typescript-lang)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-typescript-lang.el ends here
