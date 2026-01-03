# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# SPDX-License-Identifier: MPL-2.0

cmake_minimum_required(VERSION 3.21)

include(CheckSymbolExists)

check_symbol_exists("ASCO_ARCH_AARCH64" "${ASCO_INCLUDE_DIR}/asco/arch-detection.h" ASCO_ARCH_AARCH64)
check_symbol_exists("ASCO_ARCH_X86_64" "${ASCO_INCLUDE_DIR}/asco/arch-detection.h" ASCO_ARCH_X86_64)
check_symbol_exists("ASCO_OS_UNIX" "${ASCO_INCLUDE_DIR}/asco/arch-detection.h" ASCO_OS_UNIX)

if(ASCO_ARCH_X86_64 AND ASCO_OS_UNIX)
	set(ASCO_PLATFORM_FILES "${ASCO_SOURCE_DIR}/gnu-x86_64.s")
elseif(ASCO_ARCH_AARCH64)
	set(ASCO_PLATFORM_FILES "${ASCO_SOURCE_DIR}/aarch64.s")
else()
message(SEND_ERROR "Unsupported architecture.")
endif()


add_library(asco
	"${ASCO_SOURCE_DIR}/asco.c"
	"${ASCO_INCLUDE_FILES}"
	"${ASCO_PLATFORM_FILES}"
)

target_include_directories(asco PUBLIC ${ASCO_INCLUDE_DIR})
