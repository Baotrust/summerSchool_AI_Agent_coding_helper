#!/usr/bin/env bash

# run_local_mistral.sh
#
# Purpose:
#   Start the local Mistral model either from:
#     1. a browser Web UI, through llama-server
#     2. an interactive terminal prompt, through llama-cli
#     3. a one-shot terminal prompt, through llama-completion
#
# Architecture:
#   The model file and the inference engine are kept separate on purpose.
#
#   ~/development/AI-models/llm/
#     Stores the GGUF model weights.
#     These files are large and should not move every time llama.cpp is updated.
#
#   ~/development/AI-models/comfyui/
#     Stores image generation models used by ComfyUI.
#     ComfyUI reads this folder through extra_model_paths.yaml.
#
#   ~/development/llama.cpp-stable/
#     Stores the llama.cpp inference engine.
#     This is the repo you update and rebuild when llama.cpp evolves.
#     It provides several binaries; this script uses:
#       llama-server      browser Web UI and local API
#       llama-cli         interactive terminal chat
#       llama-completion  cleaner one-shot scripted answers
#
#   ~/development/llmWorkshopSummerSchool/
#     Stores the course files and scripts.
#     This script lives here so students can see how the local setup is wired.
#
# Why CPU fallback flags are enabled by default:
#   On this Mac, Metal failed during verification with:
#     failed to create command queue
#
#   The CPU/Accelerate path worked reliably, so the script defaults to:
#     --device none -ngl 0 --no-op-offload
#
#   That means:
#     --device none     do not use the Metal GPU backend
#     -ngl 0            offload zero layers to GPU
#     --no-op-offload   keep host tensor operations on CPU
#
#   If Metal works later, run with:
#     LLAMA_USE_METAL=1 ./run_local_mistral.sh web
#     LLAMA_USE_METAL=1 ./run_local_mistral.sh chat
#
# Usage:
#   ./run_local_mistral.sh web
#     Starts the browser UI at http://127.0.0.1:8080
#
#   ./run_local_mistral.sh chat
#     Starts an interactive terminal chat prompt.
#
#   ./run_local_mistral.sh once "Explain local LLMs in simple terms."
#     Sends one prompt, prints one answer, then exits.
#
#   ./run_local_mistral.sh help
#     Shows this script usage.

set -euo pipefail

# Change these paths if the installation moves.
DEVELOPMENT_DIR="${DEVELOPMENT_DIR:-$HOME/development}"
LLAMA_CPP_DIR="${LLAMA_CPP_DIR:-$DEVELOPMENT_DIR/llama.cpp-stable}"
MODEL_PATH="${MODEL_PATH:-$DEVELOPMENT_DIR/AI-models/llm/Mistral-7B-Instruct-v0.3-Q6_K.gguf}"

# Web UI network settings.
# 127.0.0.1 means "this computer only"; it is not exposed to the classroom network.
HOST="127.0.0.1"
PORT="${PORT:-8080}"

# Binaries built from llama.cpp.
LLAMA_SERVER="$LLAMA_CPP_DIR/build/bin/llama-server"
LLAMA_CLI="$LLAMA_CPP_DIR/build/bin/llama-cli"
LLAMA_COMPLETION="$LLAMA_CPP_DIR/build/bin/llama-completion"

# Default token budget for generated answers.
# Increase this for longer answers; decrease it for faster, shorter answers.
MAX_TOKENS="${MAX_TOKENS:-512}"

# Keep the stable CPU fallback unless the user explicitly asks for Metal.
BACKEND_FLAGS=()
if [[ "${LLAMA_USE_METAL:-0}" != "1" ]]; then
  BACKEND_FLAGS=(--device none -ngl 0 --no-op-offload)
fi

print_usage() {
  cat <<'USAGE'
run_local_mistral.sh

Purpose:
  Start the local Mistral model either from:
    1. a browser Web UI, through llama-server
    2. an interactive terminal prompt, through llama-cli
    3. a one-shot terminal prompt, through llama-completion

Architecture:
  ~/development/AI-models/llm/
    Stores the GGUF model weights.

  ~/development/AI-models/comfyui/
    Stores the image generation model weights.

  ~/development/llama.cpp-stable/
    Stores the llama.cpp inference engine.

  ~/development/llmWorkshopSummerSchool/
    Stores the course files and scripts.

Usage:
  ./run_local_mistral.sh web
    Starts the browser UI at http://127.0.0.1:8080

  ./run_local_mistral.sh chat
    Starts an interactive terminal chat prompt.

  ./run_local_mistral.sh once "Explain local LLMs in simple terms."
    Sends one prompt, prints one answer, then exits.

Options:
  PORT=8082 ./run_local_mistral.sh web
    Starts the Web UI on another port.

  LLAMA_USE_METAL=1 ./run_local_mistral.sh web
    Tries the Metal backend instead of the stable CPU fallback.

  MAX_TOKENS=1000 ./run_local_mistral.sh once "Write a longer answer."
    Allows a longer generated answer.
USAGE
}

check_installation() {
  if [[ ! -d "$LLAMA_CPP_DIR" ]]; then
    echo "ERROR: llama.cpp folder not found:"
    echo "  $LLAMA_CPP_DIR"
    exit 1
  fi

  if [[ ! -f "$MODEL_PATH" ]]; then
    echo "ERROR: model file not found:"
    echo "  $MODEL_PATH"
    exit 1
  fi
}

check_binary() {
  local binary_path="$1"
  local build_target="$2"

  if [[ ! -x "$binary_path" ]]; then
    echo "ERROR: required binary not found:"
    echo "  $binary_path"
    echo
    echo "Build it with:"
    echo "  cd $LLAMA_CPP_DIR"
    echo "  cmake --build build --config Release --target $build_target"
    exit 1
  fi
}

check_web_port() {
  if ! command -v lsof >/dev/null 2>&1; then
    return
  fi

  local listeners
  listeners="$(lsof -nP -iTCP:"$PORT" -sTCP:LISTEN 2>/dev/null || true)"

  if [[ -n "$listeners" ]]; then
    echo "ERROR: port $PORT is already in use on this computer."
    echo
    echo "$listeners"
    echo
    echo "Either stop the process above, or start this Web UI on another port:"
    echo "  PORT=8082 ./run_local_mistral.sh web"
    exit 1
  fi
}

run_web_ui() {
  check_binary "$LLAMA_SERVER" "llama-server"
  check_web_port

  echo "Starting local llama.cpp Web UI..."
  echo
  echo "Open this URL in your browser:"
  echo "  http://$HOST:$PORT"
  echo
  echo "Stop the server with Ctrl+C."
  echo

  exec "$LLAMA_SERVER" \
    -m "$MODEL_PATH" \
    --host "$HOST" \
    --port "$PORT" \
    "${BACKEND_FLAGS[@]}"
}

run_terminal_chat() {
  check_binary "$LLAMA_CLI" "llama-cli"

  echo "Starting interactive terminal chat..."
  echo
  echo "Useful commands inside the prompt:"
  echo "  /exit   quit"
  echo "  /clear  clear conversation history"
  echo "  /regen  regenerate the last answer"
  echo

  exec "$LLAMA_CLI" \
    -m "$MODEL_PATH" \
    "${BACKEND_FLAGS[@]}"
}

run_one_shot_prompt() {
  check_binary "$LLAMA_COMPLETION" "llama-completion"

  local prompt="$*"
  if [[ -z "$prompt" ]]; then
    echo "ERROR: missing prompt."
    echo
    echo "Example:"
    echo "  ./run_local_mistral.sh once \"Explain local LLMs in simple terms.\""
    exit 1
  fi

  "$LLAMA_COMPLETION" \
    -m "$MODEL_PATH" \
    -p "[INST] $prompt [/INST]" \
    -n "$MAX_TOKENS" \
    --no-display-prompt \
    -no-cnv \
    "${BACKEND_FLAGS[@]}"
}

main() {
  local mode="${1:-web}"
  shift || true

  case "$mode" in
    web)
      check_installation
      run_web_ui
      ;;
    chat)
      check_installation
      run_terminal_chat
      ;;
    once)
      check_installation
      run_one_shot_prompt "$@"
      ;;
    help|--help|-h)
      print_usage
      ;;
    *)
      echo "ERROR: unknown mode: $mode"
      echo
      print_usage
      exit 1
      ;;
  esac
}

main "$@"
