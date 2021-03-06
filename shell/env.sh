if [[ $HOST == 'hmarr-arch' ]]; then
    export M2_HOME=/opt/apache-maven-2.2.1
    export PATH=$PATH:/usr/local/bin
    export PATH=$PATH:/usr/local/scala/bin
    export PATH=$PATH:$HOME/sources/google_appengine
    export PATH=$PATH:$M2_HOME/bin
    export PATH=$PATH:$HOME/.gem/ruby/1.9.1/bin
fi

if [[ $PLATFORM == 'Darwin' ]]; then
    export CLICOLOR=1
    export LSCOLORS=dxfxcxdxbxegedabagacad
    # For homebrew-installed npm binaries
    export PATH=$PATH:/usr/local/share/npm/bin
    export NODE_PATH=/usr/local/lib/node
    export PATH=$HOME/opt/bin:$PATH
fi

export PATH=$PATH:$HOME/bin

export GREP_OPTIONS='--color=auto' GREP_COLOR='1;31'
export EDITOR=vim
