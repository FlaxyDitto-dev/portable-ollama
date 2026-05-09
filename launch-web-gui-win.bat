@echo off
setlocal
:: Ensure we are in the right folder
cd /d "%~dp0"

:: Set Environment Variables
set "OLLAMA_MODELS=%CD%\models"
set "OLLAMA_ORIGINS=*"

echo =========================================
echo  Portable Ollama Web UI (Windows)
echo =========================================

:: Check if Ollama is already running
curl -s http://127.0.0.1:11434 >nul
if %errorlevel% neq 0 goto START_SERVER

echo [->] Ollama server is already running!
goto LAUNCH_GUI

:START_SERVER
echo [->] Ollama server not detected. Starting it now...
start /min "Ollama Server" ".\bin\ollama.exe" serve
echo [->] Waiting for engine to warm up...
timeout /t 5 /nobreak >nul

:LAUNCH_GUI
echo [->] Launching Web GUI...

:: STRATEGY 1: Check for a Portable Python folder on the USB drive
if exist ".\python\python.exe" goto USE_PORTABLE_PYTHON

:: STRATEGY 2: Check for Python installed on the host computer
where python >nul 2>nul
if %errorlevel% equ 0 goto USE_SYSTEM_PYTHON

:: STRATEGY 3: The Ultimate Fallback (No Python anywhere)
echo [->] No Python found. Opening raw HTML file directly...
start "" ".\gui\index.html"
goto END

:USE_PORTABLE_PYTHON
echo [->] Portable Python detected on USB! Starting server...
:: Go into the GUI folder, but tell it to use the Python one folder back
cd gui
start /min "Ollama-Web-Server" "..\python\python.exe" -m http.server 8000
goto WAIT_FOR_BROWSER

:USE_SYSTEM_PYTHON
echo [->] Host System Python detected! Starting server...
cd gui
start /min "Ollama-Web-Server" python -m http.server 8000
goto WAIT_FOR_BROWSER

:WAIT_FOR_BROWSER
timeout /t 2 /nobreak >nul
start http://localhost:8000

echo.
echo 🟢 GUI is live at http://localhost:8000
echo.
echo KEEP THIS WINDOW OPEN while chatting.
pause

:: Clean up the python server when the user hits a key
taskkill /FI "WINDOWTITLE eq Ollama-Web-Server*" /T /F >nul

:END
exit