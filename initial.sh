function initial() {
	ip=$1
	echo "[!] Ejecutando escaneo rápido a la dirección $ip\n";
	sudo nmap -sS --min-rate 5000 -p- --open -Pn -n -oG allPorts $ip;

	ports="$(cat allPorts | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"

	echo "\n[!] Los puertos abiertos encontrados son: $ports\n";

	sudo nmap -sCV -p $ports -Pn -n -oN targeted $ip;

	echo "\n[!] Escaneo inicial finalizado!";
}
