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
;;; aspirin-translit+.el

(quail-define-package "translit+" "Cyrillic" "Tr+" t
  "This keymap is equals to keymap from www.translit.ru"
  nil t t t t nil nil nil nil nil t)

(quail-define-rules
  ("a" ?а) ("A" ?А)
  ("b" ?б) ("B" ?Б)
  ("v" ?в) ("V" ?В)
  ("g" ?г) ("G" ?Г)
  ("d" ?д) ("D" ?Д)
  ("e" ?е) ("E" ?Е)
  ("jo" ?ё) ("yo" ?ё) ("ö" ?ё) ("Jo" ?Ё) ("JO" ?Ё) ("Yo" ?Ё) ("YO" ?Ё) ("Ö" ?Ё)
  ("zh" ?ж) ("Zh" ?Ж) ("ZH" ?Ж)
  ("z" ?з) ("Z" ?З)
  ("i" ?и) ("I" ?И)
  ("j" ?й) ("J" ?Й)
  ("k" ?к) ("K" ?К)
  ("l" ?л) ("L" ?Л)
  ("m" ?м) ("M" ?М)
  ("n" ?н) ("N" ?Н)
  ("o" ?о) ("O" ?О)
  ("p" ?п) ("P" ?П)
  ("r" ?р) ("R" ?Р)
  ("s" ?с) ("S" ?С)
  ("t" ?т) ("T" ?Т)
  ("u" ?у) ("U" ?У)
  ("f" ?ф) ("F" ?Ф)
  ("h" ?х) ("x" ?х) ("H" ?Х) ("X" ?Х)
  ("c" ?ц) ("C" ?Ц)
  ("ch" ?ч) ("Ch" ?Ч) ("CH" ?Ч)
  ("sh" ?ш) ("Sh" ?Ш) ("SH" ?Ш)
  ("w" ?щ) ("shh" ?щ) ("W" ?Щ) ("Shh" ?Щ) ("SHh" ?Щ) ("SHH" ?Щ)
  ("#" ?ъ) ("##" ?Ъ)
  ("y" ?ы) ("Y" ?Ы)
  ("'" ?ь) ("''" ?Ь)
  ("je" ?э) ("ä" ?э) ("Je" ?Э) ("JE" ?Э) ("Ä" ?Э)
  ("ju" ?ю) ("yu" ?ю) ("ü" ?ю) ("Ju" ?Ю) ("JU" ?Ю) ("Yu" ?Ю) ("YU" ?Ю) ("Ü" ?Ю)
  ("ja" ?я) ("ya" ?я) ("q" ?я) ("Ja" ?Я) ("JA" ?Я) ("Ya" ?Я) ("YA" ?Я) ("Q" ?Я))

(provide 'aspirin-translit+)

;;; aspirin-translit+.el ends here
