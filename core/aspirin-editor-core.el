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
;;; aspirin-editor-core.el

(setq-default indent-tabs-mode nil  ; don't use tabs to indent
              tab-width 8)          ; but maintain correct appearance

(aspirin-install 'evil
  (setq-default evil-want-C-u-scroll t
                evil-want-Y-yank-to-eol t))

(aspirin-add-hook 'aspirin-after-make-console-frame-hook
  (setq evil-esc-delay 0))  ; prevent esc-key from translating to meta-key
(aspirin-add-hook 'aspirin-after-make-window-system-frame-hook
  (setq evil-esc-delay 0.01))

(setq-default evil-auto-indent nil)
(aspirin-add-list-hooks '(text-mode-hook prog-mode-hook)
  (setq-local evil-auto-indent t))

(aspirin-prepare 'key-chord
  (setq key-chord-two-keys-delay 0.3)
  (key-chord-define evil-insert-state-map "jj" #'evil-normal-state)
  (key-chord-mode t))

(aspirin-prepare 'key-seq
  (key-seq-define evil-insert-state-map "jk" #'evil-execute-in-normal-state))

(aspirin-prepare 'avy
  (setq avy-background t
        avy-style 'at-full)
  (define-key evil-normal-state-map (kbd "SPC") #'avy-goto-word-1))

(progn  ; turn on the editor!
  (evil-mode t)
  (mapc 'require '(avy key-chord key-seq)))

(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

(defun aspirin-tab-width-local (x)
  "Set distance between tab stops (for display of tab characters), in columns
and set the offset used by > and <."
  (setq-local evil-shift-width x)
  (setq-local tab-width x))

(defun aspirin-nmap (key def)
  "Define a local Evil normal state sequence."
  (define-key evil-normal-state-local-map key def))

(defun aspirin-imap (key def)
  "Define a local Evil insert state sequence."
  (define-key evil-insert-state-local-map key def))

(aspirin-add-list-hooks '(text-mode-hook conf-mode-hook prog-mode-hook)
  (aspirin-tab-width-local 4))

(progn  ; enable 'q' key in *Messages* buffer
  (aspirin-add-hook 'messages-buffer-mode-hook
    (aspirin-nmap "q" 'quit-window))
  (kill-buffer "*Messages*"))  ; restart *Messages* buffer

(provide 'aspirin-editor-core)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-editor-core.el ends here
