;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(load-file "~/local.el")

(display-time-mode 1)
(setq doom-theme 'doom-tomorrow-night)
(setq doom-font (font-spec :family "Dank Mono" :size 14))

;; yq steals my YAML comments
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

;; Trigger completion immediately.
(setq company-idle-delay 0)

;; Number the candidates (use M-1, M-2 etc to select completions).
(setq company-show-numbers t)

(setq godoc-and-godef-command "go doc")

(after! 'eshell
    (push "watch" eshell-visual-commands)
)
(after! typescript-mode
  (set-formatter! 'prettier "cat")
  )

(bind-key "C-M-<tab>" 'company-other-backend)

;; TODO: make this a proper package when it is stable
(load-file "~/.doom.d/commitit.el")
