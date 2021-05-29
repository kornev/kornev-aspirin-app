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
;;; aspirin-ido-lift.el

(aspirin-install 'flx-ido)
;(aspirin-install 'ido-ubiquitous)  ; old
(aspirin-install 'ido-completing-read+)  ; new

(aspirin-add-hook 'ido-setup-hook
  (setq ido-enable-prefix nil
        ido-enable-flex-matching t
        ido-create-new-buffer 'always
        ido-use-virtual-buffers t  ; used for `ido-switch-buffer'
        ido-use-filename-at-point 'guess
        ido-max-prospects 10
        ido-save-directory-list-file (expand-file-name ".ido" aspirin-home-dir)
        ido-default-file-method 'selected-window
        ido-auto-merge-work-directories-length -1
        ido-use-faces nil  ; disable ido faces to see flx highlights
        ido-separator "\n  "
        ido-decorations '("\n> " "" "" "" "[" "]" " [No match]"
                          " [Matched]" " [Not readable]" " [Too big]" " [Confirm]"))
  ;(ido-ubiquitous-mode t)  ; recursive load
  (flx-ido-mode t))

(aspirin-add-hook 'ido-setup-hook
  (define-key ido-common-completion-map [down]  #'ido-next-match)
  (define-key ido-common-completion-map [up]    #'ido-prev-match)
  (define-key ido-common-completion-map [right] #'next-line-or-history-element)
  (define-key ido-common-completion-map [left]  #'previous-line-or-history-element))

(aspirin-prepare 'smex  ; remember recently and most frequently used commands
  (setq smex-save-file (expand-file-name ".smex" aspirin-home-dir)))

(global-set-key (kbd "M-x") #'smex)

(provide 'aspirin-ido-lift)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-ido-lift.el ends here
