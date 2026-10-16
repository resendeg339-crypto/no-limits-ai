@echo off
rem No Limits - atalho de uso (Windows)
rem Exemplo: no_limits.bat "gere para mim um app de velocimetro"
if not exist "%~dp0.venv\Scripts\python.exe" (
    echo Ambiente nao encontrado. Rode install.bat primeiro.
    exit /b 1
)
"%~dp0.venv\Scripts\python.exe" "%~dp0agente.py" %*
