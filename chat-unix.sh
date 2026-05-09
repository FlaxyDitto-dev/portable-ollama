#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)"
read -p "Enter model name (e.g., llama3.2, phi3): " model

if [[ "$OSTYPE" == "darwin"* ]]; then
    "$DIR/bin/ollama-darwin" run "$model"
else
    "$DIR/bin/ollama-linux" run "$model"
fi