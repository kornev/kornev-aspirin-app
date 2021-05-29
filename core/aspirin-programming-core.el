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
;;; aspirin-programming-core.el

;; SEE: https://www.python.org/dev/peps/pep-0350
(defun aspirin-programming--font-lock-comment-annotations ()
  "Highlight a bunch of well known comment annotations.

This functions should be added to the hooks of major modes for programming."
  (font-lock-add-keywords
   nil '(("\\<\\(\\(FIX\\(ME\\)?\\|TODO\\|NOTE\\|SEE\\):\\)"
          1 font-lock-warning-face t))))

(defun aspirin-programming--flycheck-mode-line-status-text (&optional status)
  "Get a text describing STATUS for use in the mode line.

STATUS defaults to `flycheck-last-status-change' if omitted or nil."
  (let ((text (pcase (or status flycheck-last-status-change)
                (`not-checked "")
                (`no-checker " -")
                (`running " *")
                (`errored " !")
                (`finished
                 (let-alist (flycheck-count-errors flycheck-current-errors)
                   (if (or .error .warning)
                       (format " %s/%s" (or .error 0) (or .warning 0))
                     "")))
                (`interrupted " -")
                (`suspicious " ?"))))
    text))

(aspirin-add-hook 'prog-mode-hook
  (aspirin-programming--font-lock-comment-annotations)
  (display-line-numbers-mode)
  (progn  ; comment auto fill
    (set (make-local-variable 'comment-auto-fill-only-comments) t)
    (auto-fill-mode t)  ; SPC, RET
    (aspirin-diminish 'auto-fill-function))
  (progn  ; highlight parentheses
    (rainbow-delimiters-mode)
    (setq-local show-paren-mode t)))

;; enable on-the-fly syntax checking
(aspirin-install 'flycheck
  (aspirin-add-hook 'prog-mode-hook
    (flycheck-mode)
    (setq-local flycheck-mode-line
                '(:eval (aspirin-programming--flycheck-mode-line-status-text)))))

;; autocomplete configuration
(aspirin-require 'company
  (setq
   company-idle-delay 0.3  ; default 0.5
   company-minimum-prefix-length 2  ; minimum prefix character number for auto complete
   company-tooltip-limit 10
   company-tooltip-align-annotations t  ; align annotations to the right tooltip border
   company-tooltip-flip-when-above t  ; invert the navigation direction if
                                      ; the completion `popup-isearch-match is
                                      ; displayed on top (happens near the bottom
                                      ; of windows)
   company-selection-wrap-around t  ; loop over candidates
   company-transformers '(company-sort-by-occurrence))
  (aspirin-diminish 'company-mode)
  (global-company-mode t))

;; use aspirin-projectile
;; project management
(aspirin-require 'projectile
  (setq
    projectile-enable-caching t
    projectile-file-exists-local-cache-expire (* 5 60)
    projectile-cache-file (expand-file-name ".projectilecache" aspirin-home-dir)
    projectile-known-projects-file (expand-file-name ".projectilemarks" aspirin-home-dir)
    ;projectile-known-projects-file (expand-file-name ".prjmarks" aspirin-home-dir)
    projectile-tags-command "ctags-exuberant -Re -f \"%s\" %s"
    projectile-mode-line '(:eval (list " " (projectile-project-name)))
    projectile-use-git-grep t)  ; grep not great in git project
  (setq-default shell-file-name "sh")  ; used for `projectile-grep'
  (add-hook 'prog-mode-hook 'projectile-mode))  ; `initial-major-mode' or bug

;; enable tab completion in the `eval-expression' minibuffer
;; (for reading Lisp expressions)
(define-key read-expression-map (kbd "TAB") 'completion-at-point)

;; for historical reasons, underscore is word class instead of
;; symbol class
(modify-syntax-entry ?_ "w" (standard-syntax-table))  ; evil?

;; template system
(aspirin-install 'yasnippet
  (setq-default yas-minor-mode-map (make-sparse-keymap)
                yas--minor-mode-menu (make-sparse-keymap))
  (require 'yasnippet)

  ;; disable default snippets
  (setq yas-snippet-dirs (remq 'yas-installed-snippets-dir yas-snippet-dirs))
  (add-to-list 'yas-snippet-dirs (expand-file-name "snippets" aspirin-personal-dir))
  (yas-reload-all)

  ;; use `hippie-expand' for snippet extension
  (add-to-list 'hippie-expand-try-functions-list 'yas-hippie-try-expand)

  ;; select ambiguous prompt
  (setq yas-prompt-functions '(yas-ido-prompt yas-no-prompt))

  ;; enable yasnippet for all company backends
  (setq company-backends
        (mapcar (lambda (backend)
                  (if (and (listp backend)
                           (member 'company-yasnippet backend))
                      backend
                    (append (if (consp backend) backend (list backend))
                            '(:with company-yasnippet))))
                company-backends))

  ;; use `yas-minor-mode' on a per-buffer basis
  (add-hook 'prog-mode-hook #'yas-minor-mode)
  (aspirin-diminish 'yas-minor-mode))

(defmacro aspirin-expand-yasnippet (content)
  "Expand snippet CONTENT at current point."
  `(lambda ()
    (interactive)
    (yas-expand-snippet (yas-lookup-snippet ,content))))

(provide 'aspirin-programming-core)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-programming-core.el ends here
