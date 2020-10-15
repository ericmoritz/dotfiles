(after! python
  (set-ligatures! 'python-mode
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
  (set-ligatures! 'typescript-mode
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

(after! javascript-mode
  (set-ligatures! 'javascript-mode
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
  (set-ligatures! 'go-mode
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
