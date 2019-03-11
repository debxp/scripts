#!/bin/bash

ask=`zenity --list --title="Sair" --text="Opções" --column="0" "Logout" "Suspender" "Reiniciar" "Desligar" --hide-header`

if [ "$ask" == "Logout" ]; then
    openbox --exit &
fi

if [ "$ask" == "Suspender" ]; then
    systemctl suspend
fi

if [ "$ask" == "Reiniciar" ]; then
    systemctl reboot
fi

if [ "$ask" == "Desligar" ]; then
    systemctl poweroff
fi
exit 0
