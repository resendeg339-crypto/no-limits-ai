#!/bin/bash

echo "==================================================="
echo "     INSTALLING NO LIMITS AGENT (TERMUX)           "
echo "==================================================="

echo "[INFO] Updating system packages..."
pkg update -y && pkg upgrade -y

echo "[INFO] Installing Python and essential tools..."
pkg install python git -y

echo "[INFO] Upgrading pip and installing dependencies..."
pip install --upgrade pip
pip install requests

if [ ! -f "config.json" ]; then
    echo "[INFO] Initializing default config.json for Termux..."
    cat << EOF > config.json
{
  "environment": "termux",
  "max_attempts": 5,
  "backend": "ollama",
  "model": "qwen2.5-coder",
  "ollama_url": "http://localhost:11434/api/generate"
}
EOF
fi

chmod +x install_no_limits.sh run_no_limits.sh 2>/dev/null || true

echo "[SUCCESS] Termux installation complete!"