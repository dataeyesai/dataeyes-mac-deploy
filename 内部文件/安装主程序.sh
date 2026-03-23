#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "$0")/.." && pwd)"
INNER_DIR="$DIR/内部文件"
NODE_HOME="${OPENCLAW_NODE_HOME:-$HOME/.local/node}"
export PATH="$HOME/.npm-global/bin:$NODE_HOME/bin:/usr/local/bin:/opt/homebrew/bin:$PATH"

OPENCLAW_SKIP_ONBOARD=1 bash "$INNER_DIR/安装OpenClaw基础环境.sh"
export PATH="$HOME/.npm-global/bin:$NODE_HOME/bin:/usr/local/bin:/opt/homebrew/bin:$PATH"
hash -r || true

OPENCLAW_BIN="$(command -v openclaw || true)"
if [[ -z "$OPENCLAW_BIN" && -x "$HOME/.npm-global/bin/openclaw" ]]; then
  OPENCLAW_BIN="$HOME/.npm-global/bin/openclaw"
fi
if [[ -z "$OPENCLAW_BIN" ]]; then
  echo "OpenClaw 安装后未找到 openclaw 命令"
  exit 1
fi

DATAEYES_API_KEY="${DATAEYES_API_KEY:-}"
if [[ -z "$DATAEYES_API_KEY" ]]; then
  if [[ -t 0 ]]; then
    read -rsp "请输入 DataEyes API Key: " DATAEYES_API_KEY
    echo ""
  elif [[ -t 1 || -t 2 ]]; then
    read -rsp "请输入 DataEyes API Key: " DATAEYES_API_KEY < /dev/tty
    echo "" > /dev/tty
  fi
fi
if [[ -z "$DATAEYES_API_KEY" ]]; then
  echo "缺少 DataEyes API Key"
  exit 1
fi

DATAEYES_API_KEY="$DATAEYES_API_KEY" bash "$INNER_DIR/scripts/dataeyes-setup.sh"
"$OPENCLAW_BIN" gateway install >/tmp/openclaw-gateway-install.log 2>&1 || cat /tmp/openclaw-gateway-install.log
"$OPENCLAW_BIN" gateway start >/tmp/openclaw-gateway-start.log 2>&1 || cat /tmp/openclaw-gateway-start.log
sleep 3
bash "$INNER_DIR/scripts/dataeyes-verify.sh"
"$OPENCLAW_BIN" gateway restart >/tmp/openclaw-gateway-restart.log 2>&1 || cat /tmp/openclaw-gateway-restart.log
sleep 3
URL=$("$OPENCLAW_BIN" dashboard --no-open 2>/dev/null | sed -n 's/^Dashboard URL: //p')
if [[ -n "$URL" ]]; then
  open "$URL" 2>/dev/null || true
  echo "已打开控制台: $URL"
else
  echo "控制台地址: http://127.0.0.1:18789"
fi
