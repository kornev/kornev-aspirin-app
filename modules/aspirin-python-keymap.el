;;; -*- coding: utf-8; lexical-binding: t -*-
;;
;; This file is part of Aspirin.
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
;;; aspirin-python-keymap.el

(defun aspirin-python--shell-send-and-go ()
  (interactive)
  (if (and transient-mark-mode mark-active)
      (python-shell-send-region (point) (mark))
    (beginning-of-line)
    (if (looking-at "def")
        (progn
          (python-shell-send-defun nil)
          (python-nav-end-of-defun)
          (python-nav-forward-statement))
      (python-shell-send-region (point-at-bol) (point-at-eol))
      (python-nav-forward-statement))
    (let ((previous-selected-window (selected-window)))
      (python-shell-switch-to-shell)
      (select-window previous-selected-window))))

(aspirin-add-hook 'anaconda-view-mode-hook
  (aspirin-nmap "q" 'quit-window))

(aspirin-add-hook 'python-mode-hook
  (aspirin-nmap (kbd "C-]") 'anaconda-mode-find-definitions)
  (aspirin-nmap (kbd "C-t") 'anaconda-mode-go-back)
  (aspirin-nmap "gd" 'anaconda-mode-find-assignments)
  (aspirin-nmap "gD" 'anaconda-mode-find-assignments))

(aspirin-add-hook 'python-mode-hook
  (aspirin-nmap (kbd "K") #'anaconda-mode-show-doc)
  (local-set-key (kbd "<C-return>") #'aspirin-python--shell-send-and-go)
  (local-set-key (kbd "<s-return>") #'aspirin-python--shell-send-and-go))

(provide 'aspirin-python-keymap)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-python-keymap.el ends here
