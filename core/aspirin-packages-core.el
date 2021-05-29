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
;;; aspirin-packages-core.el

(require 'package)

;; Path to install
(setq package-user-dir (expand-file-name ".packages" aspirin-home-dir))

;; Sources list
(push '("melpa-stable" . "https://stable.melpa.org/packages/") package-archives)
(push '("melpa" . "https://melpa.org/packages/") package-archives)

;; Pin-Priority
(push '("melpa" . 1) package-archive-priorities)

(progn
  (setq warning-suppress-log-types '((package reinitialization)))
  (package-initialize))

(setf (symbol-function 'aspirin-packages--refresh-contents)
      (let ((refresh-timestamp 0))
        (lambda (&optional force)
          (let ((current-timestamp (fround (time-to-seconds (current-time)))))
            (when (or force
                      (> (- current-timestamp refresh-timestamp) 3600))
              (package-refresh-contents)
              (setq refresh-timestamp current-timestamp))))))

(defun aspirin-packages--pin-archive (pkg id)
  (push (cons pkg id) package-pinned-packages))

(defun aspirin-packages--install-based-on-priority (pkg)
  (unless (package-installed-p pkg)
    (aspirin-packages--refresh-contents)
    (package-install pkg t)))

(defun aspirin-packages--install-from-archive (pkg id)
  (unless (package-installed-p pkg)
    (aspirin-packages--pin-archive pkg id)
    (aspirin-packages--refresh-contents t)
    (aspirin-packages--install-based-on-priority pkg)))

(defun aspirin-packages--install (pkg)
  (if (listp pkg)
      (aspirin-packages--install-from-archive (car pkg) (cdr pkg))
    (aspirin-packages--install-based-on-priority pkg)))

(defmacro aspirin-install (pkg &rest body)
  "Install package PKG."
  (declare (indent defun))
  `(progn
     (aspirin-packages--install ,pkg)
     ,@body))

(defmacro aspirin-prepare (pkg &rest body)
  "Install and wrap PKG to `with-eval-after-load'."
  (declare (indent defun))
  `(progn
     (aspirin-packages--install ,pkg)
     (with-eval-after-load ,pkg ,@body)))

(defmacro aspirin-require (pkg &rest body)
  "Install and require PKG with default priorities."
  (declare (indent defun))
  `(progn
     (aspirin-packages--install ,pkg)
     (require ,pkg)
     ,@body))

(provide 'aspirin-packages-core)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-packages-core.el ends here
