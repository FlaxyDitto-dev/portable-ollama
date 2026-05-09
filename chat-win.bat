@echo off
cd /d "%~dp0"
set /p model="Enter model name (e.g., llama3.2, phi3): "
.\bin\ollama.exe run %model%
pause