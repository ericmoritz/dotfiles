;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(load-file "~/local.el")

;; Stolen from https://github.com/hlissner/doom-emacs-private/blob/master/config.el
(setq
      ;; Line numbers are pretty slow all around. The performance boost of
      ;; disabling them outweighs the utility of always keeping them on.
      display-line-numbers-type nil

      ;; On-demand code completion. I don't often need it.
      company-idle-delay nil

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
      show-help-function nil)



;; (display-time-mode 1)

;;; Favorite Themes
;; (load-theme 'doom-oceanic) ;; *
;; (load-theme 'doom-palenight)
;; (load-theme 'doom-vibrant)
;; (load-doom 'oceanic-theme-next)
;; (load-theme 'doom-challenger-deep)
;; (load-theme 'doom-sourcerer)
;; (load-theme 'doom-one)
;; (load-theme 'doom-wilmersdorf)
;; (load-theme 'doom-outrun-electric)

;;;;
;; Look and Feel
;;;;
(setq doom-theme 'doom-dark+)

;; mimic VS Code
(setq
      doom-font (font-spec :family "Menlo" :size 13)
      doom-variable-pitch-font (font-spec :family "SF Pro Display" :size 13))


(setq
  doom-modeline-major-mode-icon t
  doom-modeline-persp-name t
  )

(setq projectile-project-search-path eam/projectile-project-search-path)

;; (set-frame-parameter (selected-frame) 'alpha '(100 . 95))
;; (add-to-list 'default-frame-alist '(alpha . (100 . 95)))
;; Use typescript-mode for tsx files because web-mode isn't good for typescript
(add-to-list 'auto-mode-alist '("\\.tsx$" . typescript-mode))


;; Trigger completion immediately.
(setq company-idle-delay 0)

;; Number the candidates (use M-1, M-2 etc to select completions).
(setq company-show-numbers t)

(after! go-mode
  (rainbow-delimiters-mode-enable)
  (add-hook 'before-save-hook (lambda ()
                                (when (eq major-mode 'go-mode) (format-all-buffer))))
)

(after! yaml-mode
  (rainbow-delimiters-mode-enable)
)

(after! elfeed
  (setq elfeed-search-filter "@1-day-ago +unread"))


(after! typescript-mode
  (setq typescript-indent-level 2)
  (add-hook 'before-save-hook (lambda ()
                                (message "running esfmt on %s" major-mode)
                                (when (eq major-mode 'typescript-mode) (esfmt))))
)

(defun rainbow-highlighter (level responsive display)
  (intern (format "rainbow-delimiters-depth-%d-face" (+ (mod level 9) 1)))
)
(setq highlight-indent-guides-highlighter-function 'rainbow-highlighter)

(setq counsel-dash-browser-func 'browse-url)


;; Add the persp name to the titlebar
(setq
  frame-title-format '((:eval (let
                                  ((name (safe-persp-name (get-current-persp))))
                                  (if name (format "#%s — " name))
                               )) "%b — Doom Emacs"))

;; Org mode stuff
;;

(setq
 org-use-property-inheritance t
 org-clock-clocked-in-display 'both
 org-agenda-custom-commands '(
                              ;; Inbox
                              ("i" "Inbox" ((tags-todo "inbox+SCHEDULED=\"\"|projects+SCHEDULED=\"\"" )))
                              ("r" "Reading" ((tags-todo "reading" )))
 )
 org-columns-default-format "%60ITEM(Task) %PRIORITY %TODO %6Effort(Estim){:} %SCHEDULED %6CLOCKSUM(Clock) %TAGS %TICKET"
)

(after! org-capture
  (setq
   org-capture-templates '(
                            ("t" "TODO" entry (file+headline +org-capture-todo-file "Inbox") "* TODO %?")
                            ("r" "Reading" entry (file+headline +org-capture-todo-file "Reading") "* TODO %?")
                            ("s" "Someday" entry (file+headline +org-capture-todo-file "Someday") "* TODO %?")
                            ("f" "Reference" entry (file+headline +org-capture-todo-file "Reference") "* %?")
                          )
   )
)

(defun esfmt ()
   "Format using eslint --fix"
   (interactive)
   (call-process-region (point-min) (point-max) "~/dotfiles/ansible/roles/react/files/esfmt" t t nil buffer-file-name)
)

;;; :editor evil
(setq evil-split-window-below t
      evil-vsplit-window-right t)

(map!
 :map haskell-mode-map
 :localleader
 "f" #'ormolu-format-buffer)

(after! haskell-mode
        (add-hook 'haskell-mode-hook 'ormolu-format-on-save-mode)
)

(setq elfeed-db-directory (concat doom-etc-dir "elfeed/db/")
      elfeed-enclosure-default-dir (concat doom-etc-dir "elfeed/enclosures/"))

(set-irc-server! "chat.freenode.net"
  `(:tls t
    :port 6697
    :nick "ericmoritz"
    :sasl-username "ericmoritz"
    :sasl-password (lambda (&rest _) (+pass-get-secret "irc/freenode.net"))
    :channels ("#haskell-beginners" "#haskell" "#nixos")))
