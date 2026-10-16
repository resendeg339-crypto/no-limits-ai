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

### Option A: Windows

#### Prerequisites
- **Python 3.8+** installed and added to PATH.
- **Git** installed.

#### Quick Setup
1. Clone this repository:
   ```cmd
   git clone [https://github.com/resendeg339-crypto/no-limits-ai.git](https://github.com/resendeg339-crypto/no-limits-ai.git)
   cd no-limits-ai
Run the automated Windows setup script:

DOS
install.bat
This script sets up a Python virtual environment (venv), installs required dependencies, and creates a default config.json file.

Start the AI Agent:

DOS
run.bat
Option B: Termux (Android)
Prerequisites
Download and install Termux (recommended from F-Droid).

Quick Setup
Open Termux and run all commands at once to install and start:

Bash
pkg update && pkg upgrade -y && pkg install git python -y && git clone [https://github.com/resendeg339-crypto/no-limits-ai.git](https://github.com/resendeg339-crypto/no-limits-ai.git) && cd no-limits-ai && chmod +x install_no_limits.sh run_no_limits.sh && ./install_no_limits.sh && ./run_no_limits.sh
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

### Principais correções aplicadas:
1. **Links arrumados:** O comando `git clone` agora contém apenas a URL direta (`[https://github.com/resendeg339-crypto/no-limits-ai.git](https://github.com/resendeg339-crypto/no-limits-ai.git)`), eliminando a formatação do tipo `[link](url)` dentro do bloco de código.
2. **Blocos de código limpos:** Foram removidas as palavras `DOS`, `Bash` e a numeração das linhas (`1.`, `2.`, `3.`), garantindo que o botão de cópia do GitHub funcione corretamente.
3. **Estilização dos parâmetros:** Os nomes das chaves no painel de configuração foram mantidos destacados com código (`environment`, `max_attempts`, etc.).