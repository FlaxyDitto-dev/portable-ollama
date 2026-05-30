@echo off
:: Navigate to the USB drive's directory
cd /d "%~dp0"
:: Tell Ollama to use the models folder on this drive
set OLLAMA_MODELS=%CD%\models
echo Starting Ollama Server... Keep this window open!
.\bin\ollama.exe serve
pause