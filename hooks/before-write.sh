#!/bin/bash
# Write工具调用前播放提示音

echo "✏️ PreToolUse:Write triggered at $(date)" >> /tmp/claude-hook-debug.log
afplay /System/Library/Sounds/Purr.aiff &
exit 0
