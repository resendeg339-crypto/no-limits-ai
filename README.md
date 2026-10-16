# No Limits

Agente que transforma um pedido simples (ex.: "gere para mim um app de velocímetro") em código Python, **executa**, lê o erro, **corrige** e repete até funcionar ou acabar o limite de tentativas. Feito para rodar no Termux e no PC.

## Como funciona

1. O modelo gera o código a partir do pedido.
2. O agente verifica a sintaxe e executa o arquivo.
3. Se der erro, o erro volta para o modelo, que corrige e devolve o código completo.
4. O ciclo repete até passar (padrão: 5 tentativas).

Você também pode passar um arquivo existente para o agente analisar e corrigir.

## Instalação

### PC
```bash
git clone <url-do-seu-repositorio> no-limits
cd no-limits
pip install -r requirements.txt
```

### Termux
```bash
pkg update && pkg install python git
git clone <url-do-seu-repositorio> no-limits
cd no-limits
pip install -r requirements.txt
pkg install termux-api   # necessário para GPS/sensores (instale também o app Termux:API)
```

## Escolhendo o modelo

Edite o `config.json`:

- **`"backend": "ollama"`**: modelo local. No PC, rode `ollama pull qwen2.5-coder:14b`. No Termux, o mais prático é manter o Ollama no PC e apontar `ollama.url` para o IP dele na rede (ex.: `http://192.168.0.10:11434`).
- **`"backend": "anthropic"`**: usa a API da Anthropic. Defina a chave antes de rodar:
  ```bash
  export ANTHROPIC_API_KEY="sua-chave"
  ```
  Nunca coloque a chave dentro do repositório.

## Uso

```bash
# gerar do zero
python agente.py "gere para mim um app de velocímetro"

# analisar e corrigir/alterar um arquivo existente
python agente.py --corrigir meu_codigo.py "corrija os erros e adicione logs"

# escolher o arquivo de saída
python agente.py --saida meu_app.py "um relógio no terminal"
```

O resultado fica em `saida/saida.py` por padrão.

## Segurança

O agente **executa o código que o modelo escreveu** na sua máquina. Rode em um ambiente isolado (Docker, VM ou uma pasta de testes) e revise o código antes de usá-lo para valer.

## Limites conhecidos

- Nenhuma IA garante código sem erro. O ciclo de correção aumenta muito a chance, mas pedidos complexos podem esgotar as tentativas.
- "Rodou sem falhar" não significa "faz o que foi pedido". Testes automáticos (pytest) são o próximo passo natural.
- Por enquanto gera apenas Python.
