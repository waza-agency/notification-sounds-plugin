#!/bin/bash
# list-samples.sh - Lists all available notification sounds

PLUGIN_DIR="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
CONFIG_DIR="${HOME}/.claude/notification-sounds"
CONFIG_FILE="${CONFIG_DIR}/config.json"

# Current setting
if [ -f "$CONFIG_FILE" ]; then
  CURRENT=$(python3 -c "import json; c=json.load(open('$CONFIG_FILE')); print(c.get('sound','random'))" 2>/dev/null)
  ENABLED=$(python3 -c "import json; c=json.load(open('$CONFIG_FILE')); print(str(c.get('enabled',True)).lower())" 2>/dev/null)
else
  CURRENT="random"
  ENABLED="true"
fi

echo "Current: $CURRENT (enabled: $ENABLED)"
echo ""

echo "Bundled samples:"
for f in "$PLUGIN_DIR/samples"/*.mp3; do
  [ -f "$f" ] || continue
  NAME=$(basename "$f" .mp3)
  MARKER=""
  [ "$NAME" = "$CURRENT" ] && MARKER=" <-- active"
  echo "  - $NAME$MARKER"
done

if [ -d "$CONFIG_DIR/custom" ]; then
  CUSTOM_COUNT=$(ls -1 "$CONFIG_DIR/custom"/*.mp3 2>/dev/null | wc -l)
  if [ "$CUSTOM_COUNT" -gt 0 ]; then
    echo ""
    echo "Custom samples (~/.claude/notification-sounds/custom/):"
    for f in "$CONFIG_DIR/custom"/*.mp3; do
      NAME=$(basename "$f" .mp3)
      MARKER=""
      [ "$NAME" = "$CURRENT" ] && MARKER=" <-- active"
      echo "  - $NAME$MARKER"
    done
  fi
fi

echo ""
echo "Special modes: random"
[ "$CURRENT" = "random" ] && echo "  random <-- active"
