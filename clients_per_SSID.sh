#!/bin/bash



echo "=== Monitorizare clienți și SSID-uri ==="

sudo tshark -i wlx60a4b721c80d -f "type mgt subtype probe-req or subtype beacon" -T fields -e wlan.sa -e wlan.da -e wlan.ssid -l 2>/dev/null | while IFS=$'\t' read -r timestamp client_mac dest_mac ssid_hex; do
    
    if [[ ! -z "$client_mac" ]]; 
    then
        
        if [[ ! -z "$ssid_hex" && "$ssid_hex" != "<MISSING>" ]]; 
        then
            decoded_ssid=$(echo "$ssid_hex" | xxd -r -p 2>/dev/null)
            
            if [[ $? -eq 0 && ! -z "$decoded_ssid" ]]; then
                ssid_display="$decoded_ssid"
            else
                ssid_display="$ssid_hex"
            fi
        else
            ssid_display="Hidden/Unknown"
        fi
       
        
        echo "Client: $client_mac | SSID: $ssid_display"
    fi
done
