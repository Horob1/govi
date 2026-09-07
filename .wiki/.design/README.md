# .design - Glassmorphism Rulebook

> caveman - short, checklist, no essay.
> app: Govi finance - premium, modern, lightweight.

## Gate - MANDATORY

```
Every new/edit UI -> read .wiki/.design/* BEFORE coding.
No read = no merge.
AGENTS.md refs this as prerequisite.
```

## Map

| file | what |
|------|------|
| `01-foundation.md` | blur / opacity / depth / perf / a11y - core |
| `02-tokens.md` | light / dark tokens - color / blur / border / shadow / type |
| `03-components.md` | nav / card / modal / input / FAB / sidebar / toast - per-component spec |
| `04-motion.md` | enter / exit / easing / no-blur-animate / haptics |
| `05-patterns.md` | when to use, fallback, review checklist |

## 2 Themes

- `light` - white / light-gray glass + dark text, white border 20-30%
- `dark` - dark-gray / navy glass + light text, gray / navy border 20-30%
- full tokens -> `02-tokens.md`
- switch via system setting, test BOTH before merge

## Quick Check (every PR must pass)

- [ ] read 01-05 before coding?
- [ ] only 2-3 glass panels / screen?
- [ ] blur 8-16px, opacity 10-30%?
- [ ] WCAG >=4.5:1 (text) / >=3:1 (large)?
- [ ] no backdrop-filter animation?
- [ ] tested light + dark?
- [ ] fallback when blur off / low-end?

## Ref

- source spec: deep-research-report Glassmorphism (Titan / UXPilot / NN/g)
- code: `entry/src/main/ets/shared/` - ArkTS strict, i18n `t()`, no hardcoded text