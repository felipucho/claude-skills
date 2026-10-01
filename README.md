# claude-skills

Direcciones de todas las skills, plugins y herramientas que uso en Claude Code, para reinstalarlas en otra PC.

> Para que lo haga todo Claude: pegá el prompt de [PROMPT.md](PROMPT.md).

## 0. Requisitos

- Node.js, git y la CLI `claude`.
- Si falta la CLI: `npm.cmd install -g @anthropic-ai/claude-code` (Windows) o `npm install -g @anthropic-ai/claude-code`.
- Windows: para que `npm` y `claude` anden en PowerShell, una vez y sin admin:
  `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`. Si no, usar `npm.cmd` y `claude.cmd`.

## 1. Skills

Desde la carpeta del repo:

```bash
# Windows (PowerShell)
powershell -ExecutionPolicy Bypass -File install.ps1

# macOS / Linux
bash install.sh
```

Los scripts agrupan las skills por repo (`--skill a b c`) y corren cada repo en paralelo. Al final verifican que cada skill tenga su `SKILL.md` en `~/.claude/skills`.

La lista está en [skills.txt](skills.txt) (`<fuente> <skill>`). Una sola:

```bash
npx skills add vercel-labs/agent-skills --skill web-design-guidelines -g -a claude-code -y
```

## 2. Plugins

Ver [plugins.md](plugins.md). Incluye `claude-seo` (familia `seo-*`).

> Las skills `seo` y `seo-audit` de `skills.txt` comparten nombre con skills de claude-seo. Las del plugin quedan con prefijo `claude-seo:`, así que conviven.

## 3. Instalación aparte

| Qué | Dónde | Cómo |
|---|---|---|
| `codebase-memory` (skill + MCP + agentes) | [DeusData/codebase-memory-mcp](https://github.com/DeusData/codebase-memory-mcp) | Primero `claude mcp list`: si ya aparece `codebase-memory-mcp` conectado, no hacer nada. Si no, descargar `install.ps1` del repo, revisarlo y ejecutarlo; reiniciar Claude Code |

## 4. Configuración

Archivos en [config/](config):

| Archivo | Destino | Qué hace |
|---|---|---|
| `config/CLAUDE.md` | `~/.claude/CLAUDE.md` | Reglas globales: caveman ultra, buscar código siempre con el índice de codebase-memory, usar skills antes de improvisar (tabla tarea → skill), ahorro de tokens |
| `config/caveman-config.json` | Windows: `%APPDATA%\caveman\config.json` · macOS/Linux: `~/.config/caveman/config.json` | Caveman arranca en `ultra` |

Además:

```bash
# Indexar repos automáticamente al abrirlos
codebase-memory-mcp config set auto_index true
```

En `~/.claude/settings.json`, agregar (sin pisar el resto) para apagar el hook GateGuard de ECC:

```json
"env": { "ECC_GATEGUARD": "off" }
```

## 5. Pasos manuales al final

1. Reiniciar Claude Code.
2. (Solo si activás ECC) `/plugin configure ecc@ecc`.
3. `/seo setup`.

## Errores conocidos (instalación real en Windows, 2026-10)

| Problema | Causa | Solución |
|---|---|---|
| `npm : No se puede cargar el archivo ...\npm.ps1 porque la ejecución de scripts está deshabilitada` | Política de PowerShell bloquea los `.ps1` de npm | Usar `npm.cmd` / `claude.cmd`, o `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` |
| `claude: command not found` en Git Bash, o `...\Git\Users\...\claude.exe: No such file or directory` | Los wrappers bash de npm global arman mal la ruta en Git Bash | Correr `claude` y `skills` desde PowerShell con `.cmd`, no desde Git Bash |
| Skills tardan muchísimo | El script viejo hacía un `npx` + clone por cada skill, en serie | Scripts nuevos: un clone por repo y repos en paralelo |
| `Failed to clean up a leftover marketplace staging directory ... EBUSY ... shallow.lock` | Un `git clone` de `marketplace add` quedó colgado (se cortó a mitad o se lanzaron varios en paralelo; ECC es grande) | Cerrar los `git.exe` de ese clone, borrar `~/.claude/plugins/marketplaces/<nombre>..clone` y reintentar **solo** |
| Warning `install scripts not yet covered by allowScripts` al instalar `@anthropic-ai/claude-code` | npm nuevo no corre postinstall por defecto | Inofensivo: `claude --version` funciona igual |
| `marketplace add obra/superpowers` crea `superpowers-dev` | No es el marketplace que se usa | No agregarlo; `superpowers` sale de `claude-plugins-official` |
| `2 userConfig options not yet set` al instalar `ecc` | ECC pide configuración | `/plugin configure ecc@ecc` dentro de Claude Code |
| Hook `[Fact-Forcing Gate]` bloquea el primer Bash/Write | Hook GateGuard de ECC | `"env": { "ECC_GATEGUARD": "off" }` en `settings.json` (sección 4) |
| codebase-memory no indexa solo | `auto_index` viene en `false` | `codebase-memory-mcp config set auto_index true` |

Reglas:

- No cortar a mitad un `marketplace add` ni una instalación de skills: deja procesos y carpetas trabadas.
- Antes de reinstalar algo, verificar si ya está (`~/.claude/skills`, `claude plugin list`, `claude mcp list`).
