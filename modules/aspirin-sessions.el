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
;;; aspirin-sessions.el

(defvar aspirin-sessions-home-dir
  (expand-file-name ".sessions" aspirin-home-dir)
  "Directory to save desktop sessions.")

(defvar aspirin-sessions-current-name nil
  "Current desktop session name.")

(defun aspirin-sessions--full-path ()
  (expand-file-name aspirin-sessions-current-name
                    aspirin-sessions-home-dir))

(defun aspirin-sessions--list-of-saved ()
  (when (file-exists-p aspirin-sessions-home-dir)
    (seq-difference (directory-files aspirin-sessions-home-dir)
                    '("." ".."))))

(defun aspirin-sessions-name ()
  (interactive)
  (if aspirin-sessions-current-name
      (message "Desktop name: %s" aspirin-sessions-current-name)
    (message "No named desktop loaded")))

(defun aspirin-sessions-set-name (name)
  (interactive
    (list (completing-read "Enter desktop name: " (aspirin-sessions--list-of-saved))))
  (setq aspirin-sessions-current-name name))

;; FIXME: Gets a chance to restore incorrect state.
;;        Example: Incorrect font-lock parenthesis in `aspirin.config'
;;        after restore state. Mode `rainbow-delimiters-mode' also
;;        should not have been loaded.
(defun aspirin-sessions-save ()
  (interactive)
  (when (null aspirin-sessions-current-name)
    (call-interactively #'aspirin-sessions-set-name))
  (let ((dir (aspirin-sessions--full-path)))
    (make-directory dir t)
    (desktop-save dir))
  (aspirin-sessions-name))

(defun aspirin-sessions-close ()
  (interactive)
  (when (and aspirin-sessions-current-name
             (y-or-n-p (format "Save current session: %s?"
                               aspirin-sessions-current-name)))
    (call-interactively #'aspirin-sessions-save)))

(defun aspirin-sessions-open ()
  (interactive)
  (when aspirin-sessions-current-name
    (call-interactively #'aspirin-sessions-close))
  (call-interactively #'aspirin-sessions-set-name)
  (desktop-change-dir (aspirin-sessions--full-path)))

(provide 'aspirin-sessions)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-sessions.el ends here
