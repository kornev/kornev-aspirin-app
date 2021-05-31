;;; -*- coding: utf-8; lexical-binding: t -*-
;;
;; This file is NOT part of Emacs.
;; Copyright (C) 2021  Vadim Kornev
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
;;; aspirin-ligatures-lift.el

;; NOTE: If non-nil, show the non-prettified version of a symbol when
;;       point is on it.
(setq prettify-symbols-unprettify-at-point t)

;; NOTE: Use PragmataPro_Mono_R_liga_0829
(defun aspirin-pragmata-pro-ligatures ()
  '(;;; PUA Ligatures
    ;; U+E900
    ("!="  . #XE900)
    ("!==" . #XE901)
    ("!=<" . #XE904)
    ("#("  . #XE90C)
    ("#_"  . #XE90D)
    ("#{"  . #XE90E)
    ("#?"  . #XE90F)

    ;;; U+E910
    ("##"  . #XE910)
    ("#_(" . #XE911)
    ("#["  . #XE912)

    ;;; U+E920
    ("%="  . #XE920)
    ("&%"  . #XE92C)
    ("&&"  . #XE92D)
    ("&+"  . #XE92E)
    ("&-"  . #XE92F)

    ;;; U+E930
    ("&/"  . #XE930)
    ("&="  . #XE931)
    ("&&&" . #XE932)
    ("$>"  . #XE93A)

    ;;; U+E940
    ("*>"  . #XE946)
    ("++"  . #XE94C)
    ("+++" . #XE94D)
    ("+="  . #XE94E)
    ("+>"  . #XE94F)

    ;;; U+E950
    ("++=" . #XE950)

    ;;; U+E960
    ("--"  . #XE960)
    ("-<"  . #XE961)
    ("-<<" . #XE962)
    ("-="  . #XE963)
    ("->"  . #XE964)
    ("->>" . #XE965)
    ("---" . #XE966)
    ("-->" . #XE967)
    ("-+-" . #XE968)
    ("-\\/" . #XE969)
    ("-|>" . #XE96A)
    ("-<|" . #XE96B)
    ("-|"  . #XE96E)
    ("-||" . #XE96F)

    ;;; U+E970
    ("-|:" . #XE970)
    (".="  . #XE979)

    ;;; U+E990
    ("//=" . #XE994)
    ("/="  . #XE995)
    ("/==" . #XE996)
    ("/-:" . #XE998)
    ("/->" . #XE999)
    ("/=>" . #XE99A)
    ("/-<" . #XE99B)
    ("/=<" . #XE99C)
    ("/=:" . #XE99D)

    ;;; U+E9A0
    (":="  . #XE9AC)
    (":=>" . #XE9AE)
    (":-\\" . #XE9AF)

    ;;; U+E9B0
    (":=\\" . #XE9B0)
    (":-/" . #XE9B1)
    (":=/" . #XE9B2)
    (":-|" . #XE9B3)
    (":=|" . #XE9B4)
    (":|-" . #XE9B5)
    (":|=" . #XE9B6)

    ;;; U+E9C0
    ("<$>" . #XE9C0)
    ("<*"  . #XE9C1)
    ("<*>" . #XE9C2)
    ("<+>" . #XE9C3)
    ("<-"  . #XE9C4)
    ("<<=" . #XE9C5)
    ("<="  . #XE9C6)
    ("<=>" . #XE9C7)
    ("<>"  . #XE9C8)
    ("<|>" . #XE9C9)
    ("<<-" . #XE9CA)
    ("<|"  . #XE9CB)
    ("<=<" . #XE9CC)
    ("<~"  . #XE9CD)
    ("<~~" . #XE9CE)
    ("<<~" . #XE9CF)

    ;;; U+E9D0
    ("<$"  . #XE9D0)
    ("<+"  . #XE9D1)
    ("<!>" . #XE9D2)
    ("<@>" . #XE9D3)
    ("<#>" . #XE9D4)
    ("<%>" . #XE9D5)
    ("<^>" . #XE9D6)
    ("<&>" . #XE9D7)
    ("<?>" . #XE9D8)
    ("<.>" . #XE9D9)
    ("</>" . #XE9DA)
    ("<\\>" . #XE9DB)
    ("<:>" . #XE9DD)
    ("<~>" . #XE9DE)
    ("<**>" . #XE9DF)

    ;;; U+E9E0
    ("<<^" . #XE9E0)
    ("<="  . #XE9E1)
    ("<->" . #XE9E2)
    ("<!--" . #XE9E3)
    ("<--" . #XE9E4)
    ("<~<" . #XE9E5)
    ("<==>" . #XE9E6)
    ("<|-" . #XE9E7)
    ("<||" . #XE9E8)
    ("<<|" . #XE9E9)
    ("<-<" . #XE9EA)
    ("<-->" . #XE9EB)
    ("<<==" . #XE9EC)
    ("<==" . #XE9ED)
    ("<-\\" . #XE9EE)
    ("<-/" . #XE9EF)

    ;;; U+E9F0
    ("<=\\" . #XE9F0)
    ("<=/" . #XE9F1)

    ;;; U+EA00
    ("=<<" . #XEA00)
    ("=="  . #XEA01)
    ("===" . #XEA02)
    ("==>" . #XEA03)
    ("=>"  . #XEA04)
    ("=~"  . #XEA05)
    ("=>>" . #XEA06)
    ("=~=" . #XEA07)
    ("==>>" . #XEA08)
    ("=>=" . #XEA09)
    ("=<=" . #XEA0A)
    ("=<" . #XEA0B)
    ("==<" . #XEA0C)
    ("=<|" . #XEA0D)
    ("=/=" . #XEA0E)
    ("/==" . #XEA0F)

    ;;; U+EA10
    ("=/<" . #XEA10)
    ("=|"  . #XEA11)
    ("=||" . #XEA12)
    ("=|:" . #XEA13)

    ;;; U+EA20
    (">-"  . #XEA20)
    (">>-" . #XEA22)
    (">>=" . #XEA23)
    (">=>" . #XEA24)
    (">>^" . #XEA25)
    (">>|" . #XEA26)
    (">->" . #XEA28)
    (">==" . #XEA29)
    (">="  . #XEA2A)
    (">/=" . #XEA2B)
    (">-|" . #XEA2C)
    (">=|" . #XEA2D)
    (">-\\" . #XEA2E)
    (">=\\" . #XEA2F)

    ;;; U+EA30
    (">-/" . #XEA30)
    (">=/" . #XEA31)

    ;;; U+EA40
    ("^="  . #XEA43e)
    ("^<<" . #XEA48)
    ("^>>" . #XEA49)

    ;;; U+EA50
    ("\\="  . #XEA54)
    ("\\==" . #XEA55)
    ("\\/-" . #XEA56)
    ("\\-:" . #XEA58)
    ("\\->" . #XEA59)
    ("\\=>" . #XEA5A)
    ("\\-<" . #XEA5B)
    ("\\=<" . #XEA5C)
    ("\\=:" . #XEA5D)

    ;;; U+EA60
    ("|="  . #XEA69)
    ("|>=" . #XEA6A)
    ("|>"  . #XEA6B)
    ("|+|" . #XEA6C)
    ("|->" . #XEA6D)
    ("|-->" . #XEA6E)
    ("|=>" . #XEA6F)

    ;;; U+EA70
    ("|==>" . #XEA70)
    ("|>-" . #XEA71)
    ("|<<" . #XEA72)
    ("||>" . #XEA73)
    ("|>>" . #XEA74)
    ("|-"  . #XEA75)
    ("||-" . #XEA76)
    ("||=" . #XEA77)
    ("|-:" . #XEA7A)
    ("|=:" . #XEA7B)
    ("|-<" . #XEA7C)
    ("|=<" . #XEA7D)
    ("|--<" . #XEA7E)
    ("|==<" . #XEA7F)

    ;;; U+EA80
    ("~="  . #XEA8A)
    ("~>"  . #XEA8B)
    ("~~>" . #XEA8C)
    ("~>>" . #XEA8D)
    ("[["  . #XEA8F)

    ;;; U+EA90
    ("_|_" . #XEA97)

    ;;; U+EAA0
    ("]]"  . #XEAA0)))

(defun aspirin-set-ligatures (&optional xs)
  (prettify-symbols-mode -1)
  (setq-local prettify-symbols-alist
              (mapcar (lambda (x)
                        (cons (car x)
                              (concat (list ?\C-i)
                                      (list (decode-char 'ucs (cdr x))))))
                      (or xs (aspirin-pragmata-pro-ligatures))))
  (prettify-symbols-mode))

(defun aspirin-set-ligatures-no-calt (&optional xs)
  (prettify-symbols-mode -1)
  (setq-local prettify-symbols-alist (or xs (aspirin-pragmata-pro-ligatures)))
  (prettify-symbols-mode))

(defun aspirin-ligatures-delete (ps &optional xs)
  (map-remove (lambda (k _) (member k ps))
              (or xs prettify-symbols-alist)))

(defun aspirin-ligatures-add-or-replace (ys &optional xs)
  (append ys (or xs prettify-symbols-alist)))

(provide 'aspirin-ligatures-lift)

;; Local Variables:
;; byte-compile-warnings: (not free-vars unresolved)
;; End:

;;; aspirin-ligatures-lift.el ends here
