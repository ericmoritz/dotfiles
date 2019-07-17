;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(display-time-mode 1)
(setq doom-theme 'doom-tomorrow-night)
(setq doom-font (font-spec :family "Dank Mono" :size 12))
(set-formatter! 'yq "cat")

(setq prettier-js-args '(
  "--trailing-comma" "all"
  "--single-quote" "true"
))
(setq typescript-indent-level 2)

(setq
 doom-modeline-major-mode-icon t
 doom-modeline-persp-name t
 org-clock-clocked-in-display 'both
 )

(setq
 projectile-project-search-path
  '(
    "/Users/eric/go/src/github.com/corshatech"
    "/Users/eric/src"
   )
 projectile-ignored-projects
  '(
    "~/go/src/github.com/corshatech/admin-console/packages"
   )
)

 (set-frame-parameter (selected-frame) 'alpha '(100 . 95))
 (add-to-list 'default-frame-alist '(alpha . (100 . 95)))
;; Use typescript-mode for tsx files because web-mode isn't good for typescript
(add-to-list 'auto-mode-alist '("\\.tsx$" . typescript-mode))

(add-hook! 'org-mode-hook
  (setq org-agenda-span 14))


(setq +pretty-code-symbols
      (append +pretty-code-symbols
              '(:equal     "≡"
                :not-equal "≠"
                :is        "≣"
                :isnt      "≢"
                :lte       "≤"
                :gte       "≥"
                :subseteq  "⊆"
                :arrow "→"
                :double-arrow "⇒"
                :ellipsis "…"
                :colon-eq "≔"
                :unit "∅"
                )))

(after! python
  (set-pretty-symbols! 'python-mode :merge t
    :equal      "=="
    :not-equal "!="
    :lte "<="
    :gte ">="
    :is  "is"
    :isnt "is not"
    :subseteq "issubset"

    ;; doom builtins

    ;; Functional
    :def "def"
    :lambda "lambda"
    ;; Types
    :null "None"
    :true "True" :false "False"
    :int "int" :str "str"
    :float "float"
    :bool "bool"
    :tuple "tuple"
    ;; Flow
    :not "not"
    :in "in" :not-in "not in"
    :and "and" :or "or"
    :for "for"
    :return "return" :yield "yield"))

(after! typescript-mode
  (set-pretty-symbols! 'typescript-mode :merge t
    ;; Functional
    :def "function"
    :lambda "() =>"
    :composition "compose"
    ;; Types
    :null "null"
    :unit "void"
    :true "true" :false "false"
    :float "number"
    :str "string"
    :bool "boolean"
    ;; Flow
    :not "!"
    :and "&&" :or "||"
    :for "for"
    :return "return"
    ;; Other
    :yield "import"
    :double-arrow "=>"
    :arrow "->"
    :is "==="
    :isnt "!=="
    :equal      "=="
    :not-equal "!="
    :not "!"
    :lte "<="
    :gte ">="
    :ellipsis "..."
    :yield "import"
    )
  )

(after! javascript-mode
  (set-pretty-symbols! 'javascript-mode :merge t
    :double-arrow "=>"
    :arrow "->"
    :is "==="
    :isnt "!=="
    :equal      "=="
    :not-equal "!="
    :lte "<="
    :gte ">="
    :ellipsis "..."
    )
  )
;; because I'm a monster
(after! go-mode
  (set-pretty-symbols! 'go-mode :merge t
    :equal      "=="
    :not-equal "!="
    :lte "<="
    :gte ">="
    :not "!"
    :and "&&" :or "||"

    ;; Functional
    :def "func"
    :lambda "func()"

    ;; Types
    :null "nil"
    :true "true" :false "false"
    :int "int64" :str "string"
    :float "float64"
    :bool "bool"

    ;; Flow

    :for "for"
    :in ":= range"
    :return "return"
    :yield "<-"))
