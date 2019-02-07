function _update_ps1() {
    PS1=$($HOME_VENV/bin/powerline-shell $?)
}

PATH="$PATH:~/.config/powerline-shell"

# Ensure that powerline-shell is installed
if [ ! -f "$HOME_VENV/bin/powerline-shell" ]; then
    "$HOME_VENV/bin/pip3" install powerline-shell
fi

if [[ -z "${INSIDE_EMACS-}" && $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
