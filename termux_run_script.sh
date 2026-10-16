#!/bin/bash

echo "==================================================="
echo "            NO LIMITS AGENT - TERMUX               "
echo "==================================================="
echo ""

if [ ! -f "config.json" ]; then
    echo "[ERROR] 'config.json' not found!"
    echo "[INFO] Run './install_no_limits.sh' first."
    exit 1
fi

python main.py "$@"