# Check for an interactive session
[ -z "$PS1" ] && return

HOST=$(hostname)
PLATFORM=$(uname)

if [ -d ~/.bashrc.d ]; then
    for file in ~/.bashrc.d/*; do
        source $file
    done
fi

if [ -f ~/.shellcommands.py ]; then
    eval `python ~/.shellcommands.py`
fi

complete -cf sudo
alias sudo='sudo '

RED="\033[31;1m"
NORMAL="\033[0m"
if [[ $HOST == "hmarr-arch" ]]; then
    source /usr/share/git/completion/git-completion.bash
fi
if [[ $HOST == "hmarr-iplatform" ]]; then
    source /etc/bash_completion.d/git
fi
if [[ $HOST == "hmarr-mbp" ]]; then
    source /usr/local/etc/bash_completion.d/git-completion.bash
fi
GIT_PS1_SHOWDIRTYSTATE=1 # Show * or + next to branch
export PS1='\[\033[0;32m\]\u\[\033[0m\]:\w`r=$?; echo -n $(__git_ps1 "(%s)");\
 test $r -ne 0 && echo "\[\033[1;31m\]"`\$\[\033[0m\] '

if [ $TERM = xterm ]; then
    PROMPT_COMMAND='echo -ne "\033]0;[`basename "${PWD}"`]\007"'
fi

export PYTHONSTARTUP=~/.pythonrc

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
if [[ $HOST == "hmarr-arch" ]]; then
    source /usr/bin/virtualenvwrapper_bashrc
else
    source /usr/local/bin/virtualenvwrapper.sh
fi
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true
