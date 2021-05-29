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
;;; aspirin-common-core.el

(defmacro aspirin-add-hook (hook &rest body)
  "Define hook with lambda."
  (declare (indent defun))
  `(add-hook ,hook (lambda () ,@body)))

(defmacro aspirin-add-list-hooks (hooks &rest body)
  "Define list of hooks with lambda."
  (declare (indent defun))
  `(dolist (hook ,hooks) (add-hook hook (lambda () ,@body))))

(defmacro aspirin-add-hook-local (hook &rest body)
  "Define local hook with lambda."
  (declare (indent defun))
  `(add-hook ,hook (lambda () ,@body) nil t))

(defmacro aspirin-global-set-key (key &rest body)
  "Give KEY a global binding as BODY."
  (declare (indent defun))
  `(global-set-key (kbd ,key) (lambda ()
                                (interactive)
                                ,@body)))

(defun aspirin-add-load-path (env)
  "Add value of environment variable in load path."
  (add-to-list 'load-path (getenv env) t))

(defun aspirin-add-env-path (path)
  "Add PATH to environment variable \"PATH\" and to `exec-path'."
  (setenv "PATH" (concat (getenv "PATH") path-separator path))
  (add-to-list 'exec-path path t))

(defun aspirin-add-env-path-ahead (path)
  "Add PATH ahead to environment variable \"PATH\" and to `exec-path'."
  (setenv "PATH" (concat path path-separator (getenv "PATH")))
  (add-to-list 'exec-path path))

(defun aspirin-or (f xs)
  "Try F on each element in XS until one succeeds."
  (let ((x (car xs)))
    (cond
     ((not x) nil)
     ((funcall f x) x)
     (t (aspirin-or f (cdr xs))))))

(defun aspirin-diminish (mode)
  "Diminish mode-line display of minor MODE."
  (let ((minor (assq mode minor-mode-alist)))
    (when minor
        (setcdr minor (list "")))))

(defun aspirin-diminish-after-load (mode file)
  "After loading FILE, execute `aspirin-diminish' on MODE."
  (with-eval-after-load file (aspirin-diminish mode)))

(provide 'aspirin-common-core)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-common-core.el ends here
