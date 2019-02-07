# -*- sh-shell: bash -*-
# -*- sh-shell: bash -*-
if [ "$OS" == "macos" ]; then
    [[ ! "$(which fortune)" ]] && brew install fortune
fi

if [ ! $(which neofetch) ]; then
    if [[ $(uname) == "Darwin" ]]; then
        brew install neofetch
    else
        sudo pacman -S neofetch
    fi
fi

neofetch
[[ -d ~/src/fortunes ]] && fortune ~/src/fortunes/ || fortune
