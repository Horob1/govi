# Native Bridges

This folder documents native bridges for ArkUI-X.

- Android: `BridgePlugin` extends `com.huawei.arkui-x.BridgePlugin`
  - Example: NotifyBridge.kt, SecureStorageBridge.kt in `.arkui-x/android/app/src/main/java/com/horob1/govi/bridge/`
  - Registered in `MyApplication.java` via `BridgeManager.register(...)`
- iOS: `ARBridgePlugin` (Swift/ObjC) in `.arkui-x/ios/app/Bridge/`
  - Example: NotifyBridge.swift -> UNUserNotificationCenter
  - Registered in `AppDelegate.m`

ArkTS calls: `import { bridge } from "@arkui-x.bridge"; bridge.createBridge("NotifyBridge").callMethod("send", ...)`

Currently services in `platform/*` have HarmonyOS fallback. Bridges are only needed when running on Android/iOS devices.