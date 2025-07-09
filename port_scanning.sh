#!/bin/bash
#

if [ "$#" -eq 0 ]
then
	echo "Trebuie introdus numele interfetei de retea!"
	exit 1
fi

INTERFACE=$1

declare -A PORTS_per_IP


echo "Identificare IP-uri ce execută un port scanning..."

trap '
    echo -e "\n--- Porturi scanate per IP ---"
    
    for ip in "${!PORTS_per_IP[@]}";
    do  
        IFS=',' read -ra ports <<< "${PORTS_per_IP[$ip]}"
        
        num_ports=${#ports[@]}
        if [ "$num_ports" -gt 10 ]; then
            echo "IP-ul $ip a efectuat un port scanning ( a scanat $num_ports porturi)"
        else
       	    echo "IP-ul $ip a scanat $num_ports porturi: ${PORTS_per_IP[$ip]}"
        fi
    done
' INT

while IFS=$'\t' read -r ip port ; 
do
    [ -z "$ip" ] || [ -z "$port" ] && continue

    current_ports="${PORTS_per_IP[$ip]}"
    
    if [[ ! ",$current_ports," =~ ",$port," ]]
    then
        if [ -z "$current_ports" ] 
        then
            PORTS_per_IP["$ip"]="$port"
        else
            PORTS_per_IP["$ip"]+=",${port}"
        fi
    fi

done < <(sudo tshark -i "$INTERFACE" -T fields -e ip.src -e tcp.srcport -n 2>/dev/null)

