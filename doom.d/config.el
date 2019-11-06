;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(load-file "~/local.el")

(display-time-mode 1)
;; (setq doom-theme 'doom-tomorrow-night)
(setq doom-font (font-spec :family "Dank Mono" :size 14))


(setq
 doom-modeline-major-mode-icon t
 doom-modeline-persp-name t
 )

(setq projectile-project-search-path eam/projectile-project-search-path)

(set-frame-parameter (selected-frame) 'alpha '(100 . 95))
(add-to-list 'default-frame-alist '(alpha . (100 . 95)))
;; Use typescript-mode for tsx files because web-mode isn't good for typescript
(add-to-list 'auto-mode-alist '("\\.tsx$" . typescript-mode))


;; Trigger completion immediately.
(setq company-idle-delay 0)

;; Number the candidates (use M-1, M-2 etc to select completions).
(setq company-show-numbers t)

(setq godoc-and-godef-command "go doc")

;; (setq eshell-visual-commands (push "watch" eshell-visual-commands))

(after! 'em-term
  (add-to-list 'eshell-visual-commands "watch"))


(bind-key "C-M-<tab>" 'company-other-backend)

(after! go-mode
  (rainbow-delimiters-mode-enable)
)

(after! yaml-mode
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


;; Add the persp name to the titlebar
(setq
 frame-title-format '((:eval (let
                                 ((name (safe-persp-name (get-current-persp))))
                                 (if name (format "#%s — " name))
                              )) "%b — Doom Emacs"))
;;; ~/dotfiles/doom.d/+org.el -*- lexical-binding: t; -*-
;; Org mode stuff

(setq
 org-clock-clocked-in-display 'both
 org-agenda-span 14
 org-agenda-custom-commands '(
                              ;; Inbox
                              ("i" "Inbox"
                               (
                                (tags-todo "inbox+SCHEDULED=\"\"" )
                                ))
 )
)

;;----------------------------------------------------------------------------
;; Reason setup
;;----------------------------------------------------------------------------
(defun shell-cmd (cmd)
  "Returns the stdout output of a shell command or nil if the command returned
   an error"
  (car (ignore-errors (apply 'process-lines (split-string cmd)))))

(defun reason-cmd-where (cmd)
  (let ((where (shell-cmd cmd)))
    (if (not (string-equal "unknown flag ----where" where))
      where)))

(let* ((refmt-bin (or (reason-cmd-where "refmt ----where")
                      (shell-cmd "which refmt")
                      (shell-cmd "which bsrefmt")))
       (merlin-bin (or (reason-cmd-where "ocamlmerlin ----where")
                       (shell-cmd "which ocamlmerlin")))
       (merlin-base-dir (when merlin-bin
                          (replace-regexp-in-string "bin/ocamlmerlin$" "" merlin-bin))))
  ;; Add merlin.el to the emacs load path and tell emacs where to find ocamlmerlin
  (when merlin-bin
    (add-to-list 'load-path (concat merlin-base-dir "share/emacs/site-lisp/"))
    (setq merlin-command merlin-bin))

  (when refmt-bin
    (setq refmt-command refmt-bin)))

(require 'reason-mode)
(require 'merlin)
(add-hook 'reason-mode-hook (lambda ()
                              (add-hook 'before-save-hook 'refmt-before-save)
                              (merlin-mode)))

(setq merlin-ac-setup t)
(defun reason-mode-indent-line () t)

(defun esfmt ()
  "Format using eslint --fix"
  (interactive)
  (call-process-region (point-min) (point-max) "~/dotfiles/ansible/roles/react/files/esfmt" t t nil buffer-file-name)
  )


(after! typescript-mode
  (setq typescript-indent-level 2)
  (set-formatter! 'prettier "cat")
  (add-hook 'before-save-hook (lambda ()
                                (message "running esfmt on %s" major-mode)
                                (when (eq major-mode 'typescript-mode) (esfmt))))
)
