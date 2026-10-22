#!/usr/bin/env bash
set -e
D="$(cd "$(dirname "$0")" && pwd)"
P="${UZLLM:-$HOME/Documents/Default Project/uz-llm-lab}"

BIN="${BIN:-$P/tools/llama-vulkan/bin/llama-server}"
MODEL="${MODEL:-$D/models/Huihui-Qwen3.6-35B-A3B-abliterated.i1-IQ2_M.gguf}"
PORT="${PORT:-8300}"
CTX="${CTX:-8192}"
NGL="${NGL:-99}"
NCMOE="${NCMOE:-30}"
DEV="${DEV:-Vulkan1}"

echo "abl-guardrails: Qwen3.6-35B-A3B abliterated server"
echo "  model : $MODEL"
echo "  ngl=$NGL ncmoe=$NCMOE ctx=$CTX dev=$DEV port=$PORT"

exec "$BIN" -m "$MODEL" \
  --host 127.0.0.1 --port "$PORT" \
  -c "$CTX" -t 8 --parallel 1 -b 512 -ub 512 \
  -ngl "$NGL" -dev "$DEV" --n-cpu-moe "$NCMOE" \
  -ctk q8_0 -ctv q8_0 -fa auto
