
;; -*- mode: elisp -*-

;; Path where settings and plugins are kept
(setq pearl-path-settings (expand-file-name "emacs.d/settings"
    (file-name-directory load-file-name)))

;; path where settings files are kept
(add-to-list 'load-path pearl-path-settings)

;; General settings
(require 'general-settings)

;; Ido mode
(require 'ido-settings)

;; colour settings
(require 'theme-settings)

;; save place
(require 'saveplace-settings)

;; uniquify
(require 'uniquify-settings)

;; org-mode
(require 'org-mode-settings)

