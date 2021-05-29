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
;;; aspirin-rust-lang.el

(aspirin-prepare 'rust-mode
  (aspirin-add-hook 'rust-mode-hook
;;    (setq-local rust-format-on-save t)
    (setq-local compile-command "cargo run ")
;;    (progn
;;      (setq-local rust-indent-offset 2)
;;      (aspirin-tab-width-local 2))
    ))

(aspirin-prepare 'cargo)

;; SEE: https://github.com/racer-rust/emacs-racer/issues/91
(aspirin-install 'racer
  (with-eval-after-load 'rust-mode
    (aspirin-add-hook 'rust-mode-hook
      (racer-mode)
      (aspirin-diminish 'racer-mode))))

(aspirin-install 'flycheck-rust
  (with-eval-after-load 'rust-mode
    (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)))

(aspirin-install 'company-racer
  (with-eval-after-load 'rust-mode
    (aspirin-add-hook 'rust-mode-hook
      (setq-local company-backends '((company-racer :with company-yasnippet))))))

(with-eval-after-load 'rust-mode
  (aspirin-add-hook 'racer-help-mode-hook
    (aspirin-nmap "q" 'quit-window))
  (aspirin-add-hook 'rust-mode-hook
    (aspirin-nmap (kbd "C-]") #'racer-find-definition)
    (aspirin-nmap (kbd "C-t") #'pop-tag-mark)
    (aspirin-nmap "K" #'racer-describe)))

(provide 'aspirin-rust-lang)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-rust-lang.el ends here
