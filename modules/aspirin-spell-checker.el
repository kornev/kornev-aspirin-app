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
;;; aspirin-spell-checker.el

;; FIXME: CamlCaseDon'tWorkCorrectly
;;        checked: --run-together --run-together-limit=5 --run-together-min=2
(require 'flyspell)
(setq ispell-program-name "aspell"
      ispell-silently-savep t
      ispell-personal-dictionary (expand-file-name "aspell.en_US.pws" aspirin-personal-dir)
      ispell-extra-args '("--sug-mode=ultra" "--ignore=3")
      ispell-local-dictionary-alist '(("russian"
                                       "[АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя]"
                                       "[^АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя]"
                                       "[-]" nil ("-d" "ru") nil koi8-r)
                                      ("english"
                                       "[[:alpha:]]"
                                       "[^[:alpha:]]"
                                       "[']" nil ("-d" "en_US") nil iso-8859-1))
      ispell-dictionary "english")

(aspirin-add-list-hooks '(text-mode-hook conf-mode-hook prog-mode-hook)
  (when (and aspirin-flyspell (executable-find ispell-program-name))
    (flyspell-mode)))


(aspirin-add-hook 'text-mode-hook
  (when (and aspirin-flyspell (executable-find ispell-program-name))
    (flyspell-mode)))

(aspirin-add-list-hooks '(conf-mode-hook prog-mode-hook)
  (when (and aspirin-flyspell (executable-find ispell-program-name))
    (flyspell-prog-mode)))

(aspirin-add-hook 'aspirin-toggle-english-input-hook
  (ispell-change-dictionary "english")
  (setq-local ispell-personal-dictionary (expand-file-name "aspell.en_US.pws" aspirin-personal-dir)))

(aspirin-add-hook 'aspirin-toggle-russian-input-hook
  (ispell-change-dictionary "russian")
  (setq-local ispell-personal-dictionary (expand-file-name "aspell.ru.pws" aspirin-personal-dir)))

;; TODO: to rename
(defun aspirin-add-word-to-dictionary ()
  (interactive)
  (let* ((cursor-location (point))
         (flyspell-info (flyspell-get-word))
         (word (car flyspell-info))
         (bounds (cdr flyspell-info)))
    (flyspell-do-correct #'save nil word cursor-location (car bounds) (cadr bounds) cursor-location)))

(provide 'aspirin-spell-checker)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-spell-checker.el ends here
