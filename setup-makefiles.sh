#!/bin/bash
#
# SPDX-FileCopyrightText: 2016 The CyanogenMod Project
# SPDX-FileCopyrightText: 2017-2024 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=common
VENDOR=xiaomi/miuicamera

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

function vendor_imports() {
    cat << EOF >> "$1"
		"vendor/xiaomi/miuicamera",
EOF
}

function lib_to_package_fixup_system_variants() {
    if [ "$2" != "system" ]; then
        return 1
    fi
    case "$1" in
        libmpbase | \
            libOpenCL | \
            libarcsoft_dualcam_refocus | \
            libarcsoft_dualcam_refocus_front | \
            libarcsoft_dualcam_refocus_rear_t | \
            libarcsoft_dualcam_refocus_rear_w | \
            libarcsoft_portrait_lighting | \
            libarcsoft_portrait_lighting_c)
            echo "$1_system"
            ;;
        *)
            return 1
            ;;
    esac
}

function lib_to_package_fixup() {
    lib_to_package_fixup_clang_rt_ubsan_standalone "$1" ||
        lib_to_package_fixup_proto_3_9_1 "$1" ||
        lib_to_package_fixup_system_variants "$@"
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" true

# Warning headers and guards
write_headers "arm64"
sed -i 's|TARGET_DEVICE|TARGET_ARCH|g' "${ANDROIDMK}"
sed -i 's|vendor/xiaomi/miuicamera/|vendor/xiaomi/miuicamera/common|g' "${PRODUCTMK}"
sed -i 's|device/xiaomi/miuicamera//setup-makefiles.sh|vendor/xiaomi/miuicamera/setup-makefiles.sh|g' "${ANDROIDBP}" "${ANDROIDMK}" "${BOARDMK}" "${PRODUCTMK}"

write_makefiles "${MY_DIR}/proprietary-files.txt" true

# Finish
write_footers
