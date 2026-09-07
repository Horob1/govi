# Native Layer - HarmonyOS Capabilities and Cross-Platform Bridges

This folder documents HarmonyOS-native capabilities used via `platform/*` and the ArkUI-X bridge plan for Android/iOS.

> Rule: Feature code never imports HarmonyOS kits directly.
> `feature/ui -> platform/* -> HarmonyOS API` and `shared/*` stays cross-platform.

## Dependency Decision (per DEPENDENCIES.md)

Native capabilities use HarmonyOS SDK / ArkUI / ArkTS directly.
Small utilities (Logger, Uuid, Validation, ApiClient, DateUtils) are owned in `shared/utils/` - 20 lines cheaper than a permanent dep.

Cross-platform exceptions that need a library (ArkTS Image cannot fully render SVG 1.1, native requires full spec):

* SVG: `@ohos/svg` ^2.2.3 (OpenHarmony-SIG/ohos_svg, Apache 2.0, API12, cross via ArkTS pure - no BridgePlugin needed) - `ohpm install @ohos/svg`. Covers 3 native types that Image cannot: gradients, masks, image-in-svg. Used via `shared/ui/components/SvgIcon.ets` -> `SVGImageView` reading `resources/rawfile/*.svg` through `GlobalContext` set in `EntryAbility.onCreate`.
* Icon: no separate ohpm icon pack installed. Primary icon system is ONE style per DEPENDENCIES.md 3.2: HarmonyOS `SymbolGlyph` (4000+ system symbols, vector, theme-aware, no install) + owned SVG assets rendered by `@ohos/svg`. `Category.icon` currently Unicode emoji for stub, upgrade to SVG via `SvgIcon` when assets ready. No FontAwesome/Material/Lucide mix.

`source/oh-package.json5` now has `dependencies: { "@ohos/svg": "^2.2.3" }` + `devDependencies` `hypium/hamock`. `entry/oh-package.json5` stays empty (transitive via `source`).

## Native Capabilities - Owner and Status

| # | Capability | HarmonyOS Kit | Platform Service | Status | Cross Bridge (later) |
|---|------------|---------------|------------------|--------|----------------------|
| 1 | Ability | `@kit.AbilityKit` | `EntryAbility.ets` | done - lifecycle + context | N/A - ArkUI-X wraps Ability |
| 2 | Storage (Preferences) | `@kit.ArkData` `preferences` | `StorageService` | stub - in-memory now, upgrade to `preferences.getPreferences` when context injected via `EntryAbility` | Android: `BridgePlugin` + `SharedPreferences`, iOS: `NSUserDefaults`, channel `StorageBridge` |
| 3 | Database (Relational Store) | `@kit.ArkData` `relationalStore` | `TransactionRepositoryImpl` | stub - in-memory arrays, upgrade to `relationalStore.getRdbStore` with `Account/Transaction/Budget` tables | Android: `Room`, iOS: `CoreData/GRDB`, channel `DatabaseBridge` - keep `Repository` interface unchanged |
| 4 | Notification | `@kit.NotificationKit` `notificationManager` | `NotificationService` | done - `publish` / `cancel` with `ContentType.BASIC_TEXT` | Android: `BridgePlugin` -> `NotificationManager`, iOS: `ARBridgePlugin` -> `UNUserNotificationCenter`, channel `NotifyBridge` |
| 5 | Scheduler / Reminder | `@kit.CalendarKit` / `reminderAgentManager` | `BackgroundTaskService` | stub - `hilog` only, upgrade to `reminderAgentManager.publishReminder` | Android: `WorkManager/AlarmManager`, iOS: `BGTaskScheduler`, channel `SchedulerBridge` |
| 6 | Background Task | `@kit.BackgroundTasksKit` | `BackgroundTaskService` | stub - schedule/cancel logs, upgrade to `backgroundTaskManager` | Android: `WorkManager`, iOS: `BGTask` |
| 7 | Permission | `@ohos.abilityAccessCtrl` | `PermissionService` | done - `AtManager.checkAccessToken`, stub request returns false in preview | Android: `ActivityCompat.requestPermissions`, iOS: `permission_handler`, channel `PermissionBridge` |
| 8 | Network / HTTP | `@ohos.net.http` | `NetworkService` + `shared/utils/ApiClient` | done - `http.createHttp` with `request/destroy`, `ApiClient` adds headers/auth/timeout/logging | Android: `OkHttp` bridge if needed, iOS: `URLSession`, but ArkUI-X http works cross-platform - bridge only for cert pinning |
| 9 | Network State | `@ohos.net.connection` | `NetworkService` (extend) | pending - add `connection.hasDefaultNet` check | Android/iOS via same kit or `ConnectivityManager` bridge |
| 10 | File System | `@ohos.file.fs` | `FileService` | done - `fs.open/write/readText/close` | Android: `BridgePlugin` scoped storage, iOS: `FileManager`, channel `FileBridge` |
| 11 | Window / Safe Area | `@ohos.window` | `AppTheme` / `AppHeader` | pending - avoid hardcoding insets, upgrade to `window.getLastWindow().getWindowAvoidArea` | ArkUI handles safe area cross-platform - no bridge needed unless fullscreen |
| 12 | Security / Keystore | `@kit.AssetKit` / `huks` | `SecureStorageService` | stub - prefixed in-memory, upgrade to `asset` or `huks` for tokens | Android: `EncryptedSharedPreferences/Keystore`, iOS: `Keychain`, channel `SecureStorageBridge` |
| 13 | Biometric | `@ohos.userIAM.userAuth` | `BiometricService` | done - `userAuth.getUserAuthInstance`, stub returns true in preview | Android: `BiometricPrompt`, iOS: `LocalAuthentication`, channel `BiometricBridge` |
| 14 | Location | `@ohos.geoLocationManager` | `LocationService` | done - `getCurrentLocation` with `FIRST_FIX` | Android: `FusedLocationProvider`, iOS: `CLLocationManager` |
| 15 | Haptic | `@ohos.vibrator` | (future `HapticService`) | not needed yet - per spec haptic is subtle, add only when feature needs it | Android: `Vibrator`, iOS: `UIFeedbackGenerator` |
| 16 | Push | `Push Kit` | `PushService` | stub - mock token, upgrade to `@kit.PushKit` when server push needed | Android: `FCM`, iOS: `APNs`, channel `PushBridge` - keep local vs remote push separate |
| 17 | In-App Purchase | `@kit.PaymentKit` | `InAppPurchaseService` | stub - mock purchase | Android: `Google Play Billing`, iOS: `StoreKit`, channel `IAPBridge` |
| 18 | Device Info | `@ohos.deviceInfo` | `DeviceInfoService` | done - `osFullName/marketName/odid` | No bridge - cross uses same abstraction |
| 19 | Analytics / Logging | `@kit.PerformanceAnalysisKit` `hilog` | `AnalyticsService` + `shared/utils/Logger` | done - `hilog.info/warn/error` via `Logger` | No bridge - native logging only |
| 20 | Deep Link | `@ohos.router` / `want` | `DeepLinkService` | stub - `URL` parse + `router.pushUrl` | ArkUI-X deep link handling + Android Intent / iOS Universal Link bridge |

## Bridge Architecture (when to build)

Do not build a bridge until a feature needs it on Android/iOS.

```
ArkTS (shared/platform)
  -> platform/Service (interface)
    -> HarmonyOS impl (current, in platform/Service.ets)
    -> Android impl (later, Kotlin BridgePlugin in .arkui-x/android/app/src/main/java/com/horob1/govi/bridge/)
    -> iOS impl (later, Swift ARBridgePlugin in .arkui-x/ios/app/Bridge/)
```

Registration:

* Android: `MyApplication.java` `BridgeManager.register(new NotifyBridge())` etc.
* iOS: `AppDelegate.m` register `NotifyBridge` implementing `ARBridgePlugin`
* ArkTS: `import { bridge } from "@arkui-x.bridge"; bridge.createBridge("NotifyBridge").callMethod("send", JSON.stringify(opts))`

## Upgrade Paths (keeps build green now)

* `StorageService` - inject `Context` from `EntryAbility.onCreate` via `AppStorage` or constructor, then replace `memoryStore` with `preferences`.
* `TransactionRepositoryImpl` - inject `relationalStore.RdbStore`, create tables for `Transaction/Budget`.
* `FileService.getFilesDir` - return `getContext().filesDir` instead of hardcoded `/data/storage/el2/base/files`.
* `PermissionService.request` - use `common.getContext()` + `atManager.requestPermissionsFromUser`.
* All stubs log via `Logger` so behavior is observable without context.

## What Is Installed vs Owned (per DEPENDENCIES.md Section 6-7)

Installed cross libs (commonly used, ArkTS compatible, maintained, small, removable):

* `@ohos/svg` ^2.2.3 - SVG 1.1 parsing/rendering, ArkTS pure, cross via ArkUI-X, 18 versions, Apache 2.0. Needed because ArkTS `Image` cannot render gradients/masks/image-in-svg natively.
* `@ohos/axios` ^2.2.15 - promise HTTP, OpenHarmony Axios adapt, 43 versions, MIT, cross (no bridge). Installed as cross alternative to owned `ApiClient` (native `http` kit). Use `AxiosClient` for cross, `ApiClient` for native fallback.
* `dayjs` ^1.11.13 - 2KB immutable date/time, MIT, cross. Installed as optional for timezone/duration/recurring per spec 3.5. `DateUtils` remains primary for simple format/compare.

Owned (20 lines cheaper than dep, no install):

* `Uuid`, `Validation`, `Logger`, `DateUtils` fallback, debounce/throttle - never installed `lodash`, `moment`, `uuid` lib.

Not installed: `firebase`, `redux`, `zustand`, `framer-motion`, `react-native-*`, `lodash` etc. - add only when feature proves native + owned cannot solve, checked for ArkTS compatibility, maintenance, bundle cost, and removability.

## Cross-Platform Layer

* UI: `ArkUI` only (`shared/ui/components`, `AppTheme`) - no external UI framework (spec 3.1)
* Icon: `SymbolGlyph` (4000+ HarmonyOS symbols, vector, theme-aware) + owned SVG assets via `SvgIcon` (`@ohos/svg`) - one primary style (spec 3.2)
* SVG: `@ohos/svg` ^2.2.3 cross (ArkTS pure, no bridge) via `shared/ui/components/SvgIcon.ets` for full SVG 1.1 (gradients/masks). Static assets in `resources/rawfile/*.svg` (spec 3.3)
* Animation: `ArkUI` `animation` / `transition` APIs (spec 3.4) - no `framer-motion`
* Date/Time: `shared/utils/DateUtils` native + `dayjs` ^1.11.13 cross optional for timezone/duration/recurring (spec 3.5) - `formatDateDayjs` demonstrates
* UUID: `shared/utils/Uuid` owned (spec 3.6) - no `uuid` lib install
* Network: `shared/utils/ApiClient` (HarmonyOS `http` kit, needs bridge note) + `shared/utils/AxiosClient` cross via `@ohos/axios` ^2.2.15 (OpenHarmony Axios adapt, promise-based, no bridge) (spec 3.7)
* Validation: `shared/utils/Validation` owned (spec 3.8)
* Logging: `shared/utils/Logger` owned wrapper around `hilog` (spec 3.9)
* Utilities: owned debounce/throttle in `shared/utils` - no `lodash` (spec 3.10)

## References

* `AGENTS.md` - language, i18n, design law
* `DEPENDENCIES.md` - full decision rules (root Downloads, source of truth for this doc)
* `platform/*/Service.ets` - 13 services, each is the single owner of its native dependency
