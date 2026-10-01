# claude-skills

Direcciones de todas las skills, plugins y herramientas que uso en Claude Code, para reinstalarlas en otra PC.

## 1. Skills

Requiere Node.js. Desde la carpeta del repo:

```bash
# Windows (PowerShell)
powershell -ExecutionPolicy Bypass -File install.ps1

# macOS / Linux / Git Bash
bash install.sh
```

La lista está en [skills.txt](skills.txt) (`<fuente> <skill>`). Una sola:

```bash
npx skills add vercel-labs/agent-skills --skill web-design-guidelines -g -a claude-code -y
```

## 2. Plugins

Ver [plugins.md](plugins.md).

## 3. Instalación aparte

| Qué | Dónde | Cómo |
|---|---|---|
| `codebase-memory` (skill + MCP + agentes) | [DeusData/codebase-memory-mcp](https://github.com/DeusData/codebase-memory-mcp) | Descargar `install.ps1` del repo, revisarlo y ejecutarlo; reiniciar Claude Code |
| Familia `seo-*` (26 sub-skills + agentes) | [AgriciDaniel/claude-seo](https://github.com/AgriciDaniel/claude-seo) | `/plugin marketplace add AgriciDaniel/claude-seo`, `/plugin install claude-seo@agricidaniel-claude-seo`, `/seo setup` |

> Las skills `seo` y `seo-audit` de `skills.txt` pueden quedar pisadas por claude-seo: comparten nombre. Instalá claude-seo al final si querés la versión completa.
