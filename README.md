Markdown
# 🚀 No Limits AI

An autonomous, self-correcting coding agent built in Python designed to generate, execute, and automatically fix scripts in both **Termux (Android)** and **Windows** environments.

---

## 📋 Features

- **Automated Feedback Loop:** Attempts execution up to 5 times, automatically capturing errors and feeding them back to the LLM for corrections.
- **Cross-Platform:** Works seamlessly on both Android (via Termux) and Windows.
- **Multiple Backend Support:** Connects with local **Ollama** (`qwen2.5-coder`) or the **Anthropic API**.

---

## 🛠️ Installation & Setup

### Option A: Windows Setup (PC)

#### Prerequisites
- **Python 3.8+** installed and added to system PATH.
- **Git** installed.

#### Step-by-Step Installation
1. Open Command Prompt (`cmd`) or PowerShell and clone the repository:
   ```cmd
   git clone [https://github.com/resendeg339-crypto/no-limits-ai.git](https://github.com/resendeg339-crypto/no-limits-ai.git)
Navigate into the project folder:

DOS
cd no-limits-ai
Run the automated Windows installer script:

DOS
install.bat
This script creates a virtual environment (venv), upgrades pip, installs required dependencies, and sets up your config.json file.

Launch the AI agent:

DOS
run.bat
Option B: Termux Setup (Mobile)
Prerequisites
Install Termux on your Android device (recommended from F-Droid).

Method 1: Express One-Line Setup (Fastest for Mobile)
Open Termux, copy and paste this single command to install everything and run the agent immediately:

Bash
pkg update && pkg upgrade -y && pkg install git python -y && git clone [https://github.com/resendeg339-crypto/no-limits-ai.git](https://github.com/resendeg339-crypto/no-limits-ai.git) && cd no-limits-ai && chmod +x install_no_limits.sh run_no_limits.sh && ./install_no_limits.sh && ./run_no_limits.sh
Method 2: Step-by-Step Setup
If you prefer running commands manually line by line in Termux:

Update package repositories and install required packages:

Bash
pkg update && pkg upgrade -y
pkg install git python -y
Clone the repository:

Bash
git clone [https://github.com/resendeg339-crypto/no-limits-ai.git](https://github.com/resendeg339-crypto/no-limits-ai.git)
Enter the project folder:

Bash
cd no-limits-ai
Grant execution permissions to shell scripts:

Bash
chmod +x install_no_limits.sh run_no_limits.sh
Run the installation script:

Bash
./install_no_limits.sh
Start the AI Agent:

Bash
./run_no_limits.sh
⚙️ Configuration (config.json)
The config.json file controls backend execution settings:

JSON
{
  "environment": "termux",
  "max_attempts": 5,
  "backend": "ollama",
  "model": "qwen2.5-coder"
}
environment: Set to "termux" or "windows".

max_attempts: Maximum retry attempts before giving up (default: 5).

backend: Set to "ollama" or "anthropic".

model: Model name to use (e.g., qwen2.5-coder or claude-3-5-sonnet-20241022).

🔒 Security
Never commit API keys or secret credentials to the repository. If using external LLM services (like Anthropic), export keys directly via environment variables:

Windows:

DOS
set ANTHROPIC_API_KEY=your_actual_key_here
Termux:

Bash
export ANTHROPIC_API_KEY="your_actual_key_here"

---

### Para salvar e enviar ao GitHub:
1. Salve o arquivo `README.md`.
2. No seu terminal no Windows, rode:
   ```bash
   git add README.md
   git commit -m "docs: Fix syntax formatting and complete Windows & Mobile setup guides"
   git push origin main