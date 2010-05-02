# Check for an interactive session
[ -z "$PS1" ] && return

source .bash-config/aliases.sh
source .bash-config/functions.sh
source .bash-config/templates.sh

export PATH=$PATH:/usr/local/bin
export PATH=$PATH:$HOME/bin

export EDITOR=vim

export GREP_OPTIONS='--color=auto' GREP_COLOR='1;31'

complete -cf sudo
alias sudo='sudo '

RED="\033[31;1m"
NORMAL="\033[0m"
source /usr/share/git/completion/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=1 # Show * or + next to branch
export PS1='\[\033[0;32m\]\u\[\033[0m\]:\w`r=$?; echo -n $(__git_ps1 "(%s)");\
 test $r -ne 0 && echo "\[\033[1;31m\]"`\$\[\033[0m\] '

export PYTHONSTARTUP=~/.pythonrc

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper_bashrc
export PIP_VIRTUALENV_BASE=$WORKON_HOME

