function _update_ps1() {
    if [[ -z "${INSIDE_EMACS-}" ]]; then
        PS1=$($HOME_VENV/bin/powerline-shell $?)
    else
        PS1="\e[0;31m\u@\h \w> \e[m"
    fi
}

PATH="$PATH:~/.config/powerline-shell"

# Ensure that powerline-shell is installed
if [ ! -f "$HOME_VENV/bin/powerline-shell" ]; then
    "$HOME_VENV/bin/pip3" install powerline-shell
fi

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
