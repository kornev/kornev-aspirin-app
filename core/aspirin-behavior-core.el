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
;;; aspirin-behavior-core.el

(defcustom aspirin-auto-save t
  "Non-nil values enable Aspirin's auto save."
  :type 'boolean
  :group 'aspirin)

(defcustom aspirin-flyspell nil
  "Non-nil values enable Aspirin's flyspell support. Can be slow."
  :type 'boolean
  :group 'aspirin)

(defvar aspirin-after-make-console-frame-hook nil
  "Hook to run after creating a new TTY frame.")

(defvar aspirin-after-make-window-system-frame-hook nil
  "Hook to run after creating a new window-system frame.")

(add-hook 'after-make-frame-functions
          (lambda (frame)
            (with-selected-frame frame
              (run-hooks (if window-system
                             'aspirin-after-make-window-system-frame-hook
                           'aspirin-after-make-console-frame-hook)))))

;; shell environment
(let ((paths (list
              (substitute-in-file-name "$HOME/bin")
              (substitute-in-file-name "$HOME/.local/bin")
              (substitute-in-file-name "$HOME/.anaconda3/bin")
              "/usr/local/bin"
              "/usr/bin"
              "/bin"
              "/usr/sbin"
              "/sbin")))
  (setenv "PATH" (mapconcat 'identity paths path-separator))
  (setq exec-path (append paths (list exec-directory))))

;; reduce the frequency of garbage collection by making it happen on
;; each 50MB of allocated data (the default is on every 0.76MB)
(aspirin-add-hook 'aspirin-after-init-hook
  (setq gc-cons-threshold 52428800))

;; warn when opening files bigger than 1MB
(setq large-file-warning-threshold 1048576)

;; suppressing ad-handle-definition warnings
(setq ad-redefinition-action 'accept)

;; switch between different languages by using C-\
(defvar aspirin-toggle-english-input-hook nil
  "Hook called after toggle English input method.")
(defvar aspirin-toggle-russian-input-hook nil
  "Hook called after toggle Russian input method.")

;; FIXME: don't use `ESC' in `translit+' mode, it's will disable `key-chord'
(defun aspirin--toggle-input-method ()
  (interactive)
  (toggle-input-method)
  (message "Keyboard input method is %s" current-input-method)
  (cond
   ((string-equal current-input-method default-input-method)
    (run-hooks 'aspirin-toggle-russian-input-hook))
   (t
    (run-hooks 'aspirin-toggle-english-input-hook))))

;; keyboard shortcut to change language
(global-set-key (kbd "C-\\") #'aspirin--toggle-input-method)

;; disable beeping
(global-set-key [wheel-left] 'ignore)
(global-set-key [wheel-right] 'ignore)
(setq ring-bell-function
  (lambda ()
    (unless (memq this-command '(isearch-abort abort-recursive-edit
                                 exit-minibuffer keyboard-quit mwheel-scroll
                                 down up next-line previous-line backward-char
                                 forward-char))
            (ding))))

;; smooth scrolling
;; TODO: remove `linum-delay' variable after migrate to `nlinum'
(setq linum-delay t  ; by default
      scroll-margin 0
      jit-lock-defer-time 0.01
      scroll-conservatively 50
      scroll-preserve-screen-position t
      mouse-wheel-progressive-speed nil)

;; enable y/n answers
(fset 'yes-or-no-p 'y-or-n-p)

;; enable pair mode
(electric-pair-mode t)

;; store all backup and autosave files
(let ((aspirin-backup-dir (expand-file-name ".backup/" aspirin-home-dir)))
  (setq backup-directory-alist `((".*" . ,aspirin-backup-dir))  ; #
        auto-save-file-name-transforms `((".*" ,aspirin-backup-dir t))  ; ~
        auto-save-list-file-prefix (concat aspirin-backup-dir ".saves-")))

;; store the undo-tree history (used evil-mode)
(aspirin-install 'undo-tree
  (setq-default undo-tree-history-directory-alist `((".*" . ,(expand-file-name ".undo" aspirin-home-dir)))
                undo-tree-auto-save-history t)
  (aspirin-diminish-after-load 'undo-tree-mode 'undo-tree))

;; disable protection against simultaneous editing
(setq create-lockfiles nil)

;; revert buffers automatically when underlying files are changed externally
(global-auto-revert-mode t)

;; where to read abbreviations
(setq abbrev-file-name (expand-file-name ".dabbrev" aspirin-home-dir))

;; don’t ask the user before saving
(setq save-abbrevs 'silently)

;; hippie expand is dabbrev expand on steroids
(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-expand-list
                                         try-expand-line
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol))

;; use hippie-expand instead of dabbrev
(global-set-key (kbd "M-/") #'hippie-expand)

;; smart tab behavior - indent or complete
(setq tab-always-indent 'complete)

;; meaningful names for buffers with the same name
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward
      uniquify-separator "/"
      uniquify-after-kill-buffer-p t      ; rename after killing uniquified
      uniquify-ignore-buffers-re "^\\*")  ; don't muck with special buffers

;; remembers your location in a file when saving files
(save-place-mode)
(setq save-place-file (expand-file-name ".saveplace" aspirin-home-dir))

;; savehist keeps track of some history
(require 'savehist)
(setq savehist-additional-variables
      '(search-ring regexp-search-ring)  ; search entries
      savehist-autosave-interval 60  ; save every minute
      savehist-file (expand-file-name ".savehist" aspirin-home-dir))  ; keep the home clean
(savehist-mode t)

;; save recent files
(require 'recentf)
(setq recentf-save-file (expand-file-name ".recentf" aspirin-home-dir)
      recentf-max-saved-items 100
      recentf-max-menu-items 15
      recentf-auto-cleanup 'never  ; disable recentf-cleanup on Emacs start,
                                   ; because it can cause problems with remote files
      recentf-exclude '("/\\.\\w+$"  ; use only \w in name of cache files
                        "\\.cache/"
                        "\\.log\\|~$"
                        "/tmp\\|temp\\|elpa/"))
(recentf-mode t)


;; bookmarks
(require 'bookmark)
(setq bookmark-default-file (expand-file-name ".bookmarks" aspirin-home-dir)
      bookmark-save-flag 1)


;; automatically save buffers associated with files on buffer switch
;; and on windows switch
(defun aspirin-behavior--save-modified-buffer ()
  "Save the current buffer if `aspirin-auto-save' is not nil."
  (when (and aspirin-auto-save
             buffer-file-name
             (buffer-modified-p (current-buffer))
             (file-writable-p buffer-file-name))
    (save-buffer)))

;; advise all window switching functions
(dolist (x '(switch-to-buffer
             other-window
             windmove-up
             windmove-down
             windmove-left
             windmove-right))
  (advice-add x :before (lambda (&rest _)
                          (aspirin-behavior--save-modified-buffer))))

(add-hook 'mouse-leave-buffer-hook
          #'aspirin-behavior--save-modified-buffer)

;; ls does not support --dired
(when (aspirin-or (lambda (s) (eq system-type s))
                  '(darwin berkeley-unix windows-nt))
  (setq-default dired-listing-switches "-Avhn"
                ls-lisp-use-insert-directory-program nil))

;; show less information in dired buffers
(aspirin-add-hook 'dired-mode-hook
  (setq dired-hide-details-hide-symlink-targets nil)
  (dired-hide-details-mode 1))

;; reuse current buffer by pressing 'a'
(put 'dired-find-alternate-file 'disabled nil)

;; always delete and copy recursively
(setq dired-recursive-deletes 'always
      dired-recursive-copies 'always)

;; if there is a dired buffer displayed in the next window, use its
;; current subdir, instead of the current subdir of this dired buffer
(setq dired-dwim-target t)

;; directory where thumbnail images are stored
(setq image-dired-dir (expand-file-name ".imagedired" aspirin-home-dir))

;; make a shell script executable automatically on save
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; vertical ediff mode
(setq ediff-split-window-function 'split-window-horizontally)

;; setup the url package directory
(setq url-configuration-directory (expand-file-name ".url" aspirin-home-dir))

;; file which keeps connection history for tramp
(setq tramp-persistency-file-name (expand-file-name ".tramp" aspirin-home-dir))

(provide 'aspirin-behavior-core)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved callargs)
;; End:

;;; aspirin-behavior-core.el ends here
