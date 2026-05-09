# Portable Ollama Drive 🧙💾

Welcome to your self-contained, cross-platform local AI drive! This USB drive contains everything you need to run large language models (LLMs) via Ollama on Windows, macOS, and Linux without installing anything on the host computer.

## 📂 Folder Structure

* `bin/` - Contains the downloaded standalone Ollama binaries (`ollama.exe`, `ollama-darwin`, `ollama-linux`).
* `models/` - Shared storage where all downloaded models are saved directly to the USB.
* `gui/` - Contains the `index.html` file for your local web interface.
* `python/` *(Optional)* - Place the Windows Embeddable Python package here for an enhanced local server experience on Windows PCs without Python.
* `1-start-server-*` - Initializes the Ollama engine in the terminal.
* `2-chat-*` - Launches a terminal-based chat interface.
* `3-list-models-*` - Quickly view which models are currently downloaded on the drive.
* `4-app-config-*` - Provides connection details for external apps (Claude Desktop, etc.).
* `5-launch-web-gui-*` - **⭐ The All-in-One Auto-Launcher!** Starts the server and opens the browser interface.

## 🚀 Quick Start (Web GUI)

The easiest way to use this drive is with the built-in web interface:

1. **Plug in the USB drive** into any computer.
2. **Double-click `5-launch-web-gui`** for your current OS (Windows `.bat`, Mac `.command`, or Linux `.sh`).
    * *Mac Users: If macOS blocks it, go to System Settings > Privacy & Security > Allow Anyway.*
3. The script will automatically check for the server, start it in the background if needed, and open your browser to the chat interface!
4. **Choose a Model:** Type the name of the model you want to run (e.g., `qwen3:0.6b`, `llama3.2`). If you don't have it yet, it will download directly to the flash drive.

*(Note: Keep the background terminal windows open while chatting. You can close them when you are done).*

## 💻 Terminal Mode (Alternative)

If you prefer a classic hacker terminal experience instead of the browser:
1. Run `1-start-server` and leave the window open.
2. Run `2-chat` to talk to the AI directly in the console. Type `/bye` to exit.

## 🧠 How the "Smart" GUI Works
The `5-launch-web-gui` scripts are designed to work perfectly on *any* computer, regardless of what software is installed:
* **If the host has Python:** It temporarily borrows it to run a secure local web server (`http://localhost`).
* **If the host DOES NOT have Python:** It safely opens the raw HTML file directly. It automatically applies a CORS bypass (`OLLAMA_ORIGINS=*`) so your browser won't block the AI connection.

## 🛠️ Troubleshooting

* **Chat is "Dead" or Not Answering:** Ensure the background server terminal is actually running. If you are on Windows, ensure no other instance of Ollama (like the desktop app) is running in your system tray and blocking port `11434`.
* **Download Pauses / "Context Canceled":** If you click inside a Windows terminal, it pauses the script. Press `Enter` or `Esc` to unpause it, then try chatting/downloading again.
* **"Command not found" (Mac/Linux):** Ensure the scripts and the binaries inside the `bin/` folder have execute permissions. Open your terminal and run `chmod +x /path/to/usb/scripts/*`.
* **Format:** Keep this drive formatted as **exFAT** so it can handle large model files (4GB+) across all operating systems natively!