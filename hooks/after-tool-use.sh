#!/bin/bash
# 工具执行后检查错误并播放提示音

INPUT=$(cat)

echo "=== PostToolUse triggered at $(date) ===" >> /tmp/claude-hook-debug.log

TOOL_NAME=$(echo "$INPUT" | grep -o '"tool_name":"[^"]*"' | cut -d'"' -f4)

# 检查Bash工具错误
if [[ "$TOOL_NAME" == "Bash" ]]; then
  HAS_STDERR=$(echo "$INPUT" | grep -o '"stderr":"[^"]*"' | grep -v '"stderr":""')
  HAS_ERROR=$(echo "$INPUT" | grep -E '(<error>|"error":|Failed|Exception)')

  if [[ -n "$HAS_STDERR" ]] || [[ -n "$HAS_ERROR" ]]; then
    afplay /System/Library/Sounds/Basso.aiff &
    echo "❌ Bash命令失败" >> /tmp/claude-hook-debug.log
  fi
fi

# 检查MCP工具错误
if [[ "$TOOL_NAME" == mcp__* ]]; then
  if echo "$INPUT" | grep -Eqi '(<error>|"error":|Failed|timeout|invalid)'; then
    afplay /System/Library/Sounds/Basso.aiff &
    echo "❌ MCP工具失败: $TOOL_NAME" >> /tmp/claude-hook-debug.log
  fi
fi

exit 0
