# harmony - placeholder

Reserved for an extracted HarmonyOS feature module (HSP/HAR).

## Current state

All HarmonyOS code lives in `source/entry/` (HAP) and `source/AppScope/`.
This folder stays empty and is kept with `.gitkeep` so a future `harmony/` module can be added without moving files.

## When to use this folder

Create a new module via DevEco Studio (File > New > Module) targeting this directory when a feature needs independent versioning or sharing between apps.
Register it in `source/build-profile.json5` under `modules`.

## See also

- `source/entry/` - current entry module
- `source/build-profile.json5` - product/module list
