# MiuiCamera for Miatoll

Clone to `vendor/xiaomi/miuicamera` and add these lines in your device tree :
- In device.mk:
```
$(call inherit-product-if-exists, vendor/xiaomi/miuicamera/MiuiCamera.mk)
```
- In BoardConfig.mk:
```
-include vendor/xiaomi/miuicamera/BoardConfigMiuiCamera.mk
```
- In device FCM:
```
<hal format="hidl" optional="true">
    <name>vendor.xiaomi.hardware.misys</name>
    <version>1.0</version>
    <version>2.0</version>
    <version>3.0</version>
    <interface>
        <name>IMiSys</name>
        <instance>default</instance>
    </interface>
</hal>
```
