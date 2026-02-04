# Claude Code Hooks 提示音系统

基于 Claude Code Hooks 机制的声音反馈系统,让你通过声音实时感知 AI 工具的执行状态。

## 功能特点

- **工具调用前**: 不同工具播放不同提示音
- **工具调用后**: 检测错误自动播放警告音  
- **权限请求时**: 播放通知音提醒授权
- **完全可定制**: 可自由更换声音和触发条件

## 声音映射

| 事件 | 声音 | 说明 |
|------|------|------|
| Bash命令 | Tink.aiff | 清脆短促 |
| MCP工具 | Pop.aiff | 轻快弹出 |
| Read文件 | Morse.aiff | 轻柔提示 |
| Write文件 | Purr.aiff | 柔和确认 |
| 权限请求 | Hero.aiff | 英雄主题 |
| 错误警告 | Basso.aiff | 低沉警告 |

## 快速安装

### 1. 克隆仓库

```bash
git clone https://github.com/PCPrincipal67/claude-code-hooks-sound-system.git
cd claude-code-hooks-sound-system
```

### 2. 复制hooks脚本

```bash
mkdir -p ~/.claude/hooks
cp hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh
```

### 3. 配置Claude Code

编辑 `~/.claude/settings.json`,添加hooks配置:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [{"type": "command", "command": "$HOME/.claude/hooks/before-bash.sh"}]
      },
      {
        "matcher": "mcp__*",
        "hooks": [{"type": "command", "command": "$HOME/.claude/hooks/before-mcp.sh"}]
      },
      {
        "matcher": "Read",
        "hooks": [{"type": "command", "command": "$HOME/.claude/hooks/before-read.sh"}]
      },
      {
        "matcher": "Write",
        "hooks": [{"type": "command", "command": "$HOME/.claude/hooks/before-write.sh"}]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "*",
        "hooks": [{"type": "command", "command": "$HOME/.claude/hooks/after-tool-use.sh"}]
      }
    ],
    "Notification": [
      {"hooks": [{"type": "command", "command": "$HOME/.claude/hooks/notification.sh"}]}
    ],
    "Stop": [
      {"hooks": [{"type": "command", "command": "$HOME/.claude/hooks/stop.sh"}]}
    ]
  }
}
```

### 4. 重启Claude Code

配置生效需要重启 Claude Code。

## 文件结构

```
claude-code-hooks-sound-system/
├── README.md
├── LICENSE
├── hooks/
│   ├── before-bash.sh      # Bash工具调用前
│   ├── before-mcp.sh       # MCP工具调用前
│   ├── before-read.sh      # Read工具调用前
│   ├── before-write.sh     # Write工具调用前
│   ├── after-tool-use.sh   # 工具执行后(错误检测)
│   ├── notification.sh     # 权限请求通知
│   └── stop.sh             # 停止事件
└── examples/
    └── settings.json       # 配置示例
```

## 自定义声音

macOS系统声音位于 `/System/Library/Sounds/`:

```bash
ls /System/Library/Sounds/
# Basso.aiff  Blow.aiff  Bottle.aiff  Frog.aiff  
# Funk.aiff   Glass.aiff Hero.aiff   Morse.aiff  
# Ping.aiff   Pop.aiff   Purr.aiff   Sosumi.aiff  
# Submarine.aiff  Tink.aiff
```

修改脚本中的声音文件即可:

```bash
afplay /System/Library/Sounds/Glass.aiff &
```

## 调试

```bash
# 查看Hook执行日志
tail -f /tmp/claude-hook-debug.log

# 测试声音播放
afplay /System/Library/Sounds/Hero.aiff
```

## 使用场景

**远程工作监控**: 让Claude执行任务时,通过声音知道执行状态,不用一直盯着屏幕。

**多任务切换**: 在做其他事情时,听到Hero音效就知道需要授权操作。

## 平台支持

- **macOS**: 完全支持 (使用 afplay)
- **Linux**: 需修改为 `paplay` 或 `aplay`
- **Windows**: 需修改为 PowerShell 音频命令

## ⚠️ 注意事项

`after-tool-use.sh` 中检测工具执行失败的功能是**早期试验的遗留**，目前 Claude Code 官方的 `PostToolUse` hook 对错误检测的支持有限，可酌情保留或删除。

后续 Claude Code 官方可能会完善这部分，届时工具执行失败也能准确触发通知。

## 许可证

MIT License

## 相关链接

- [Claude Code官方文档](https://docs.anthropic.com/claude-code)
- [Hooks系统说明](https://docs.anthropic.com/claude-code/hooks)
