#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
export OLLAMA_MODELS="$DIR/models"
echo "Starting Ollama Server... Keep this window open!"
chmod +x "$DIR/bin/ollama-darwin"
"$DIR/bin/ollama-darwin" serve