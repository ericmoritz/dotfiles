# -*- sh-shell: bash -*-
if [ "${DOTFILES_ENV:-}" == "corsha" ]; then
    export PROJECTS="$HOME/go/src/github.com/corshatech/"
else
    export PROJECTS="$HOME/Projects"
fi
alias goto-projects="cd $PROJECTS"
