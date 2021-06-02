;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(load-file "~/local.el")

(setq
 ;; Line numbers are pretty slow all around. The performance boost of
 ;; disabling them outweighs the utility of always keeping them on.
 display-line-numbers-type nil

 ;; lsp-ui-sideline is redundant with eldoc and much more invasive, so
 ;; disable it by default.
 lsp-ui-sideline-enable nil
 lsp-enable-indentation nil
 lsp-enable-on-type-formatting nil
 lsp-enable-symbol-highlighting nil
 lsp-enable-file-watchers nil

 ;; Disable help mouse-overs for mode-line segments (i.e. :help-echo text).
 ;; They're generally unhelpful and only add confusing visual clutter.
 mode-line-default-help-echo nil
 show-help-function nil

 doom-theme 'doom-one
 doom-font (font-spec :family "JuliaMono" :size 14)

 doom-modeline-major-mode-icon t
 doom-modeline-persp-name t

 projectile-project-search-path eam/projectile-project-search-path

 ;; Trigger completion immediately.
 company-idle-delay 0

 ;; Number the candidates (use M-1, M-2 etc to select completions).
 company-show-numbers t

 org-use-property-inheritance t
 org-clock-clocked-in-display 'both
 org-columns-default-format "%60ITEM(Task) %PRIORITY %TODO %6Effort(Estim){:} %SCHEDULED %6CLOCKSUM(Clock) %TAGS %TICKET"

 evil-split-window-below t
 evil-vsplit-window-right t
 )

;; Use typescript-mode for tsx files because web-mode isn't good for typescript
(add-to-list 'auto-mode-alist '("\\.tsx$" . typescript-mode))

(after! go-mode
  (rainbow-delimiters-mode-enable)
  )
(setq-hook! 'go-mode-hook +format-with-lsp nil)

(after! yaml-mode
  (rainbow-delimiters-mode-enable))


(after! elfeed
  (setq elfeed-search-filter "@14-days-ago +unread +mustread"))

(after! typescript-mode
  (setq typescript-indent-level 2))


(defun rainbow-highlighter (level responsive display)
  (intern (format "rainbow-delimiters-depth-%d-face" (+ (mod level 9) 1))))


(setq highlight-indent-guides-highlighter-function 'rainbow-highlighter)

(setq counsel-dash-browser-func 'browse-url)


;; Add the persp name to the titlebar
(setq
 frame-title-format '((:eval (let
                                 ((name (safe-persp-name (get-current-persp))))
                               (if name (format "#%s — " name))
                               "%b — Doom Emacs"))))

;; Org mode stuff
;;


(map!
 :map haskell-mode-map
 :localleader
 "f" #'ormolu-format-buffer)

;; (after! haskell-mode
;;         (add-hook 'haskell-mode-hook 'ormolu-format-on-save-mode))


(after! 'lsp-mode  ; try this or similar
  (lsp-register-custom-settings
   '(
     ("pyls.plugins.pyls_mypy.enabled" t t)
     ("pyls.plugins.pyls_mypy.live_mode" t t)
     )
   ))

(defun branch ()
  "Return the current branch for the current file."
  (let*
      ((backend (vc-backend buffer-file-name)))
    (substring vc-mode (+ (if (eq backend 'Hg) 2 3) 2)))
  )

