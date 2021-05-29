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
;;; aspirin-crux-lift.el

;; SEE: https://github.com/bbatsov/crux

(defun aspirin-rename-file-and-buffer ()  ; crux-rename-file-and-buffer
  "Rename current buffer and if the buffer is visiting a file, rename it too."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (rename-buffer (read-from-minibuffer "New name: " (buffer-name)))
      (let* ((new-name (read-from-minibuffer "New name: " filename))
             (containing-dir (file-name-directory new-name)))
        (make-directory containing-dir t)
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

(defalias 'aspirin-rename-buffer-and-file #'aspirin-rename-file-and-buffer)

(defun aspirin-delete-file-and-buffer ()  ; crux-delete-file-and-buffer
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (if (vc-backend filename)
          (vc-delete-file filename)
        (when (y-or-n-p (format "Are you sure you want to delete %s? " filename))
          (delete-file filename delete-by-moving-to-trash)
          (message "Deleted file %s" filename)
          (kill-buffer))))))

(defalias 'aspirin-delete-buffer-and-file #'aspirin-delete-file-and-buffer)

(defun aspirin-recentf-find-file ()  ; crux-recentf-find-file
  "Find a recent file using ido."
  (interactive)
  (let ((file (completing-read "Choose recent file: "
                               (mapcar #'abbreviate-file-name recentf-list)
                               nil t)))
    (when file
      (find-file file))))

(defun aspirin-switch-to-prev-buffer ()  ; crux-switch-to-previous-buffer
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(provide 'aspirin-crux-lift)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-crux-lift.el ends here
