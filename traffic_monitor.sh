#!/bin/bash
#

declare -A PACKETS
declare -A BYTES

echo "Monitorizare trafic IP:PORT(CTRL+C pentru a incheia monitorizarea):"

trap '
	echo -e "\n---Statisticile finale ---"
	for key in "${!PACKETS[@]}";
	do
		
		printf "%-20s | %5d pachete | %7d bytes\n" "$key" "${PACKETS[$key]}" "${BYTES[$key]}"
	done

' INT

while IFS=$'\t' read -r ip port length; 
do
	[ -z "$ip" ] || [ -z "$length" ] && continue
	
	if [ -n "$port" ]
	then
		key="$ip:$port"
	else
		key="$ip"
	fi
	
	if [ -z "${PACKETS[$key]}" ];
	then
		PACKETS[$key]=1
	else
		PACKETS[$key]=$(( PACKETS[$key] + 1 ))
	fi
	
	if [ -z "${BYTES[$key]}" ]; then
    		BYTES[$key]=$length
	else
    		BYTES[$key]=$(( BYTES[$key] + length ))
	fi
		
done < <(sudo tshark -i "enp0s3" -T fields -e ip.src -e tcp.srcport -e frame.len -n 2>/dev/null)	



