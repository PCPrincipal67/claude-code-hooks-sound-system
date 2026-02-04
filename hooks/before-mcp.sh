#!/bin/bash
# MCP工具调用前播放提示音

echo "🔧 PreToolUse:MCP triggered at $(date)" >> /tmp/claude-hook-debug.log
afplay /System/Library/Sounds/Pop.aiff &
exit 0
