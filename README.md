# Govi

Personal finance app built with HarmonyOS ArkTS and ArkUI-X (Android / iOS via single codebase).

## Stack

- HarmonyOS SDK 6.0.1 (API 21), ArkTS strict mode.
- ArkUI-X for cross-platform (Android Gradle + iOS Xcode bridges).
- Hvigor build, OHPM packages (`@ohos/hypium`, `@ohos/hamock`).
- State: `AppStore` (shared/state), Repository pattern, UseCases.

## Project Structure

```
E:/Govi
  source/                      # HarmonyOS project root (hvigor entry)
    AppScope/                  # bundleName com.horob1.govi, app.json5, icons
    entry/                     # main module (HAP)
      src/main/ets/
        entryability/          # EntryAbility
        pages/                 # Index.ets (router host)
        platform/              # 13 platform services (actual code)
        shared/                # domain / data / repository / state / ui / utils / locales
        native/                # bridge docs (Android BridgePlugin / iOS ARBridgePlugin)
      src/main/resources/      # base / en_US / zh_CN strings, colors, media
      src/test | ohosTest | mock
    .arkui-x/                  # ArkUI-X scaffolding (android/ ios/ + arkui-x-config.json5)
    android/ harmon y/ ios/    # placeholder modules (see respective README)
    platform/ shared/          # alias docs only - real code lives under entry/src/main/ets/
    hvigor/                    # hvigor-config.json5
    oh-package.json5
  scripts/                     # automation scripts (build, lint, i18n check)
  .wiki/.design/               # design system - glassmorphism, tokens, components, motion
  .specify/                    # specs (reserved)
```

Alias folders `source/platform` and `source/shared` are docs only.
Real code is under `entry/src/main/ets/platform/` and `entry/src/main/ets/shared/`.

## Quick Start

1. Requirements: DevEco Studio 5+, HarmonyOS SDK 6.0.1, Node 18+, ohpm, hvigor.
2. Clone and install deps: `cd source && ohpm install`.
3. Open `source/` in DevEco Studio (not the repo root).
4. Sync hvigor and run on emulator/device.

### ArkUI-X (Android / iOS)

- Android: `source/.arkui-x/android/` - Gradle wrapper included, open with Android Studio if needed.
- iOS: `source/.arkui-x/ios/` - Xcode project, open `app.xcodeproj`.
- Bridges: see `source/entry/src/main/ets/native/README.md` for BridgePlugin registration.

## Design System

Read `.wiki/.design/*` before any UI work.
No read means no merge.

- Foundation, tokens (light/dark), components, motion, patterns.
- Glassmorphism: blur 8-16px, opacity 10-30%, border 1px 20-30%, WCAG >= 4.5:1, max 2-3 glass panels per screen.
- Test BOTH light and dark themes for every UI change.

See `AGENTS.md` for mandatory language, localization, and architecture rules.

## Localization

- Locales: `en` (default), `vi`, `zh-CN`.
- ArkTS helper: `entry/src/main/ets/shared/utils/I18n.ets` - use `t("key")` or `r("app.string.key")`.
- Sources: `entry/src/main/ets/shared/locales/{en,vi,zh-CN}.json` + `AppScope/resources/{base,en_US,zh_CN}/element/string.json`.
- Never hardcode UI text.

## Platform Services

13 services under `entry/src/main/ets/platform/`: `Storage`, `File`, `Notification`, `Biometric`, `Push`, `InAppPurchase`, `BackgroundTask`, `DeepLink`, `Permission`, `DeviceInfo`, `Network`, `Location`, `Analytics`.
Each exposes a common interface with HarmonyOS implementation and documents Android/iOS bridge mapping.

## Scripts

See `scripts/README.md`.

## Git

Root `.gitignore` covers HarmonyOS/ArkUI-X/Node/IDE/OS/secrets.
Module-level `.gitignore` files remain in `source/` and `source/entry/` for DevEco defaults.

## License

Private - all rights reserved.
