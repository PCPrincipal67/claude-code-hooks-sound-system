#!/bin/bash
# Read工具调用前播放提示音

echo "📖 PreToolUse:Read triggered at $(date)" >> /tmp/claude-hook-debug.log
afplay /System/Library/Sounds/Morse.aiff &
exit 0
