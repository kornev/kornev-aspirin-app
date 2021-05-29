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
;;; init.el --- Aspirin's configuration entry point.

;; Without this comment emacs25 adds (package-initialize) here
;; (package-initialize)

;; load prefers the newest version of a file
(setq load-prefer-newer t)

(defconst aspirin-home-dir (file-name-directory load-file-name)
  "The home directory of the Emacs Aspirin distribution.")
(defconst aspirin-core-dir (expand-file-name "core" aspirin-home-dir)
  "The home of Aspirin's core functionality.")
(defconst aspirin-modules-dir (expand-file-name "modules" aspirin-home-dir)
  "This directory houses all of the built-in Aspirin modules.")
(defconst aspirin-personal-dir (expand-file-name "personal" aspirin-home-dir)
  "This directory is for your personal configuration.")
(defconst aspirin-personal-modules-dir (expand-file-name "modules" aspirin-personal-dir)
  "This directory is for you personal modules.")
(defconst aspirin-config-file (expand-file-name "aspirin.conf" aspirin-personal-dir)
  "Path to the Aspirin configuration file.")

;; set fake file for custom settings
(setq custom-file (expand-file-name ".customize" aspirin-home-dir))

;; add Aspirin directories to Emacs's `load-path'
(add-to-list 'load-path aspirin-personal-modules-dir)
(add-to-list 'load-path aspirin-modules-dir)
(add-to-list 'load-path aspirin-core-dir)

(defvar aspirin-after-init-hook nil
  "This hook is run, once, just after loading all the init files.")

;; initialize core modules and aspirin.conf file
(let ((gc-cons-threshold most-positive-fixnum))
  (mapc #'require '(aspirin-common-core
                    aspirin-packages-core
                    aspirin-behavior-core
                    aspirin-appearance-core
                    aspirin-editor-core
                    aspirin-programming-core
                    aspirin-config-core))
  (if (file-exists-p aspirin-config-file)
      (load-file aspirin-config-file)
    (error "The file %s does not exist!
You must get started by copying the bundled settings file."
           aspirin-config-file)))

(run-hooks 'aspirin-after-init-hook)

;;; init.el ends here
(put 'erase-buffer 'disabled nil)
