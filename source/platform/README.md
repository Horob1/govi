# platform - alias

Actual adapters are in `entry/src/main/ets/platform/` (13 services: Notification, Storage, File, Biometric, Push, IAP, BackgroundTask, DeepLink, Permission, DeviceInfo, Network, Location, Analytics).
Each service defines a common interface, implements HarmonyOS native, and documents bridge for Android (Kotlin BridgePlugin) / iOS (Swift ARBridgePlugin).