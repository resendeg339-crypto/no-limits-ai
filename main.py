import json
import os
import re
import subprocess
import sys
import requests

CONFIG_FILE = "config.json"

def load_config():
    if not os.path.exists(CONFIG_FILE):
        print(f"[ERROR] {CONFIG_FILE} not found. Please run the installation script first.")
        sys.exit(1)
    with open(CONFIG_FILE, "r", encoding="utf-8") as f:
        return json.load(f)

def extract_python_code(text):
    """Extract python code from markdown code blocks or return plain text if not formatted."""
    pattern = r"```python\s*(.*?)\s*```"
    matches = re.findall(pattern, text, re.DOTALL)
    if matches:
        return matches[-1].strip()
    
    generic_pattern = r"```\s*(.*?)\s*```"
    generic_matches = re.findall(generic_pattern, text, re.DOTALL)
    if generic_matches:
        return generic_matches[-1].strip()
        
    return text.strip()

def call_llm(prompt, config, history=None):
    backend = config.get("backend", "ollama")
    model = config.get("model", "qwen2.5-coder")
    
    system_prompt = (
        "You are an expert Python developer tasked with writing self-contained, executable Python scripts.\n"
        f"Target Environment: {config.get('environment', 'termux')}\n"
        "Rules:\n"
        "1. Output ONLY executable Python code inside ```python ``` blocks.\n"
        "2. Do not include markdown commentary outside code blocks.\n"
        "3. Handle exceptions cleanly.\n"
    )

    if backend == "ollama":
        url = config.get("ollama_url", "http://localhost:11434/api/generate")
        full_prompt = f"{system_prompt}\n\nTask:\n{prompt}"
        if history:
            full_prompt += f"\n\nPrevious Attempts and Execution Errors:\n{history}"
            
        payload = {
            "model": model,
            "prompt": full_prompt,
            "stream": False
        }
        try:
            response = requests.post(url, json=payload, timeout=120)
            response.raise_for_status()
            return response.json().get("response", "")
        except Exception as e:
            print(f"[ERROR] Ollama communication error: {e}")
            return None

    elif backend == "anthropic":
        api_key = os.getenv("ANTHROPIC_API_KEY")
        if not api_key:
            print("[ERROR] ANTHROPIC_API_KEY environment variable is missing.")
            return None
            
        url = "https://api.anthropic.com/v1/messages"
        headers = {
            "x-api-key": api_key,
            "anthropic-version": "2023-06-01",
            "content-type": "application/json"
        }
        
        content = prompt
        if history:
            content += f"\n\nPrevious Attempts and Errors:\n{history}"
            
        payload = {
            "model": model if model != "qwen2.5-coder" else "claude-3-5-sonnet-20241022",
            "max_tokens": 4096,
            "system": system_prompt,
            "messages": [{"role": "user", "content": content}]
        }
        try:
            response = requests.post(url, headers=headers, json=payload, timeout=120)
            response.raise_for_status()
            res_json = response.json()
            return res_json["content"][0]["text"]
        except Exception as e:
            print(f"[ERROR] Anthropic API communication error: {e}")
            return None
    else:
        print(f"[ERROR] Unsupported backend: {backend}")
        return None

def execute_script(code, script_filename="temp_generated_script.py"):
    with open(script_filename, "w", encoding="utf-8") as f:
        f.write(code)

    try:
        result = subprocess.run(
            [sys.executable, script_filename],
            capture_output=True,
            text=True,
            timeout=30
        )
        return result.returncode == 0, result.stdout, result.stderr
    except subprocess.TimeoutExpired:
        return False, "", "Execution Timed Out (Limit: 30s)"
    except Exception as e:
        return False, "", str(e)

def run_agent_loop(user_prompt, config):
    max_attempts = config.get("max_attempts", 5)
    history = ""
    
    print(f"\n[AGENT START] Goal: {user_prompt}")
    
    for attempt in range(1, max_attempts + 1):
        print(f"\n--- Attempt {attempt} of {max_attempts} ---")
        print("[INFO] Generating code...")
        
        response_text = call_llm(user_prompt, config, history)
        if not response_text:
            print("[ERROR] Failed to obtain LLM response.")
            break
            
        code = extract_python_code(response_text)
        print("[INFO] Code generated. Executing script...")
        
        success, stdout, stderr = execute_script(code)
        
        if success:
            print("\n[SUCCESS] Execution completed without errors!")
            if stdout:
                print("--- Output ---")
                print(stdout)
            return True
        else:
            print(f"\n[FAIL] Execution failed on attempt {attempt}.")
            print("--- Error Log ---")
            print(stderr)
            
            history += f"\n--- Attempt {attempt} Code ---\n{code}\n--- Error ---\n{stderr}\n"
            print("[INFO] Feeding error back to LLM for auto-correction...")

    print("\n[MAX ATTEMPTS REACHED] Agent was unable to resolve the script errors automatically.")
    return False

def main():
    config = load_config()
    print("=" * 50)
    print("       NO LIMITS AUTONOMOUS CODING AGENT       ")
    print("=" * 50)
    
    if len(sys.argv) > 1:
        task = " ".join(sys.argv[1:])
    else:
        task = input("\nEnter the task or script description for the agent: ")
        
    if not task.strip():
        print("Task description cannot be empty.")
        sys.exit(1)
        
    run_agent_loop(task, config)

if __name__ == "__main__":
    main()