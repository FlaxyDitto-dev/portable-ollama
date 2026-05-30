#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
export OLLAMA_MODELS="$DIR/models"
echo "Listing models stored on USB..."
if [[ "$OSTYPE" == "darwin"* ]]; then
    "$DIR/bin/ollama-darwin" list
else
    "$DIR/bin/ollama-linux" list
fi
read -p "Press enter to close..."