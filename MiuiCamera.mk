#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from the proprietary version
$(call inherit-product, vendor/xiaomi/miuicamera/common/common-vendor.mk)

# Dex
PRODUCT_DEXPREOPT_SPEED_APPS += \
    MiuiCamera

# HIDL
PRODUCT_PACKAGES += \
    android.hidl.base@1.0 \
    android.hidl.base@1.0.vendor \
    android.hidl.memory.block@1.0 \
    android.hidl.memory.block@1.0.vendor

# Priv-app permission
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/privapp-permissions-miui.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-miui.xml

# Shims
PRODUCT_PACKAGES += \
    libgui_shim_miuicamera

# Sysconfig
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/miuicamera-hiddenapi-package-allowlist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/miuicamera-hiddenapi-package-allowlist.xml
