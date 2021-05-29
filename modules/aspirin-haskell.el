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
;;; aspirin-haskell.el

(aspirin-install 'flycheck-haskell)
(aspirin-install 'company-ghc)

(aspirin-prepare 'haskell-mode
  (with-eval-after-load 'flycheck
    (add-hook 'flycheck-mode-hook #'flycheck-haskell-setup))
  (add-to-list 'company-backends 'company-ghc)
  (setq
   company-ghc-show-info t
   haskell-process-suggest-no-warn-orphans nil
   haskell-process-suggest-add-package nil
   haskell-process-suggest-language-pragmas nil
   haskell-process-suggest-overloaded-strings nil
   haskell-process-suggest-restart nil
   haskell-process-auto-import-loaded-modules t
   haskell-process-log t
   haskell-tags-on-save t
   haskell-interactive-popup-errors nil
   haskell-interactive-mode-scroll-to-bottom t
   haskell-doc-prettify-types nil
   haskell-hoogle-command nil))  ; show doc in browser

(aspirin-add-hook 'haskell-mode-hook
  (haskell-indentation-mode t)
  (interactive-haskell-mode t)
  (haskell-doc-mode)
  (haskell-decl-scan-mode)
  (progn  ; call `ghc-init' with out `ghc-check-syntax' function
    (defadvice ghc-check-syntax (around ghc-check-syntax-stub activate))
    (ghc-init))
  (if (eq (haskell-process-type) 'stack-ghci)
      (setq-local flycheck-disabled-checkers '(haskell-ghc))
    (progn
      (read-only-mode)
      (message "Set 'write mode' only on a stack project!")
      (setq-local flycheck-disabled-checkers '(haskell-stack-ghc))))
  (aspirin-diminish 'haskell-doc-mode)
  (aspirin-diminish 'interactive-haskell-mode)
  (aspirin-tab-width-local 2))

(evil-set-initial-state 'haskell-interactive-mode 'insert)
(evil-define-key 'insert haskell-interactive-mode-map
  (kbd "RET") 'haskell-interactive-mode-return)
(evil-define-key 'normal haskell-interactive-mode-map
  (kbd "RET") 'haskell-interactive-mode-return)

;; SEE: https://github.com/haskell/haskell-mode/issues/1265
(defun haskell-evil-open-above ()
  (interactive)
  (evil-digit-argument-or-evil-beginning-of-line)
  (haskell-indentation-newline-and-indent)
  (evil-previous-line)
  (haskell-indentation-indent-line)
  (evil-append-line nil))

(defun haskell-evil-open-below ()
  (interactive)
  (evil-append-line nil)
  (haskell-indentation-newline-and-indent))

(aspirin-add-hook 'haskell-mode-hook
  (aspirin-nmap (kbd "C-]") #'haskell-mode-jump-to-def-or-tag)
  (aspirin-nmap (kbd "o") #'haskell-evil-open-below)
  (aspirin-nmap (kbd "O") #'haskell-evil-open-above))

(provide 'aspirin-haskell)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-haskell.el ends here
