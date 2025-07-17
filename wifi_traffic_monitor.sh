#!/bin/bash
#

INTERFATA="wlx60a4b721c80d"

declare -A ap_unici
declare -A ssid_unice


trap '	echo -e "\n\n---Statistici la oprire:"
	echo "Numar AP-uri unice: ${#ap_unici[@]}"
	echo "Numar SSID-uri unice: ${#ssid_unice[@]}"
	exit 0' INT

echo "Captura wi-fi in desfasurare...."
echo -e "MAC_AP \t SSID_DECODAT"


while IFS=$'\t' read -r mac_ap ssid_hex
do
    [[ -z "$mac_ap" || -z "$ssid_hex" ]] && continue

    ssid_decodat=$(echo "$ssid_hex" | xxd -r -p 2>/dev/null)
    
    if [[ -z "$ssid_decodat" || "$ssid_decodat" =~ [^[:print:]] ]]; then
        continue
    fi


    echo -e "$mac_ap \t $ssid_decodat"

    ap_unici["$mac_ap"]=1
    ssid_unice["$ssid_decodat"]=1

done < <(sudo tshark -i "$INTERFATA"  -Y "wlan.fc.type_subtype==0x08 || wlan.fc.type_subtype==0x05" -T fields -e wlan.bssid -e wlan.ssid 2>/dev/null)


