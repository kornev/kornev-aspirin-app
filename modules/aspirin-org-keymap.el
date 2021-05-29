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
;;; aspirin-org-keymap.el

(aspirin-add-hook 'org-mode-hook
  (evil-declare-key 'normal org-mode-map
    (kbd "M-h") #'org-metaleft
    (kbd "M-j") #'org-metadown
    (kbd "M-k") #'org-metaup
    (kbd "M-l") #'org-metaright
    (kbd "M-H") #'org-shiftmetaleft
    (kbd "M-J") #'org-shiftmetadown
    (kbd "M-K") #'org-shiftmetaup
    (kbd "M-L") #'org-shiftmetaright)
  (evil-define-key 'normal special-mode-map
    (kbd "q") #'quit-window))

(aspirin-add-hook 'org-mode-hook
  (local-set-key (kbd "M-p") #'org-preview-latex-fragment)  ; C-c C-c remove
  (local-set-key (kbd "<s-return>") #'org-babel-execute-maybe))

(provide 'aspirin-org-keymap)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-org-keymap.el ends here
