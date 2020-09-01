;;; conventional-commit.el --- description -*- lexical-binding: t; -*-

;; Author; Eric Moritz

;;; Commentary:

;; An implementation of commitzen for Emacs

;;; Code:
(defgroup commitit nil
  "An implementation of commitzen for Emacs"
  :group 'tools)

(defcustom commitit-types
  '("build" "chore" "ci" "docs" "feat" "fix" "perf" "refactor" "revert" "style" "test")
  "The list of conventional commit types"
  :type '(repeat string)
  :group 'commitit)

(defun commitit ()
  "Ask and insert the commit type."
  (interactive)
  (call-interactively #'commitit-insert-type)
  (call-interactively #'commitit-insert-scope)
  (insert ": ")
  (insert (completing-read "description: " '()))
  (insert "\n\n")
  )

(defun commitit-insert-type (choice)
  "Insert the type into the current buffer"
  (interactive (list (completing-read "type:" commitit-types)))
  (insert choice))

(defun commitit-insert-scope (choice)
    "Inserts the optional scope, empty ignores it"
  (interactive (list (completing-read "scope:" '())))
  (unless (string= "" choice)
    (insert (format "(%s)" choice)))
)

;; TODO: open a popup for the body and footer

(provide 'commitit)
;;; commitit.el ends here
