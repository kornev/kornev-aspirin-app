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
;;; aspirin-git-lift.el

(aspirin-install 'gitconfig-mode
  (aspirin-add-hook 'gitconfig-mode-hook
    (aspirin-whitespace-reset '(face empty trailing lines-tail)
                              '(empty trailing))))
(aspirin-install 'gitignore-mode)
(aspirin-install 'gitattributes-mode)

(aspirin-require 'diff-hl
  (global-diff-hl-mode)
  (diff-hl-flydiff-mode))

(provide 'aspirin-git)  ; (provide 'aspirin-git-lift)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-git-lift.el ends here
