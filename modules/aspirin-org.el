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
;;; aspirin-org.el

(aspirin-add-hook 'org-mode-hook
  (progn
    (visual-line-mode)
    (aspirin-diminish 'visual-line-mode))
    (whitespace-mode -1))


;; SEE: https://github.com/eschulte/emacs24-starter-kit/issues/80
(setq org-startup-folded 'content
      org-startup-with-inline-images t
      org-babel-no-eval-on-ctrl-c-ctrl-c t
      org-catch-invisible-edits 'error
      org-completion-use-ido t
      org-hide-leading-stars t
      org-latex-preview-ltxpng-directory (expand-file-name ".ltxpng/" aspirin-home-dir)
      org-confirm-babel-evaluate nil
      org-src-fontify-natively t
      org-src-preserve-indentation t)

(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

(aspirin-add-hook 'org-mode-hook
  (flyspell-mode -1)
  (yas-minor-mode)
  (setq-local evil-auto-indent nil))

(provide 'aspirin-org)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-org.el ends here
