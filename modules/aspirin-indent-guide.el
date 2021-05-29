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
;;; aspirin-indent-guide.el

;; SEE: https://github.com/mrkkrp/vimish-fold/issues/22
;; SEE: https://github.com/zk-phi/indent-guide/issues/42
;; NOTE: It's very slow
(aspirin-install 'indent-guide
  (setq-default indent-guide-recursive t
                indent-guide-threshold 1)
  (aspirin-diminish-after-load 'indent-guide-mode 'indent-guide)
  (add-hook 'prog-mode-hook 'indent-guide-mode))

(provide 'aspirin-indent-guide)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-indent-guide.el ends here
