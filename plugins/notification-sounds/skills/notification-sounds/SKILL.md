---
name: configure-sound
description: Configure which notification sound plays when Claude Code finishes a task. Pick a specific sample, set random mode, add custom sounds, or disable notifications.
argument-hint: [sound-name|random|disable|enable|list]
---

# Notification Sounds Configuration

Configure the notification sound that plays when Claude Code finishes a task.

## Commands

When the user invokes this skill, interpret their argument:

### List available sounds
If the argument is `list` or empty, run:
```bash
bash "${CLAUDE_PLUGIN_ROOT}/scripts/list-samples.sh"
```
Show the output to the user.

### Set a specific sound
If the argument is a sound name (e.g., `ding`, `chime`), run:
```bash
bash "${CLAUDE_PLUGIN_ROOT}/scripts/set-sound.sh" "<sound-name>"
```

### Set random mode
If the argument is `random`, run:
```bash
bash "${CLAUDE_PLUGIN_ROOT}/scripts/set-sound.sh" "random"
```
Tell the user a different sample will play each time.

### Disable notifications
If the argument is `disable`, run:
```bash
bash "${CLAUDE_PLUGIN_ROOT}/scripts/set-sound.sh" "disable"
```

### Enable notifications
If the argument is `enable`, run:
```bash
bash "${CLAUDE_PLUGIN_ROOT}/scripts/set-sound.sh" "enable"
```

### Add custom sounds
If the user wants to add a custom sound, instruct them to place their `.mp3` file in:
```
~/.claude/notification-sounds/custom/
```
Then set it with:
```bash
bash "${CLAUDE_PLUGIN_ROOT}/scripts/set-sound.sh" "<filename-without-extension>"
```

### Preview a sound
If the user wants to preview a sound, find the mp3 path and run:
```bash
afplay "<path-to-mp3>" &
```
(Use `paplay` on Linux)

## Notes
- Bundled samples are in `${CLAUDE_PLUGIN_ROOT}/samples/`
- Custom samples go in `~/.claude/notification-sounds/custom/`
- Config is stored at `~/.claude/notification-sounds/config.json`
- Supports macOS (afplay), Linux (paplay), and ffplay as fallback
