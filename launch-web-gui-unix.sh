#!/bin/bash

# Get the directory of the flash drive
DIR="$(cd "$(dirname "$0")" && pwd)"

# Set environment variables
export OLLAMA_MODELS="$DIR/models"
export OLLAMA_ORIGINS="*"  # This tells Ollama to accept requests from local files!

echo "========================================="
echo " Portable Ollama Web UI (macOS / Linux)  "
echo "========================================="

# 1. Check if Ollama is already running
if ! curl -s http://127.0.0.1:11434 > /dev/null; then
    echo "-> Ollama server not detected. Starting it now..."
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        chmod +x "$DIR/bin/ollama-darwin"
        "$DIR/bin/ollama-darwin" serve > /dev/null 2>&1 &
    else
        chmod +x "$DIR/bin/ollama-linux"
        "$DIR/bin/ollama-linux" serve > /dev/null 2>&1 &
    fi
    
    # Wait a few seconds for the engine to warm up
    sleep 3
else
    echo "-> Ollama server is already running!"
fi

# 2. Launch the GUI with Smart CORS Handling
echo "-> Launching Web GUI..."

# Try to use the host computer's native Python to host the file (uses 0 bytes on your USB)
if command -v python3 &>/dev/null; then
    echo "-> Native Python detected! Starting a secure local server..."
    cd "$DIR/gui"
    
    # Start python server in the background
    python3 -m http.server 8000 > /dev/null 2>&1 &
    SERVER_PID=$!
    sleep 1
    
    # Open the browser
    if [[ "$OSTYPE" == "darwin"* ]]; then
        open "http://localhost:8000"
    else
        xdg-open "http://localhost:8000"
    fi
    
    echo ""
    echo "🟢 Web UI is live! Keep this terminal open while chatting."
    read -p "Press [ENTER] to safely close the server when you are done..."
    
    # Clean up the python server when the user presses Enter
    kill $SERVER_PID
    echo "Web server closed."

else
    # Fallback: If no Python is found, just open the HTML file. 
    # (The OLLAMA_ORIGINS="*" variable set at the top usually prevents CORS errors here).
    echo "-> No Python found. Opening raw HTML file directly..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        open "$DIR/gui/index.html"
    else
        xdg-open "$DIR/gui/index.html"
    fi
fi