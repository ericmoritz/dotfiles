;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(display-time-mode 1)
(setq doom-theme 'doom-tomorrow-night)
(setq doom-font (font-spec :family "Source Code Pro" :size 14))
(set-formatter! 'yq "cat")
(setq prettier-js-args '(
  "--trailing-comma" "all"
  "single-quote" "true"
))
(setq
 doom-modeline-major-mode-icon t
 doom-modeline-persp-name t
 org-clock-clocked-in-display 'both
 )
