#!/bin/bash

trap '"Ctrl + C" detectado, abortando...' SIGINT

ubicacion=$(pwd)
# obtener PIDS
MAX_PROCESOS=5
declare -a PIDS

REDES_SOCIALES=(""" \n
        instagram: https://instagram.com/lexy_argento \n
        Twitter/X: https://x.com/Lexy_Argento \n
        patreon: https://patreon.com/Lexy_Argento \n
        canal de Telegram: https://t.me/sanity_not_found_404 \n
        """
)

# matar procesos automaticamente en caso de emergencia
function emergency_kill() {
                echo -e "\n\033[1;31m[!] Activando protocolo Anti-DoS: matando procesos..."
                for pid in "${PIDS[@]}"; do
                        if kill -0 "$pid"; then
                                kill -9 "$pid"
                        fi
                echo -e "\033[1;31m[X] Proceso $pid terminado (forzado)" 2>/dev/null
                echo "[!] Todos los procesos han sido eliminados por seguridad!"
                exit 1
                done
}

function normal_kill() {
                for pid in "${PIDS[@]}"; do
                        if kill -0 "$pid" 2>/dev/null; then
                                kill "$pid" 2>/dev/null &&
                                echo "[+] Proceso $pid cerrados correctamente"
                        fi
                done
                exit 0
}

# menu
function show_menu() {
                clear
                echo -e "\n\033[1;36mbienvenido, \033[1;33m$(whoami)!\033[1;36m que haras hoy?\n"
                echo -e "\n\033[1;32m1) academia HTB"
                echo -e "\n\033[1;31m2) hacking ético"
                echo -e "\n\033[1;35m3) OSINT/Doxing"
                echo -e "\n\033[1;37m4) ¿quien soy?"
                echo -e "\n\033[1;30m5) continuar sin el script :( \n"
                echo -e "\n\033[1;31mIMPORTANTE: para matar los procesos automaticamente debe salir del script con la opcion 5"
                echo -e "estos procesos estan activos ahora PIDS: ${PIDS[@]}"
                echo -e "\033[1;30m"
                read -p "Elige una opcion: " -a opcion
}

# --- main menu ---
function menu_interactivo() {
                case $opcion in
                1) firefox "https://hackthebox.com/account/";;
                2)
                   xterm -title "searchsploit - Console" -e "$ubicacion/interactive/exploitdb.sh" & PIDS+=($!)
                   sleep 1
                   xterm -title "Nmap Interactivo" -e "$ubicacion/interactive/interactive.sh" & PIDS+=($!)
                   sleep 1
                   echo "Herramientas lanzadas sus PIDS: ${PIDS[@]}"
                   ;;
                3) echo "por el momento no disponible" ;;
                4) echo -e "\n\033[1;31mLexy The Cyber Tiger"
                   echo "  - fururo pentester y bug hunter"
                   echo "  - nivel de scripting: basico"
                   echo "  - I love Furry Fandom"
                   echo -e "\nMIS REDES"
                   echo -e $REDES_SOCIALES
                   ;;
                5) echo "Goodbye..."
                        normal_kill
                        ;;
                *) echo "operacion invalida (¿tecla equivocada?) " ;;
                esac
}

while true; do
        clear
        show_menu
        menu_interactivo
        sleep 1
        if [ "${PIDS[@]}" -gt "$MAX_PROCESOS" 2>/dev/null ]; then
                emergency_kill
        else
                2>/dev/null
                echo -e "\033[1;34m[*] procesos activos (${PIDS[@]}/$MAX_PROCESOS)" ]
                read -p "preciona ENTER volver al menu "
        fi
done
# definir cierre de emergencia o normal
# si, estas en lo correcto
#
#
# estos 5 comentarios
# eran para llegar a las 100 lineas
