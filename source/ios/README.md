# ios - placeholder

Reserved for a standalone iOS module if the project ever ejects from ArkUI-X.

## Current state

iOS is delivered via ArkUI-X at `source/.arkui-x/ios/` (Xcode project, `AppDelegate.m`, `EntryEntryAbilityViewController.m`).
This folder stays empty and is kept with `.gitkeep` so the module structure is visible in git.

## When to use this folder

Only if a native iOS feature cannot be bridged via ArkUI-X `ARBridgePlugin`.
Otherwise add bridges under `.arkui-x/ios/app/Bridge/` and expose via platform services in `entry/src/main/ets/platform/`.

## See also

- `.arkui-x/ios/` - actual iOS scaffold
- `entry/src/main/ets/native/README.md` - bridge docs
- `entry/src/main/ets/platform/` - service interfaces
