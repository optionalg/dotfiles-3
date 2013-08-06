# vim: ft=sh

if [ -f ~/.reminders ]; then
    echo "$(tput bold)Reminders:$(tput sgr0)"
    cat ~/.reminders | sed 's/^/  * /'
fi

