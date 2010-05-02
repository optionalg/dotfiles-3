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

function reload {
    source ~/.bashrc
}
