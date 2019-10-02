;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(load-file "~/local.el")

(display-time-mode 1)
(setq doom-theme 'doom-tomorrow-night)
(setq doom-font (font-spec :family "Dank Mono" :size 12))

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
(after! 'em-term
  (add-to-list 'eshell-visual-commands "watch"))

(after! typescript-mode
  (set-formatter! 'prettier "cat"))
(bind-key "C-M-<tab>" 'company-other-backend)

(after! go-mode
  (rainbow-delimiters-mode-enable)
)


(after! elfeed
  (setq elfeed-search-filter "@2-days-ago +unread"))


(defun rainbow-highlighter (level responsive display)
   (intern (format "rainbow-delimiters-depth-%d-face" (+ (mod level 9) 1)))
)
(setq highlight-indent-guides-highlighter-function 'rainbow-highlighter)
;; (setq highlight-indent-guides-character ?░)
;; (setq highlight-indent-guides-character ?┋)
;; (setq highlight-indent-guides-character ?→)
;; (setq highlight-indent-guides-character ?⇥)
;; (setq highlight-indent-guides-character ?┆)

(setq counsel-dash-browser-func 'browse-url)

;; TODO: make this a proper package when it is stable
(load-file "~/.doom.d/commitit.el")
