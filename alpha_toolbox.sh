#!/bin/bash

set -euo pipefail
trap 'emergency_kill "interrupcion (Ctrl + C) detectada"' SIGINT
trap 'normal_kill "Ejecucion finalizada"' EXIT

# obtener PIDS
MAX_PROCESOS=5
declare -a PIDS

REDES_SOCIALES=(""" \n
        instagram: https://instagram.com/lexy_argento \n
        Twitter/X: https://x.com/Lexy_Argento \n
        patreon: https://patreon.com/Lexy_Argento \n
        canal de Telegram: https://t.me/sanity_not_found_404_canal \n
        """
)

# Cierre automatico en caso de DoS
emergency_kill() {
	echo -e "\n[!] Activando protocolo Anti-DoS: matando procesos..."
	for pid in "${PIDS[@]}"; do
		if kill -0 "$pid"; then
			kill -9 "$pid" && echo "[X] Proceso $pid terminado (forzado)" 2>/dev/null
		fi
	done
	echo "[!] Todos los procesos han sido eliminados por seguridad!"
	exit 1
}

# Cierre manual (normal
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

# menu
show_menu() {
        clear
        echo -e "\n\033[1;36mbienvenido, \033[1;33m$(whoami)\033[0m! que haras hoy?\n"
        echo -e "\n\033[1;32m1) academia HTB"
        echo -e "\n\033[1;31m2) hacking ético"
        echo -e "\n\033[1;35m3) OSINT"
        echo -e "\n\033[1;34m4) programacion"
        echo -e "\n\033[1;37m5) ¿quien soy?"
        echo -e "\n\033[1;30m6) continuar sin el script :( \n"
        read -p "Elige una opcion: " opcion
}

# --- main menu ---
show_menu
case $opcion in
     1) firefox "https://hackthebox.com/account/";;
     2)
       xterm -title "Metasploit Framework - Console" -e "msfconsole" & PIDS+=($!)
       sleep 1
       xterm -title "Nmap Interactivo" -e "/opt/interactive.sh" & PIDS+=($!)
       sleep 1
       firefox "https://exploit-db.com" & PIDS+=($!)
       echo "Herramientas lanzadas sus PIDS: ${PIDS[@]}"
       ;;
     3) maltego & PIDS+=($!) ;;
     4) code & PIDS+=($!) ;;
     5) echo -e "\n\033[1;31mLexy The Cyber Tiger"
        echo "  - tururo pentester y bug hunter"
        echo "  - nivel de scripting: basico"
        echo "  - I love Furry Fandom"
        echo -e "\nMIS REDES"
        echo -e $REDES_SOCIALES
        ;;
     6) normal_kill "Goodbye..." ;;
     *) emergency_kill "operacion invalida (¿tecla equivocada?)" ;;
esac

# Definir el tipo de cierre
if [ "${PIDS[@]}" -gt "$MAX_PROCESOS" 2>/dev/null ]; then
	emergency_kill
else
	echo "[*] procesos activos (${PIDS[@]}/$MAX_PROCESOS)" ]
	read -p "preciona ENTER para cerrar todas las herramientas"
	normal_kill
fi
