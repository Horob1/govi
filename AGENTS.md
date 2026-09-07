# AGENTS.md - Project GOVI

## General Guidelines
- Never use en dash "--". Use plain dash "-".
- When writing commit messages, NEVER auto-add agent name as co-author.
- Never manually modify CHANGELOG.md or auto-generated files.
- When writing or editing long Markdown, put each sentence on its own line.
- Prefer quality, simplicity, robustness, scalability, long term maintainability.

## Language Rule - MANDATORY

**Everything in this project MUST be written in English.**

- Applies to: code, comments, commit messages, docs, wiki (`.wiki/`), specs (`.specify/`), design rules (`.wiki/.design/`), PR descriptions, and issue titles.
- Exception: user-visible strings are handled via i18n - keys stay English, translations live in locale files (`vi.json`, `zh-CN.json`, `string.json`). Do not write Vietnamese/Chinese directly in code.
- If you add or edit any file, write it in English. Rewrite Vietnamese content to English in the same change.
- Review checklist: no Vietnamese/Chinese in code/comments/docs outside locale files.

## Localization Rule - MANDATORY

**NEVER hardcode UI text.** Every user-visible string MUST go through i18n.

- Supported locales: `vi` (Vietnamese), `en` (English, default), `zh-CN` (Chinese).
- Source of truth: `entry/src/main/ets/shared/locales/{vi,en,zh-CN}.json` + HarmonyOS resources `AppScope/resources/{base,en_US,zh_CN}/element/string.json`.
- Helper: `entry/src/main/ets/shared/utils/I18n.ets` - use `t("key")` or `getString("key")` in ArkTS. For layout that supports `r`, prefer `r("app.string.key")`.
- When adding new UI text:
  1. Add key to all three locale JSONs (`vi.json`, `en.json`, `zh-CN.json`).
  2. Add matching entry to all three `string.json` resource files.
  3. Use `t("your_key")` in `.ets` - never write literal English/Vietnamese/Chinese directly.
  4. Category names, error messages, button labels, placeholders all count as UI text.
- Exceptions: logs (hilog), technical keys, currency codes (VND), debug text.
- Review checklist: grep for hardcoded strings in ets files must return no user text; only `t(` or `r(` should contain strings.
- If you fix a bug and touch UI text, migrate it to i18n in same PR.

## Design - .wiki/.design/ is LAW for UI (PREREQUISITE)

> Every new or edited UI MUST read `.wiki/.design/*` BEFORE coding. No read = no merge. This is a prerequisite for all UI work.

- Location: `E:\Govi\.wiki\.design\` - caveman style, 6 files: `README.md` + `01-foundation.md` + `02-tokens.md` + `03-components.md` + `04-motion.md` + `05-patterns.md`.
- Themes: light + dark - tokens in `02-tokens.md`, switch via system setting, test BOTH before merge.
- Glassmorphism: blur 8-16px (start 4-6px), opacity 10-30%, border 1px 20-30%, WCAG >=4.5:1, max 2-3 glass panels per screen.
- Components: nav / card / modal / input / FAB / sidebar / toast - params in `03-components.md`, do not invent custom values.
- Motion: enter/exit 200-300ms ease-out, NEVER animate blur, respect reduced-motion - see `04-motion.md`.
- Patterns: when to use vs not, solid fallback, review checklist - see `05-patterns.md`.
- Gate: UI PRs must tick the checklists in `README.md` + `05-patterns.md`; missing ticks = reject.
- Stack: ArkTS strict, shared code in `entry/src/main/ets/shared/`, alias `source/shared` is docs only.

## Architecture
- ArkTS strict: no `any`, no `eval`, no dynamic properties.
- Shared code in `entry/src/main/ets/shared/` (domain/data/repository/state/utils/ui). Platform adapters in `entry/src/main/ets/platform/`.
- Alias folders `source/shared` and `source/platform` are docs only; real code is under `entry/src/main/ets/`.

## Verification
- After editing `.ets`, run hvigor sync or check DevEco Studio shows 0 red.
- Test locales by switching device language to en / vi / zh-CN.
- Test BOTH light and dark themes for every UI change (see `.wiki/.design/02-tokens.md`).