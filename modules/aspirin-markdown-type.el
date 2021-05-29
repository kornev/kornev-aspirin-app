;;; -*- coding: utf-8; lexical-binding: t -*-
;;
;; This file is NOT part of Emacs.
;; Copyright (C) 2019  Vadim Kornev
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
;;; aspirin-markdown-type.el

(aspirin-install 'markdown-mode)

(aspirin-add-hook 'markdown-mode-hook
  (aspirin-whitespace-reset '(face tabs lines-tail) '(empty))
  (toggle-truncate-lines)
  (setq-local markdown-enable-html nil))

(aspirin-add-hook 'markdown-mode-hook
  (custom-set-faces
   '(markdown-code-face ((t (:inherit fixed-pitch :family "PragmataPro Mono Liga"))))
   '(markdown-pre-face ((t (:inherit (markdown-code-face font-lock-constant-face) :family "PragmataPro Mono Liga"))))))

(provide 'aspirin-markdown-type)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-markdown-type.el ends here
