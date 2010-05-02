alias ls='ls --color=auto'
alias l="ls -F"
alias ll="ls -lh"
alias la="ls -A"

if [ -f /usr/bin/pacman-color ]; then
    alias pacman="pacman-color"
fi
