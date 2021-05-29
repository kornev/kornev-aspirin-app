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
;;; aspirin-elisp-lang.el

(aspirin-add-hook 'emacs-lisp-mode-hook
  (setq-local comment-start ";; ")
  (setq-local mode-name "Elisp")
  (aspirin-tab-width-local 2)

  ;; recompile your elc when saving an elisp file
  (aspirin-add-hook-local 'after-save-hook
    (when (and (string-prefix-p aspirin-home-dir (file-truename buffer-file-name))
               (file-exists-p (byte-compile-dest-file buffer-file-name)))
      (emacs-lisp-byte-compile)))

  ;; disable flycheck warning while editing emacs lisp scripts
  (with-eval-after-load 'flycheck
    (setq-local flycheck-highlighting-mode 'sexps)
    (setq-local flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

  ;; don't check doc style in Emacs Lisp test files
  (let ((file-name (buffer-file-name)))
    (when (and file-name (string-match-p ".*-tests?\\.el$" file-name))
      (setq-local flycheck-checkers '(emacs-lisp)))))

(aspirin-add-hook 'emacs-lisp-mode-hook
  (evil-declare-key 'normal emacs-lisp-mode-map (kbd "C-]") #'find-function-at-point))

(provide 'aspirin-elisp-lang)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-elisp-lang.el ends here
