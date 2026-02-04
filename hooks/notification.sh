#!/bin/bash
# 权限请求通知时播放提示音

echo "🔔 Notification triggered at $(date)" >> /tmp/claude-hook-debug.log
afplay /System/Library/Sounds/Hero.aiff &
exit 0
