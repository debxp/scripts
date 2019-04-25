#!/usr/bin/env bash

#
# requires 'recode' (sudo apt install recode)
#

URL="https://mail.google.com/mail/feed/atom/unread"


BASEDIR="$(dirname $0)"


checkgmail() {
    MSG="$(curl -sSfku $1:$2 $URL |  grep -oPm1 "(?<=<title>)[^<]+" | sed '1d;s/^/\&bull; /')"
    if [[ ! -z "${MSG}" ]]; then
        COUNT="$(echo "${MSG}" | wc -l)"
        if [[ $COUNT -gt 1 ]]; then
            NUMERAL="s"
            MBMSG="$(recode html..utf-8 <<< "${MSG}")"
        fi
        notify-send -u normal -i "gmail" "$(echo -e "$1 has ${COUNT} unread message${NUMERAL}!\n\n$MBMSG")"
        aplay -q "${BASEDIR}/new-message.wav" &
    fi
}

# Multiple accounts...
checkgmail "gmail1" "password1"
checkgmail "gmail2" "password2"

exit 0
