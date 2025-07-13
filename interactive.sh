#!/bin/bash
echo "ejecuta 'n-help' para ayuda del script y '-h' o '--help' para ayuda de nmap"
while true; do
     read -p "nmap> " -a comando
     [[ -z "${comando[0]}" ]] && continue
     case "${comando[0]}" in
         "exit"|"quit") break;;
         "n-help") echo "comandos validos: scan <taget>, exit/quit y todos los argumentos de nmap"
                  ;;
         *) nmap "${comando[@]}"
            ;;
      esac
done
