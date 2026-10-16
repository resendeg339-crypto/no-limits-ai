@echo off
setlocal enabledelayedexpansion

echo ===================================================
echo     INSTALLING NO LIMITS AGENT (WINDOWS)
echo ===================================================

python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Python not found in PATH. Please install Python 3.
    pause
    exit /b 1
)

if not exist "venv" (
    echo [INFO] Creating Python virtual environment...
    python -m venv venv
)

echo [INFO] Installing required dependencies...
call venv\Scripts\activate.bat
python -m pip install --upgrade pip
pip install requests

if not exist "config.json" (
    echo [INFO] Initializing default config.json...
    (
        echo {
        echo   "environment": "windows",
        echo   "max_attempts": 5,
        echo   "backend": "ollama",
        echo   "model": "qwen2.5-coder",
        echo   "ollama_url": "http://localhost:11434/api/generate"
        echo }
    ) > config.json
)

echo [SUCCESS] Windows installation complete!
pause