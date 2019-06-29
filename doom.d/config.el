;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(display-time-mode 1)
(setq doom-theme 'doom-dracula)
(setq doom-font (font-spec :family "Monoid" :size 12))
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
