#!/bin/bash
#

if [ "$#" -eq 0 ]
then
	echo "Trebuie introdus numele interfetei de retea!"
	exit 1
fi

INTERFACE=$1
WHITELIST="MAC_whitelist.txt"

trap '
	echo -e "\n\nGenerarea de alerte MAC s-a incheiat!\n"
' INT


if [ ! -f "$WHITELIST" ]; then
    echo "Avertisment: Fisierul $WHITELIST nu exista."
fi


while read mac;
do
	if ! grep -q "$mac" "$WHITELIST";
	then
		echo "[ALERTA] MAC necunoscut: $mac"
	fi
	

done < <(sudo tshark -i "$INTERFACE" -T fields -e eth.src 2>/dev/null)
