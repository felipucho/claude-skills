# Prompt para que Claude lo instale todo

Abrí Claude Code en cualquier carpeta de la PC nueva y pegá esto:

````text
Cloná https://github.com/felipucho/claude-skills (si es privado, usá `gh auth login` primero) en una carpeta temporal y dejá mi Claude Code con las mismas skills y plugins que en mi otra PC. Seguí este orden:

1. Leé README.md (sobre todo "Errores conocidos"), skills.txt y plugins.md del repo.
2. Verificá que estén Node.js, git y la CLI `claude`. Si falta la CLI, instalala con `npm.cmd install -g @anthropic-ai/claude-code` (Windows) o `npm install -g @anthropic-ai/claude-code`. Si falta otra cosa, decime qué instalar y esperá. En Windows corré `npm`, `claude` y `skills` desde PowerShell con `.cmd`, no desde Git Bash.
3. Skills: corré install.ps1 (Windows, con `powershell -ExecutionPolicy Bypass -File install.ps1`) o install.sh (macOS/Linux) en background y no lo cortes a mitad. Si alguna falla, reintentala sola con `skills add <fuente> --skill <skill> -g -a claude-code -y` y anotá las que sigan fallando.
4. Plugins: seguí plugins.md con la CLI. Corré cada `marketplace add` de a uno, nunca en paralelo. Los "instalados pero desactivados" instalalos y desactivalos con `claude plugin disable`.
5. codebase-memory: primero `claude mcp list`. Si ya está conectado, saltealo. Si no, bajá su script de instalación, mostrame qué hace y esperá mi confirmación antes de ejecutarlo. No ejecutes nada remoto sin revisarlo.
6. Configuración (README sección 4): copiá config/CLAUDE.md a ~/.claude/CLAUDE.md y config/caveman-config.json a la ruta de caveman de mi sistema. Si ya existe un CLAUDE.md distinto, mostrame la diferencia y preguntá antes de pisarlo. Corré `codebase-memory-mcp config set auto_index true`. Agregá `"env": { "ECC_GATEGUARD": "off" }` a ~/.claude/settings.json sin tocar el resto del archivo.
7. Al final comprobá que cada skill de skills.txt exista en ~/.claude/skills y que los plugins aparezcan en `claude plugin list`. Listame: instaladas, fallidas y pasos que tengo que hacer yo (reiniciar Claude Code, `/plugin configure ecc@ecc`, `/seo setup`).

No modifiques otros archivos de mi configuración. Si algo no coincide con lo que dice el repo, avisame en vez de improvisar.
````
