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
;;; aspirin-tramp.el

(with-eval-after-load 'tramp
  (setq tramp-default-method "ssh"
        password-cache-expiry nil
        tramp-connection-timeout 5
        tramp-persistency-file-name (expand-file-name ".tramp" aspirin-home-dir)  ; history connection
        auth-sources (list  ; the .netrc file format
                      (expand-file-name "tramp.pass" aspirin-personal-dir)
                      (expand-file-name "tramp.pass.gpg" aspirin-personal-dir))))

(with-eval-after-load 'tramp  ; /sudo:[root@hostname]:[path]
  (push '(nil "\\`root\\'" "/ssh:%h:") tramp-default-proxies-alist)
  (push '((regexp-quote (system-name)) nil nil) tramp-default-proxies-alist))

(provide 'aspirin-tramp)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-tramp.el ends here
