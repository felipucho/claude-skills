# Global rules

User writes Rioplatense Spanish. Reply in Spanish. Code, commits, docs: normal prose.

## 1. Caveman ultra, always
- Session starts in caveman **ultra** (`%APPDATA%\caveman\config.json`). If hook says other level, switch to ultra.
- Drop only on security warnings, irreversible confirmations, or when user asks to clarify.

## 2. Code search = codebase-memory index, ALWAYS
Any "where is / who calls / what does / how works / find code" in a code repo:
1. `index_status` / `list_projects`. Not indexed: `index_repository` first (auto_index is on, but check).
2. `search_graph` (symbols), `trace_path` (callers/callees), `get_code_snippet` (source), `get_architecture` (overview), `query_graph` (multi-hop), `detect_changes` (impact of diff).
3. `check_index_coverage` on paths relied on.
- Grep only for: literals, config, non-code files, coverage gaps.
- Never use Explore agent, broad Grep, or reading whole files to locate code when index exists.
- Delegating search: use `codebase-memory-scout` / `codebase-memory` agents, pass graph findings in prompt.
- Load MCP tools via ToolSearch `select:` if deferred.

## 3. Skills first, never improvise
If a skill matches task: load it with Skill tool BEFORE working, follow it. No skill fits: say so, then work.
Load the ONE best skill, not several overlapping ones.

| Task | Skill |
|---|---|
| New UI / landing / page | `frontend-design`, then `design-taste-frontend` |
| Redesign existing UI | `redesign-existing-projects` |
| UI polish, audit, critique | `impeccable`, `emil-design-eng`, `web-design-guidelines` |
| Animation / motion | `animate` |
| Design tokens / design system | `design-system` |
| Logo, brand, banners, icons | `design`, `banner-design` |
| Visual HTML artifact, prototype, dashboard | `web-design-engineer` |
| Theme for artifact | `theme-factory` |
| Poster / static art / generative art | `canvas-design`, `algorithmic-art` |
| React / Next.js perf | `vercel-react-best-practices` |
| Test local web app | `webapp-testing` |
| Code structure, callers, dead code | `codebase-memory` |
| Over-engineering, simplest solution | `ponytail`, `ponytail-review`, `ponytail-audit` |
| Code review / security | `code-review`, `security-review` |
| Marketing copy | `copywriting`, `copy-editing`, `marketing-psychology` |
| Customer research | `customer-research` |
| SEO | `seo`, `seo-audit`, `claude-seo:*` |
| Word / PDF / PPT / Excel | `docx`, `pdf`, `pptx`, `xlsx` |
| Long doc / spec writing | `doc-coauthoring` |
| Web scraping | `scrapling-official` |
| AI images | `ai-image-generation` |
| MCP server | `mcp-builder` |
| Create skill / find skill | `skill-creator`, `find-skills` |
| Claude API / SDK | `claude-api` |

## 4. ECC plugin: disabled, read on demand
ECC (~290 skills, 80 agents) is installed but disabled to save tokens. Its files stay on disk:
`~/.claude/plugins/cache/ecc/ecc/<version>/skills/<name>/SKILL.md` and `.../agents/<name>.md` (glob `ecc/ecc/*/` for version).
- Task matches skill below and no own skill covers it: Read ONLY that SKILL.md (or agent .md) and follow it. Do not enable plugin, do not list whole folder.
- Need ECC slash commands, hooks, or agents as subagent_type: tell user to run `claude plugin enable ecc@ecc` + restart; `claude plugin disable ecc@ecc` after.

| Task | ECC skill / agent |
|---|---|
| Context/token budget, when to compact | `strategic-compact`, `context-budget`, `token-budget-advisor` |
| React / frontend patterns, perf | `react-patterns`, `react-performance`, `frontend-patterns` |
| Next.js / Vite | `nextjs-turbopack`, `vite-patterns` |
| Accessibility (WCAG) | `accessibility`, `frontend-a11y`; agent `a11y-architect` |
| Motion deep dive | `motion-foundations`, `motion-patterns`, `motion-advanced` |
| UI feel, glass style | `make-interfaces-feel-better`, `liquid-glass-design` |
| Dashboard | `dashboard-builder` |
| Slides in HTML | `frontend-slides` |
| Video with code | `remotion-video-creation` |
| Browser QA / E2E | `browser-qa`, `e2e-testing` |
| TDD | `tdd-workflow` |
| API / backend / errors | `api-design`, `backend-patterns`, `error-handling` |
| DB | `postgres-patterns`, `prisma-patterns` |
| Docker / deploy | `docker-patterns`, `deployment-patterns` |
| GitHub ops | `github-ops` |
| Research before building | `search-first`, `deep-research` |
| Review agents | `react-reviewer`, `typescript-reviewer`, `security-reviewer`, `performance-optimizer`, `build-error-resolver` |

## 5. Token saving
- Search with index (sec. 2). Read files with `offset`/`limit` when location known. Never re-read file after Edit/Write.
- Grep: `files_with_matches` first, `head_limit`, narrow `glob`/`type`.
- Long command output: `tail`/`head`/filters. Never dump full logs.
- Parallel independent tool calls in one message.
- Subagents only for broad work; prefer `caveman:cavecrew-investigator` / `codebase-memory-scout` (compressed output) over `Explore`.
- No preamble, no recap, no restating plan. Final summary max 2 lines.
- Long session: suggest `/compact` after finishing a phase.
- Skill already loaded this session: do not reload.
