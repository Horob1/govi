# scripts

Automation scripts for Govi.

## Contents

- Build helpers (`build.sh` / `build.ps1` - hvigor assemble).
- Lint and format (`lint.sh` - `code-linter.json5`).
- i18n check (`check-i18n.sh` - verifies `t()` keys exist in `vi/en/zh-CN.json` and `string.json`).
- Asset sync, version bump.

## Usage

Run from repo root: `scripts/<name>.sh`.

All scripts assume `source/` is the HarmonyOS project root.
Use PowerShell on Windows (`*.ps1` variants).

## Adding a new script

Keep scripts small and single-purpose.
Document usage at the top of the file and list it here.
