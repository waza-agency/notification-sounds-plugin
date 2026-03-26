# notification-sounds

Plugin para Claude Code que reproduce un sonido de notificacion cuando Claude termina una tarea. Incluye 28 samples (clasicos + memes).

## Install

Copia y pega estos dos comandos en tu terminal:

```bash
claude plugin marketplace add waza-agency/notification-sounds-plugin
claude plugin install notification-sounds
```

Eso es todo. La proxima vez que abras Claude Code, escucharas un sonido cada vez que termine de responder.

> El primer comando registra este repo como fuente de plugins. El segundo descarga e instala el plugin con todos los samples incluidos. Solo necesitas hacerlo una vez.

---

## Features

- **Stop Hook**: Suena automaticamente cuando Claude termina de responder
- **Modo aleatorio**: Reproduce un sample diferente cada vez
- **28 samples incluidos**: 5 tonos clasicos + 23 meme (Duke Nukem, Homer, Wololo, Wazaaaaa, etc.)
- **Samples custom**: Agrega tus propios mp3s
- **Cross-platform**: macOS (afplay), Linux (paplay), ffplay como fallback
- **Skill integrado**: Configura todo desde Claude Code con `/notification-sounds:configure-sound`

## Uso

### Comandos del skill

```bash
# Ver samples disponibles
/notification-sounds:configure-sound list

# Modo aleatorio (diferente sample cada vez)
/notification-sounds:configure-sound random

# Elegir un sample especifico
/notification-sounds:configure-sound ding
/notification-sounds:configure-sound homer-simpson-doh
/notification-sounds:configure-sound wazaaaaa
/notification-sounds:configure-sound wololo-sound-effect

# Desactivar notificaciones
/notification-sounds:configure-sound disable

# Reactivar notificaciones
/notification-sounds:configure-sound enable
```

### Samples incluidos

**Clasicos:** ding, chime, bell, pop, success

**Memes:** attack-and-under-attack-sfx, boring, boss-you-ve-done-a-beautiful-thing, cawabunga, coin, duke-nukem-3d-annoying, duke-nukem-3d-groovy, duke-nukem-3d-pod, ha-ha, hey-that-s-pretty-good, homer-simpson-doh, i-almost-died, icq-sound, nerd-alert, poof, ripit, smoke-weed-everyday, super-mario-bros-block-sound, surprise-motherfucker, there-s-only-one-boss-around-here, two-hours-later, wazaaaaa, wololo-sound-effect

## Agregar samples custom

```bash
# Crea la carpeta
mkdir -p ~/.claude/notification-sounds/custom/

# Copia tus mp3s
cp mi-sonido.mp3 ~/.claude/notification-sounds/custom/

# Seleccionalo desde Claude Code
/notification-sounds:configure-sound mi-sonido
```

## Instalacion alternativa (desarrollo)

```bash
git clone https://github.com/waza-agency/notification-sounds-plugin.git
claude --plugin-dir ./notification-sounds-plugin/plugins/notification-sounds
```

## Configuracion

La configuracion se guarda en `~/.claude/notification-sounds/config.json`:

```json
{
  "sound": "random",
  "enabled": true
}
```

- `sound`: Nombre del sample (sin extension) o `"random"`
- `enabled`: `true` o `false`

## Compatibilidad

| OS | Reproductor | Estado |
|----|------------|--------|
| macOS | afplay | Soportado |
| Linux (PulseAudio) | paplay | Soportado |
| Linux/otro | ffplay | Fallback |

## Licencia

MIT
