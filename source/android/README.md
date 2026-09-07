# android - placeholder

Reserved for a standalone Android module if the project ever ejects from ArkUI-X.

## Current state

Android is delivered via ArkUI-X at `source/.arkui-x/android/` (Gradle, `MyApplication.java`, `EntryEntryAbilityActivity.java`).
This folder stays empty and is kept with `.gitkeep` so the module structure is visible in git.

## When to use this folder

Only if a native Android feature cannot be bridged via ArkUI-X `BridgePlugin`.
Otherwise add bridges under `.arkui-x/android/app/src/main/java/com/horob1/govi/bridge/` and expose via platform services in `entry/src/main/ets/platform/`.

## See also

- `.arkui-x/android/` - actual Android scaffold
- `entry/src/main/ets/native/README.md` - bridge docs
- `entry/src/main/ets/platform/` - service interfaces
