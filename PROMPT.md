# Prompt para que Claude lo instale todo

Abrí Claude Code en cualquier carpeta de la PC nueva y pegá esto:

````text
Cloná https://github.com/felipucho/claude-skills (si es privado, usá `gh auth login` primero) en una carpeta temporal y dejá mi Claude Code con las mismas skills y plugins que en mi otra PC. Seguí este orden:

1. Leé README.md, skills.txt y plugins.md del repo.
2. Verificá que estén Node.js, git y la CLI `claude`. Si falta algo, decime qué instalar y esperá.
3. Skills: corré install.ps1 (Windows) o install.sh (macOS/Linux). Si alguna falla, reintentala sola con `npx -y skills add <fuente> --skill <skill> -g -a claude-code -y` y anotá las que sigan fallando.
4. Plugins: instalalos con la CLI (`claude plugin marketplace add <repo>` y `claude plugin install <plugin>`), según plugins.md. Los "instalados pero desactivados" instalalos y dejalos desactivados en settings.json.
5. Instalaciones aparte (codebase-memory y claude-seo): bajá el script de instalación, mostrame qué hace y esperá mi confirmación antes de ejecutarlo. No ejecutes nada remoto sin revisarlo.
6. Al final comprobá que cada skill de skills.txt exista en ~/.claude/skills y listame: instaladas, fallidas y pasos que tengo que hacer yo (reiniciar Claude Code, `/seo setup`).

No modifiques otros archivos de mi configuración. Si algo no coincide con lo que dice el repo, avisame en vez de improvisar.
````
