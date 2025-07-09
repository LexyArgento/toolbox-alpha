#!/bin/bash

MAX_PROCESOS=5
declare -a PIDS
emergency_kill() {
	echo -e "\n[!] Activando protocolo de emergencia: matando procesos..."
	for pid in "${PIDS[@]}"; do
		if kill -0 "$pid"; then
			kill -9 "$pid" && echo "[X] Proceso $pid terminado (forzado)" 2>/dev/null
		fi
	done
	echo "[!] Todos los procesos han sido eliminados por seguridad!"
	exit 1
}

normal_kill() {
        echo -e "\n[*] cerrando herramientas..."
        for pid in "${PIDS[@]}"; do
                if kill -0 "$pid" 2>/dev/null; then
                        kill "$pid" && echo "[+] Proceso $pid cerrados correctamente" 2>/dev/null
                fi
        done
	echo "[*] Sesion finalizada :)"
        exit 0
}

trap emergency_kill SIGINT

echo "bienvenido $(whoami)!"
echo "que haras hoy?"
echo -e "\n1) academia HTB"
echo -e "\n2) hacking ético"
echo -e "\n3) OSINT"
echo -e "\n4) programacion"
echo -e "\n5) ¿quien soy?"
echo -e "\n6) continuar sin el script :( \n"
read -p "Elige una opcion: " opcion

case $opcion in
     1)
      firefox "https://hackthebox.com/account/"
      ;;
     2)
      echo -e "\ndesplegando herramientas..."
      xterm -title "Metasploit Console" -e "msfconsole" & PIDS+=($!)
      xterm -title "Nmap Interactive" -e "/opt/interactive.sh" & PIDS+=($!)
      firefox "https://exploit-db.com" & PIDS+=($!)
      echo "Herramientas lanzadas sus PIDS: ${PIDS[@]}"
      ;;
     3)
      maltego & PIDS+=($!)
      ;;
     4)
      code & PIDS+=($!)
      ;;
     5)
      echo "nadie en especial. Me llamo lexy, actualmente tengo 16 años, me interese por la informatica hace muy poco, y me gusta programar (aunque no soy bueno en ello XD) si quieres que arregle algo del script o me quieres stalkear aca te dejo mis redes (en twitter estoy mas activo)"
      echo "instagram: https://instagram.com/lexy_argento"
      echo "Twitter/X: https://x.com/Lexy_Argento"
      echo "patreon: https://patreon.com/Lexy_Argento"
      echo "canal de Telegram: https://t.me/sanity_not_found_404_canal"
      ;;
     6)
      echo "Goodbye..."
      exit 0
      ;;
     *)
      echo "opcion invalidad."
      exit 1
      ;;
esac
if [ "${PIDS[@]}" -gt "$MAX_PROCESOS" 2>/dev/null ]; then
	emergency_kill
else
	echo "[*] procesos activos (${PIDS[@]}/$MAX_PROCESOS)" ]
	read -p "preciona ENTER para cerrar todas las herramientas"
	normal_kill
fi
