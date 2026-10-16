#!/bin/bash

echo "[INFO] A iniciar a instalacao do No Limits no Termux..."

# Atualiza os pacotes e instala dependencias do sistema
pkg update -y && pkg upgrade -y
pkg install python git -y

# Atualiza o pip e instala dependencias do Python
pip install --upgrade pip
pip install requests

# Cria o arquivo config.json padrao caso nao exista
if [ ! -f "config.json" ]; then
    cat << EOF > config.json
{
  "environment": "termux",
  "max_attempts": 5,
  "backend": "ollama",
  "model": "qwen2.5-coder"
}
EOF
fi

# Concede permissao de execucao aos scripts shell
chmod +x install_no_limits.sh run_no_limits.sh

echo "[SUCESSO] Instalacao concluida! Execute ./run_no_limits.sh para iniciar."