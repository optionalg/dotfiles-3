# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
#export ZSH_THEME="dstufft"
export ZSH_THEME="hmarr"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew git osx zsh-syntax-highlighting)

source $HOME/.shellconfig
source $ZSH/oh-my-zsh.sh

autoload predict-on
zle -N predict-on
zle -N predict-off
bindkey '^Z'   predict-on
bindkey '^X^Z' predict-off
zstyle ':predict' verbose true
setopt interactivecomments

bindkey '\C-x\C-e' edit-command-line

# speed up git completion
__git_files () {
    _wanted files expl 'local files' _files
}

# Customize to your needs...
export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/usr/local/share/npm/bin:/Users/harry/bin

