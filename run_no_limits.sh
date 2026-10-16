#!/bin/bash

echo "[INFO] A iniciar o agente autonomo No Limits no Termux..."

# Verifica se o arquivo de configuracao existe
if [ ! -f "config.json" ]; then
    echo "[ERRO] O ficheiro config.json nao foi encontrado! Execute o install_no_limits.sh primeiro."
    exit 1
fi

# Executa o script principal no Python
python main.py

if [ $? -ne 0 ]; then
    echo -e "\n[ERRO] Ocorreu uma falha durante a execucao do agente."
    exit 1
fi