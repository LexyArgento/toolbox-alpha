#!/bin/bash

while true; do
     read -p "nmap> " comando
     if [[ "$comando" == "exit" || "$comando" == "quit" ]]; then
        break
     fi
     nmap $comando
done
