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
;; (load-theme 'doom-oceanic-next)
;; (load-theme 'doom-challenger-deep)
;; (load-theme 'doom-sourcerer)
;; (load-theme 'doom-one)
;; (load-theme 'doom-wilmersdorf)



;; Dank Mono is too wide or something, it makes everything on the right get
;; clipped
; (setq doom-font (font-spec :family "Dank Mono" :size 12))
(setq
      doom-theme 'doom-palenight
      doom-font (font-spec :family "Fira Code" :size 12)
      ;; doom-font (font-spec :family "Dank Mono" :size 12))
      doom-variable-pitch-font (font-spec :family "Noto Sans" :size 13))


;; (custom-theme-set-faces! 'doom-one
;;   `(org-priority :background ,(doom-color 'bg))
;;   `(mode-line :foreground ,(doom-color 'blue))
;;   `(mode-line-buffer-id :foreground ,(doom-color 'fg))
;;   `(mode-line-success-highlight :background ,(doom-color 'green)))

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
 org-agenda-span 14
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
;;----------------------------------------------------------------------------
;; Reason setup
;;----------------------------------------------------------------------------
;; (defun shell-cmd (cmd)
;;   "Returns the stdout output of a shell command or nil if the command returned
;;    an error"
;;   (car (ignore-errors (apply 'process-lines (split-string cmd)))))

;; (defun reason-cmd-where (cmd)
;;   (let ((where (shell-cmd cmd)))
;;     (if (not (string-equal "unknown flag ----where" where))
;;       where)))

;; (let* ((refmt-bin (or (reason-cmd-where "refmt ----where")
;;                       (shell-cmd "which refmt")
;;                       (shell-cmd "which bsrefmt")))
;;        (merlin-bin (or (reason-cmd-where "ocamlmerlin ----where")
;;                        (shell-cmd "which ocamlmerlin")))
;;        (merlin-base-dir (when merlin-bin
;;                           (replace-regexp-in-string "bin/ocamlmerlin$" "" merlin-bin))))
;;   ;; Add merlin.el to the emacs load path and tell emacs where to find ocamlmerlin
;;   (when merlin-bin
;;     (add-to-list 'load-path (concat merlin-base-dir "share/emacs/site-lisp/"))
;;     (setq merlin-command merlin-bin))

;;   (when refmt-bin
;;     (setq refmt-command refmt-bin)))

;; (require 'reason-mode)
;; (require 'merlin)
;; (add-hook 'reason-mode-hook (lambda ()
;;                               (add-hook 'before-save-hook 'refmt-before-save)
;;                               (merlin-mode)))

;; (setq merlin-ac-setup t)
;; (defun reason-mode-indent-line () t)

(defun esfmt ()
   "Format using eslint --fix"
   (interactive)
   (call-process-region (point-min) (point-max) "~/dotfiles/ansible/roles/react/files/esfmt" t t nil buffer-file-name)
)

;;; :editor evil
(setq evil-split-window-below t
      evil-vsplit-window-right t)
