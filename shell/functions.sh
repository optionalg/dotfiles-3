function mem {
    free -tom | grep 'Mem' | awk '{ printf "Memory usage: %dMB of %dMB (%d%%)\n", $3, $2, ($3-$7)/$2*100 }'
}

function lstree {
    echo
    olddir=`pwd`
    if [ "$1" != "" ]; then
        cd $1
    fi
    pwd

    ls -R | grep ':$' | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/  /' -e 's/-/|/'

    if [ `ls -F -1 | grep "/" | wc -l` = 0 ]; then
        echo "  -> no sub-directories"
    fi
    echo
    cd $olddir
}

function sloc {
    if [ -z $2 ]; then
        dir='.'
        ext=$1
    else
        dir=$1
        ext=$2
    fi
    find $dir -iname "*.$ext" | xargs wc -l
}

function gmail {
      curl -u harry.marr --silent "https://mail.google.com/mail/feed/atom" |\
        perl -ne 'print "\t" if /<name>/; print "$2\n" if /<(title|name)>(.*)<\/\1>/;'
}

function calc {
      echo "scale=8; $@" | bc
}

function dumbmail {
    if [ -z $1 ]; then
        port=1025
    else
        port=$1
    fi

    echo "Starting dumb mail server on localhost:$port"
    python -m smtpd -n -c DebuggingServer localhost:$port
}

function ip {
    if [ ! -z $1 ]; then
        interface=$1
    fi
    ifconfig $interface | grep 'inet ' | awk '{ print $2 }' | grep -v '127.0.0.1'
}

if [[ $PLATFORM == "Darwin" ]]; then
    function lock {
        /System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend
    }
fi

function update-ssh-config {
  curl -u gocardless https://gc-ssh-config.herokuapp.com > ~/.ssh/config
}

function gh {
  if [ ! -f .git/HEAD ]; then
    echo "'$(basename `pwd`)' is not a valid git repository"
    return 1
  fi

  branch=$(git symbolic-ref HEAD)
  branch=${branch##refs/heads/}

  url=$(git config --get remote.origin.url)
  url=${url/git\@github\.com\:/https://github.com/}
  url=$(echo $url | sed -E 's/\/(.git)?$//')

  if [ -z $1 ]; then
    url="$url/tree/$branch"
  else
    if [ -d $1 ]; then
      url="$url/tree/$branch/$1"
    else
      url="$url/blob/$branch/$1"
    fi
  fi

  open $url
}

