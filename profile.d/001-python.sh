# -*- sh-shell: bash -*-
if [ "$OS" == "macos" ]; then
    PATH=$PATH:/Users/eric/Library/Python/3.7/bin
fi

export WORKON_HOME=~/.envs
export VIRTUALENVWRAPPER_PYTHON=$(which python3)
export HOME_VENV="$WORKON_HOME/home"
mkdir -p "$WORKON_HOME"

if [ "$OS" == "macos" ]; then
  . /Users/eric/Library/Python/3.7/bin/virtualenvwrapper.sh
else
  . $(which virtualenvwrapper.sh)
fi

if [ -e "$HOME_VENV" ] && [ ! -d "$HOME_VENV" ]; then
  echo "ERROR: $HOME_VENV doesn't look like a virtualenv, this could be a problem"
elif [ ! -e "$WORKON_HOME/home" ]; then
  mkvirtualenv "home"
fi
