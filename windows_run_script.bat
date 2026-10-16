@echo off
setlocal enabledelayedexpansion

title No Limits Agent - Windows Execution

echo ===================================================
echo             NO LIMITS AGENT - WINDOWS              
echo ===================================================
echo.

if exist "venv\Scripts\activate.bat" (
    echo [INFO] Activating virtual environment...
    call venv\Scripts\activate.bat
) else (
    echo [WARNING] Virtual environment 'venv' not found.
    echo [INFO] Running with default Python environment...
)

if not exist "config.json" (
    echo [ERROR] 'config.json' not found!
    echo [INFO] Run 'install.bat' to generate setup files.
    echo.
    pause
    exit /b 1
)

python main.py %*

echo.
pause