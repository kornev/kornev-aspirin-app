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
;;; aspirin-eshell.el

(with-eval-after-load 'eshell
  (setq
   eshell-aliases-file (expand-file-name "aliases.eshell" aspirin-personal-dir)
   eshell-directory-name (expand-file-name ".eshell" aspirin-home-dir)
   eshell-cmpl-ignore-case t  ; `company-capf' work incorrectly
   eshell-ls-use-colors nil
   eshell-highlight-prompt nil
   eshell-banner-message ""
   eshell-history-size 1024
   eshell-hist-ignoredups t
   eshell-cp-interactive-query t
   eshell-ln-interactive-query t
   eshell-mv-interactive-query t
   eshell-rm-interactive-query t
   eshell-cp-overwrite-files nil
   eshell-ln-overwrite-files nil
   eshell-mv-overwrite-files nil
   eshell-rm-removes-directories t)
  (setq  ; tiny prompt
   eshell-prompt-regexp "^[^#$\n]* "
   eshell-prompt-function (lambda ()
                            (concat (propertize
                                     (abbreviate-file-name (eshell/pwd))
                                     'face 'eshell-prompt)
                                    " "))))

;; Startup config
(aspirin-add-hook 'eshell-mode-hook
  (progn  ; Environment
    (setq eshell-path-env (getenv "PATH"))
    (setenv "LANG" "ru_RU.UTF-8")
    (when (executable-find "cat")
      (setenv "PAGER" "cat")))
  (progn  ; Company
    (setq-local company-backends '((company-capf)))
    (setq-local company-idle-delay 0.5))
  (toggle-truncate-lines))

;; Deactivates automatic completion on remote paths.
(aspirin-add-hook 'eshell-directory-change-hook
  (if (file-remote-p default-directory)
      (setq-local company-idle-delay nil)
    (setq-local company-idle-delay 0.5)))

;; FIXME: it work correctly only if `eshell-highlight-prompt' is `nil'
(aspirin-add-hook 'eshell-mode-hook
  (aspirin-add-hook-local 'evil-insert-state-entry-hook
    ;; Move point to end of current prompt when switching to insert state.
    (when (and (eq major-mode 'eshell-mode)
               ;; Not on last line, we might want to edit within it.
               (not (eq (line-end-position) (point-max))))
      (goto-char (point-max)))))

;; FIXME: it work correctly only if `eshell-highlight-prompt' is `nil'
(aspirin-add-hook 'eshell-after-prompt-hook
  ;; Protect Eshell's prompt like Comint's prompts.
  ;; E.g. `evil-change-whole-line' won't wipe the prompt. This
  ;; is achieved by adding the relevant text properties."
  (let ((inhibit-field-text-motion t))
    (add-text-properties
     (point-at-bol)
     (point)
     '(rear-nonsticky t
       inhibit-line-move-field-capture t
       field output
       read-only t
       front-sticky (field inhibit-line-move-field-capture)))))

(provide 'aspirin-eshell)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-eshell.el ends here
