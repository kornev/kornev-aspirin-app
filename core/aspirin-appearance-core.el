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
;;; aspirin-appearance-core.el

(defcustom aspirin-whitespace-cleanup t
  "Cleanup whitespace from file before it's saved."
  :type 'boolean
  :group 'aspirin)

(defcustom aspirin-start-in-fullscreen nil
  "Utilizing all screen estate possible."
  :type 'boolean
  :group 'aspirin)

;; frame size settings
(aspirin-add-hook 'aspirin-after-init-hook
  (if aspirin-start-in-fullscreen
      (toggle-frame-fullscreen)
    (progn  ; default frame size
      (add-to-list 'default-frame-alist '(height . 50))
      (add-to-list 'default-frame-alist '(width . 90)))))

;; hide menu bars
(aspirin-add-hook 'aspirin-after-make-console-frame-hook
  (menu-bar-mode -1))
(advice-add 'toggle-frame-fullscreen :after
            (lambda (&rest _)
              (if menu-bar-mode
                  (menu-bar-mode -1)
                (menu-bar-mode))))
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; more useful frame title
(setq frame-title-format
      '((:eval (if (buffer-file-name)
                   (abbreviate-file-name (buffer-file-name))
                 "%b"))))

;; hide startup message and echo
(setq inhibit-startup-message t)
(defun display-startup-echo-area-message ())

;; mode line settings
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)

;; turn on highlight matching brackets when cursor is on one
(progn
  (setq-default show-paren-delay 0.3)  ; to delay before showing
  (show-paren-mode t)  ; activate the needed timer
  (setq show-paren-mode nil))  ; the timer will do nothing if this is nil

;; disable annoying blink-matching-paren
(setq blink-matching-paren nil)

;; highlight the current line
(global-hl-line-mode t)

;; cleaning up the mode-line
(mapc (lambda (x) (eval-after-load (car x) '(aspirin-diminish  (cdr x))))
      '((abbrev . abbrev-mode)
        (autorevert . auto-revert-mode)
        (whitespace . whitespace-mode)
        (eldoc . eldoc-mode)
        (flyspell . flyspell-mode)))

;; rename archive mode
(aspirin-add-hook 'archive-mode-hook
  (setq-local mode-name typename))

;; color delimiters
(aspirin-install 'rainbow-delimiters)

;; whitespace-mode config
(require 'whitespace)
(setq whitespace-line-column 80
      whitespace-style '(face tabs empty trailing lines-tail))

(defun aspirin-whitespace ()
  "Keep the whitespace decent all the time (in buffer)."
  (aspirin-add-hook-local 'before-save-hook
    (when aspirin-whitespace-cleanup
      (whitespace-cleanup)))
  (setq-local whitespace-style '(face tabs trailing lines-tail))
  (whitespace-mode t)
  (setq-local whitespace-style '(empty trailing)))

(defun aspirin-whitespace-reset (visualize cleanup)
  "The whitespace style reset."
  (whitespace-mode -1)
  (setq-local whitespace-style visualize)
  (whitespace-mode t)
  (setq-local whitespace-style cleanup))

(aspirin-add-list-hooks '(text-mode-hook conf-mode-hook prog-mode-hook)
  (aspirin-whitespace))

(provide 'aspirin-appearance-core)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-appearance-core.el ends here
