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
;;; aspirin-zenburn-theme.el

(aspirin-add-hook 'aspirin-after-init-hook
  (aspirin-install 'zenburn-theme
    (load-theme 'zenburn t))

  ;; turn off the 3d formatting
  (dolist (face '(header-line mode-line mode-line-inactive))
    (set-face-attribute face nil :box nil))

  (set-face-attribute 'match nil :background "#3F3F3F")

  (setq evil-emacs-state-cursor '("#CC9393" box)
        evil-normal-state-cursor '("#DCDCCC" box)
        evil-visual-state-cursor '("#DCDCCC" box)
        evil-insert-state-cursor '("#DCDCCC" bar)
        evil-motion-state-cursor '("#DCDCCC" box))

  (with-eval-after-load 'em-prompt
    (set-face-attribute 'eshell-prompt nil :weight 'normal :foreground "#7F9F7F")))

(provide 'aspirin-zenburn-theme)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-zenburn-theme.el ends here
