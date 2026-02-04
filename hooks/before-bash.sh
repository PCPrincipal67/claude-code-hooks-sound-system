#!/bin/bash
# Bash工具调用前播放提示音

echo "🔨 PreToolUse:Bash triggered at $(date)" >> /tmp/claude-hook-debug.log
afplay /System/Library/Sounds/Tink.aiff &
exit 0
