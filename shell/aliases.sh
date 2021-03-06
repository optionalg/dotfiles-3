if [[ $PLATFORM == "Linux" ]]; then
    alias ls='ls --color=auto'
fi
alias l="ls -F"
alias ll="ls -lh"
alias la="ls -A"

alias py="python"
alias ipy="ipython"

alias :q=exit

if [ -f /usr/bin/pacman-color ]; then
    alias pacman="pacman-color"
fi

if [[ $PLATFORM == "Darwin" ]]; then
    alias chrome="open -a \"Google Chrome\""
    alias canary="open -a \"Google Chrome Canary\""
    alias finder="open -a \"Finder\""
    alias nc=/usr/local/bin/netcat
    alias updatedb="sudo /usr/libexec/locate.updatedb"
    alias vim="mvim -v"
    alias vi="mvim -v"
fi

if [[ $PLATFORM == "Darwin" ]]; then
    alias rvim="mvim --remote-silent"
else
    alias rvim="gvim --remote-silent"
fi

alias ccat="pygmentize -f 256 -O full,style=tango"

alias bx="bundle exec"

# MAC manipulators
alias random_mac='sudo ifconfig en0 ether `openssl rand -hex 6 | sed "s/\(..\)/\1:/g; s/.$//"`'
alias restore_mac='sudo ifconfig en0 ether 20:c9:d0:7b:27:d9'

