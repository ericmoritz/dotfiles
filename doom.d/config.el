;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(load-file "~/local.el")

(display-time-mode 1)
(setq doom-theme 'doom-one)
(setq doom-font (font-spec :family "Dank Mono" :size 14))
(set-formatter! 'yq "cat")

(setq typescript-indent-level 2)

(setq
 doom-modeline-major-mode-icon t
 doom-modeline-persp-name t
 org-clock-clocked-in-display 'both
 )

(setq projectile-project-search-path eam/projectile-project-search-path)

 (set-frame-parameter (selected-frame) 'alpha '(100 . 95))
 (add-to-list 'default-frame-alist '(alpha . (100 . 95)))
;; Use typescript-mode for tsx files because web-mode isn't good for typescript
(add-to-list 'auto-mode-alist '("\\.tsx$" . typescript-mode))

(add-hook! 'org-mode-hook
  (setq org-agenda-span 14))

