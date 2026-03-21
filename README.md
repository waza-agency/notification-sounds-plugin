# notification-sounds

Plugin para Claude Code que reproduce un sonido de notificacion cuando Claude termina una tarea.

## Features

- **Stop Hook**: Suena automaticamente cuando Claude termina de responder
- **Modo aleatorio**: Reproduce un sample diferente cada vez
- **Samples incluidos**: 5 tonos royalty-free (ding, chime, bell, pop, success)
- **Samples custom**: Agrega tus propios mp3s
- **Cross-platform**: macOS (afplay), Linux (paplay), ffplay como fallback
- **Skill integrado**: Configura todo desde Claude Code con `/notification-sounds:configure-sound`

## Instalacion

### Opcion 1: Como plugin de Claude Code

```bash
# Clona el repo
git clone https://github.com/tu-usuario/notification-sounds-plugin.git

# Activa el plugin desde Claude Code
claude --plugin-dir ./notification-sounds-plugin
```

### Opcion 2: Manual

Copia la carpeta del plugin a tu directorio de plugins de Claude Code.

## Uso

### Comandos del skill

```bash
# Ver samples disponibles
/notification-sounds:configure-sound list

# Modo aleatorio (diferente sample cada vez)
/notification-sounds:configure-sound random

# Elegir un sample especifico
/notification-sounds:configure-sound ding
/notification-sounds:configure-sound chime
/notification-sounds:configure-sound bell
/notification-sounds:configure-sound pop
/notification-sounds:configure-sound success

# Desactivar notificaciones
/notification-sounds:configure-sound disable

# Reactivar notificaciones
/notification-sounds:configure-sound enable
```

## Agregar samples custom

1. Crea la carpeta de samples custom:

```bash
mkdir -p ~/.claude/notification-sounds/custom/
```

2. Copia tus archivos `.mp3` ahi:

```bash
cp mi-sonido.mp3 ~/.claude/notification-sounds/custom/
```

3. Seleccionalo:

```bash
/notification-sounds:configure-sound mi-sonido
```

### Meme Samples Pack

Hay un pack de 23 samples meme (Duke Nukem, Homer Simpson, Wazaaaaa, Wololo, ICQ, Super Mario, etc.) disponible por separado.

[Descargar Meme Samples Pack desde Google Drive](https://drive.google.com/file/d/1k6k1Gso8M1YDwC3zQUxZljNYCQ9hhGud/view?usp=sharing)

Para instalarlos:

```bash
# Descomprime el zip
unzip meme-samples-pack.zip -d ~/.claude/notification-sounds/custom/

# Pon modo aleatorio para disfrutarlos todos
/notification-sounds:configure-sound random
```

## Estructura del plugin

```
notification-sounds-plugin/
├── .claude-plugin/
│   └── plugin.json            # Manifest del plugin
├── hooks/
│   └── hooks.json             # Stop hook config
├── samples/                   # Samples royalty-free incluidos
│   ├── ding.mp3
│   ├── chime.mp3
│   ├── bell.mp3
│   ├── pop.mp3
│   └── success.mp3
├── scripts/
│   ├── play-sound.sh          # Reproduce el sonido (ejecutado por el hook)
│   ├── list-samples.sh        # Lista samples disponibles
│   └── set-sound.sh           # Cambia la preferencia
├── skills/
│   └── notification-sounds/
│       └── SKILL.md           # Skill de configuracion
├── settings.json              # Permisos de audio
└── README.md
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
