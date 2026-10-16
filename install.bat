@echo off
setlocal EnableExtensions
title No Limits - Instalador
cd /d "%~dp0"

echo ==========================================
echo   No Limits - Instalacao
echo ==========================================
echo.

rem --- 1. Python ---------------------------------------------------------
set "PY="
py -3 --version >nul 2>&1 && set "PY=py -3"
if not defined PY python --version >nul 2>&1 && set "PY=python"
if not defined PY goto :sem_python
echo [1/4] Python encontrado: %PY%

rem --- 2. Ambiente virtual -----------------------------------------------
echo [2/4] Preparando ambiente virtual...
if exist ".venv\Scripts\python.exe" goto :venv_ok
%PY% -m venv .venv
if errorlevel 1 goto :erro
:venv_ok

rem --- 3. Dependencias ---------------------------------------------------
echo [3/4] Instalando dependencias...
".venv\Scripts\python.exe" -m pip install --upgrade pip --quiet
".venv\Scripts\python.exe" -m pip install -r requirements.txt --quiet
if errorlevel 1 goto :erro

rem --- 4. Escolha do modelo ----------------------------------------------
echo.
echo [4/4] Escolha como a IA vai funcionar:
echo    1 - Modelo local com Ollama   (gratis, roda no seu PC)
echo    2 - API da Anthropic          (precisa de chave de API)
set "ESC=1"
set /p "ESC=Digite 1 ou 2 [1]: "
if "%ESC%"=="2" goto :anthropic

:ollama
where ollama >nul 2>&1
if errorlevel 1 goto :sem_ollama
set "MODELO=qwen2.5-coder:14b"
set /p "MODELO=Modelo [qwen2.5-coder:14b]: "
call :salvar_config ollama %MODELO%
set "BAIXAR=S"
set /p "BAIXAR=Baixar o modelo agora? Pode ocupar varios GB [S/n]: "
if /i "%BAIXAR%"=="n" goto :fim
ollama pull %MODELO%
goto :fim

:sem_ollama
call :salvar_config ollama
echo.
echo Ollama nao encontrado. Instale em https://ollama.com/download e depois rode:
echo    ollama pull qwen2.5-coder:14b
goto :fim

:anthropic
call :salvar_config anthropic
echo.
echo Cole sua ANTHROPIC_API_KEY. Ela sera salva apenas na sua conta do Windows.
echo Atencao: o texto aparece na tela enquanto voce digita. Enter pula esta etapa.
set "CHAVE="
set /p "CHAVE=Chave: "
if not defined CHAVE goto :sem_chave
setx ANTHROPIC_API_KEY "%CHAVE%" >nul
echo Chave salva. Abra um NOVO terminal antes de usar.
goto :fim

:sem_chave
echo Sem chave por enquanto. Defina depois com: setx ANTHROPIC_API_KEY "sua-chave"
goto :fim

:fim
echo.
echo ==========================================
echo   Instalacao concluida!
echo ==========================================
echo Para usar:
echo    no_limits.bat "gere para mim um app de velocimetro"
echo.
pause
exit /b 0

:sem_python
echo.
echo Python nao encontrado. Instale o Python 3 em https://www.python.org/downloads/
echo e marque a opcao "Add python.exe to PATH" no instalador.
echo Depois rode este arquivo de novo.
pause
exit /b 1

:erro
echo.
echo Ocorreu um erro na instalacao. Veja as mensagens acima.
pause
exit /b 1

rem --- Subrotina: grava config.local.json (nao vai para o Git) ------------
rem Uso: call :salvar_config BACKEND [MODELO_OLLAMA]
:salvar_config
".venv\Scripts\python.exe" -c "import json,os,sys;b='config.json';l='config.local.json';c=json.load(open(l if os.path.exists(l) else b,encoding='utf-8'));c['backend']=sys.argv[1];m=sys.argv[2] if len(sys.argv)>2 else '';c['ollama']['modelo']=m or c['ollama']['modelo'];json.dump(c,open(l,'w',encoding='utf-8'),ensure_ascii=False,indent=2)" %~1 %~2
exit /b %errorlevel%
