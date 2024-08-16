#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from the proprietary version
include vendor/xiaomi/miuicamera/common/BoardConfigVendor.mk

MIUICAMERA_PATH := vendor/xiaomi/miuicamera

# Properties
TARGET_SYSTEM_PROP += $(MIUICAMERA_PATH)/system.prop
