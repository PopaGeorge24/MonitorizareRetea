#!/bin/bash
#


if [ "$#" -eq 0 ]
then
    echo "Trebuie introdus numele interfetei de retea!"
    exit 1
fi

INTERFACE=$1
WHITELIST="DNS_whitelist.txt"

trap '
	echo -e "\n\nGenerarea de alerte DNS s-a incheiat!\n"
' INT


if [ ! -f "$WHITELIST" ]; then
    echo "Avertisment: Fisierul $WHITELIST nu exista."
fi


while read domain;
do
    if [[ -n "$domain" ]]
    then
        
        if [ -f "$WHITELIST" ] && ! grep -q "$domain" "$WHITELIST";
        then
            echo "[ALERTA] Interogare DNS detectata: $domain"
        fi
    fi
done < <( sudo tshark -l -i "$INTERFACE" -T fields -e dns.qry.name 2>/dev/null )


