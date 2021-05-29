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
;;; aspirin-eink-theme.el

(aspirin-add-hook 'aspirin-after-init-hook
  (aspirin-install 'eink-theme
    (load-theme 'eink t))
  (custom-set-faces
   ;; org
   '(org-level-1 ((t (:inherit org-level-1 :height 1.1))))
   '(org-level-2 ((t (:inherit org-level-2 :height 1.0))))
   '(org-level-3 ((t (:inherit org-level-3 :height 1.0))))
   '(org-level-4 ((t (:inherit org-level-4 :height 1.0))))
   '(org-level-5 ((t (:inherit org-level-5 :height 1.0))))
   '(org-level-6 ((t (:inherit org-level-6 :height 1.0))))
   ;; vdiff
   '(vdiff-change-face ((t (:inherit diff-added))))
   '(vdiff-refine-changed ((t (:background "#ffe9ff"))))))

(provide 'aspirin-eink-theme)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-eink-theme.el ends here
