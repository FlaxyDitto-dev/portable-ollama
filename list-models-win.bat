@echo off
cd /d "%~dp0"
set OLLAMA_MODELS=%CD%\models
echo Listing models stored on USB...
.\bin\ollama.exe list
pause