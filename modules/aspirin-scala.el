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
;;; aspirin-scala.el

(aspirin-install '(ensime . "melpa-stable")
  (setq-default
   ensime-startup-dirname (expand-file-name ".ensime" aspirin-home-dir)
   ensime-startup-notification nil
   ensime-startup-snapshot-notification nil)
  (aspirin-diminish 'ensime-mode))

(defvar aspirin-ensime-mode-hook nil
  "This hook is run, after `ensime' command.")

(aspirin-add-hook 'scala-mode-hook
  (when (fboundp 'ensime)
    (run-hooks 'aspirin-ensime-mode-hook)))

(advice-add 'ensime :after (lambda (&rest _)
                             (run-hooks 'aspirin-ensime-mode-hook)))

(aspirin-add-hook 'scala-mode-hook
  (scala-mode:goto-start-of-code)
  (progn  ; compatibility with `aggressive-indent'
    (setq scala-indent:align-forms t
          scala-indent:align-parameters t
          scala-indent:default-run-on-strategy scala-indent:operator-strategy)
    (aspirin-tab-width-local 2)))

;; don't use flycheck if ensime mode is active
;; SEE: https://github.com/ensime/ensime-emacs/issues/160
(aspirin-add-hook 'aspirin-ensime-mode-hook
  (flycheck-mode -1))

(evil-define-key 'normal ensime-popup-buffer-map
  (kbd "q") 'ensime-popup-buffer-quit-function)

(evil-define-key 'normal ensime-inspector-mode-map
  (kbd "q") 'ensime-popup-buffer-quit-function)

(aspirin-add-hook 'aspirin-ensime-mode-hook
  (aspirin-nmap (kbd "C-]") 'ensime-edit-definition)
  (aspirin-nmap (kbd "C-t") 'ensime-pop-find-definition-stack)
  (aspirin-nmap "K" 'ensime-show-doc-for-symbol-at-point))

(provide 'aspirin-scala)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-scala.el ends here
