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
;;; aspirin-sql.el

(aspirin-add-hook 'sql-mode-hook
  (aspirin-tab-width-local 2))

(aspirin-add-hook 'sql-interactive-mode-hook
  (toggle-truncate-lines))

(with-eval-after-load 'sql
  (sql-set-product 'postgres)
  (setq sql-postgres-options '("-P" "pager=off" "--no-password")))

(defun aspirin-sql--make-smart-buffer-name ()
  "Return a string that can be used to rename a SQLi buffer.
This is used to set `sql-alternate-buffer-name' within
`sql-interactive-mode'."
  (or (and (boundp 'sql-name) sql-name)
      (concat (if (not (string= "" sql-server))
                  (concat
                   (or (and (string-match "[0-9.]+" sql-server) sql-server)
                       (car (split-string sql-server "\\.")))
                   "/"))
              sql-database)))

(aspirin-add-hook 'sql-interactive-mode-hook
  (setq-local sql-alternate-buffer-name (aspirin-sql--make-smart-buffer-name))
  (sql-rename-buffer))

(defun aspirin-sql-connect (product connection)
  "Connect to an interactive session using CONNECTION settings."
  (setq sql-product product)
  (sql-connect connection))

(provide 'aspirin-sql)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-sql.el ends here
