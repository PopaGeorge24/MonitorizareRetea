#!/bin/bash
#

if [ "$#" -eq 0 ]
then
	echo "Trebuie introdus numele interfetei de retea!"
	exit 1
fi

INTERFACE=$1
WHITELIST="DNS_whitelist.txt"

echo "Cauta alerte DNS..."
while read domain;
do
	echo "$domain"
	if ! grep -q "$domain" "$WHITELIST";
	then
		echo "[ALERTA] Interogare DNS necunocuta:$domain"
	fi

done < <(sudo tshark -i "$INTERFACE" -T fields -e dns.qry.name 2>/dev/null)

