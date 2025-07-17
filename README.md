#Monitorizare retea folosind utilitarul Tshark

Aplicatia functioneaza pe baza unor scripturi bash,care ofera diferite informatii despre traficul de date ce circula in retea,AP-urile din jur,clientii conectati la fiecare AP in parte si despre dispozitivele care efectueaza port scanning.

Scriptul traffic_monitor.sh efectueaza o monitorizare pe interfata de retea enp0s3,iar wifi_traffic_monitor.sh se ocupa de monitorizarea cadrelor wi-fi.

port_scanning.sh se ocupa de monitorizarea dispozitivelor care efectueaza un port scanning,adica asculta pe mai mult de 10 porturi.

unknown_MAC_alert.sh si unknown_DNS_alert.sh se ocupa de generare de alerte in cazul in care se primeste un cadru de la un MAC necunoscut sau de la un nume de domeniu necunoscut.Adresele MAC si serverele DNS cunoscute sunt trecute in fisierele MAC_whitelist.txt si DNS_whitelist.txt

