;;; -*- coding: utf-8; lexical-binding: t -*-
;;
;; This file is part of Aspirin.
;; Copyright (C) 2018  Vadim Kornev
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
;;; aspirin-python.el

(aspirin-install 'anaconda-mode
  (aspirin-diminish-after-load 'anaconda-mode 'anaconda-mode))

(aspirin-install 'company-anaconda
  (aspirin-add-hook 'python-mode-hook
    (setq-local company-backends '((company-anaconda :with company-yasnippet)))))

(with-eval-after-load 'python
  (setq python-shell-completion-native-enable nil
        python-shell-prompt-detect-failure-warning nil
        python-shell-interpreter "ipython"
        python-shell-interpreter-args "--simple-prompt --colors=NoColor --no-confirm-exit"))

(aspirin-add-hook 'python-mode-hook
  (setq-default anaconda-mode-installation-directory (expand-file-name ".anaconda" aspirin-home-dir))
  (anaconda-mode))

(provide 'aspirin-python)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-python.el ends here
