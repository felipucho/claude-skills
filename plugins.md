# Plugins de Claude Code

Desde una terminal con la CLI `claude`, una línea por vez. En PowerShell sin política de scripts, usar `claude.cmd`.
Dentro de una sesión de Claude Code también sirve la forma `/plugin ...`.

Correr los `marketplace add` **de a uno**, no en paralelo (ver "Errores conocidos" en el README).

## Activos

```
claude plugin marketplace add JuliusBrussee/caveman
claude plugin install caveman@caveman

claude plugin marketplace add anthropics/claude-plugins-official
claude plugin install frontend-design@claude-plugins-official

claude plugin marketplace add affaan-m/ECC
claude plugin install ecc@ecc

claude plugin marketplace add AgriciDaniel/claude-seo
claude plugin install claude-seo@agricidaniel-claude-seo
```

Después, dentro de Claude Code: `/plugin configure ecc@ecc` (pide 2 opciones) y `/seo setup`.

## Instalados pero desactivados

```
claude plugin install superpowers@claude-plugins-official
claude plugin disable superpowers@claude-plugins-official

claude plugin install vercel@claude-plugins-official
claude plugin disable vercel@claude-plugins-official
```

> `superpowers` sale de `claude-plugins-official`. No hace falta `marketplace add obra/superpowers`: ese marketplace se registra como `superpowers-dev` y no se usa.
