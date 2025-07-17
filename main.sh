#!/bin/bash

INTERFATA="enp0s3"
while true 
do
	echo "======Sistem monitorizare!======="
	echo "1.Monitorizare porturi scanate."
	echo "2.Generare de statistici."
	echo "3.Generare alerte MAC necunoscut."
	echo "4.Generare alerte DNS necunoscut."
	echo "5.Monitorizare wi-fi."
	echo "6.Monitorizare clienti conectati la AP-urile din jur."
	echo "7.Iesi!"

	read -p "Introdu optiunea dorita:" monitorizare



	case "$monitorizare" in
		1)
		./port_scanning.sh lo
		;;
	
		2)
		./traffic_monitor.sh "$INTERFATA"
		;;
	
		3)
		./unknown_MAC_alert.sh "$INTERFATA"
		;;
	
		4)
		./unknown_DNS_alert.sh "$INTERFATA"
		;;
		
		5)
		./wifi_traffic_monitor.sh
		;;
		
		6)
		./clients_per_SSID.sh
		;;
		
		7)
		break
		;;
		
		*)
		exit 1
		;;		
		
	esac	
done	
