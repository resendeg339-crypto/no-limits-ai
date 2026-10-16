@echo off
setlocal enabledelayedexpansion

echo [INFO] A iniciar o agente autonomo No Limits no Windows...

:: Ativa o ambiente virtual se existir
if exist "venv\Scripts\activate.bat" (
    call venv\Scripts\activate.bat
)

:: Verifica se o arquivo de configuracao existe
if not exist "config.json" (
    echo [ERRO] O ficheiro config.json nao foi encontrado! Execute o install.bat primeiro.
    pause
    exit /b 1
)

:: Executa o script principal
python main.py

if %errorlevel% neq 0 (
    echo.
    echo [ERRO] Ocorreu uma falha durante a execucao do agente.
)

pause