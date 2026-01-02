# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# SPDX-License-Identifier: MPL-2.0

cmake_minimum_required(VERSION 3.21)

include(CheckCSourceCompiles)
set(ASCO_INCLUDE_DIR "${CMAKE_SOURCE_DIR}/include")

check_c_source_compiles("
#include \"${ASCO_INCLUDE_DIR}/asco/asco.h\"
#ifndef ASCO_WIN_X86_64
#error \"Incorrect architecture\"
#endif
int main(void) {}
" ASCO_ARCH_WIN_X86_64)
check_c_source_compiles("
#include \"${ASCO_INCLUDE_DIR}/asco/asco.h\"
#ifndef ASCO_GNU_X86_64
#error \"Incorrect architecture\"
#endif
int main(void) {}
" ASCO_ARCH_GNU_X86_64)
check_c_source_compiles("
#include \"${ASCO_INCLUDE_DIR}/asco/asco.h\"
#ifndef ASCO_WIN_X86
#error \"Incorrect architecture\"
#endif
int main(void) {}
" ASCO_ARCH_WIN_X86)
check_c_source_compiles("
#include \"${ASCO_INCLUDE_DIR}/asco/asco.h\"
#ifndef ASCO_GNU_X86
#error \"Incorrect architecture\"
#endif
int main(void) {}
" ASCO_ARCH_GNU_X86)
check_c_source_compiles("
#include \"${ASCO_INCLUDE_DIR}/asco/asco.h\"
#ifndef ASCO_AARCH64
#error \"Incorrect architecture\"
#endif
int main(void) {}
" ASCO_ARCH_AARCH64)
check_c_source_compiles("
#include \"${ASCO_INCLUDE_DIR}/asco/asco.h\"
#ifndef ASCO_ARM32
#error \"Incorrect architecture\"
#endif
int main(void) {}
" ASCO_ARCH_ARM32)

if(ASCO_ARCH_WIN_X86_64)
set(ASCO_PLATFORM_FILES "${ASCO_SOURCE_DIR}/win-x86_64.s")
elseif(ASCO_ARCH_GNU_X86_64)
set(ASCO_PLATFORM_FILES "${ASCO_SOURCE_DIR}/gnu-x86_64.s")
elseif(ASCO_ARCH_WIN_X86)
set(ASCO_PLATFORM_FILES "${ASCO_SOURCE_DIR}/win-x86.s")
elseif(ASCO_ARCH_GNU_X86)
set(ASCO_PLATFORM_FILES "${ASCO_SOURCE_DIR}/gnu-x86.s")
elseif(ASCO_ARCH_AARCH64)
set(ASCO_PLATFORM_FILES "${ASCO_SOURCE_DIR}/aarch64.s")
elseif(ASCO_ARCH_ARM32)
set(ASCO_PLATFORM_FILES "${ASCO_SOURCE_DIR}/arm32.s")
else()
message(SEND_ERROR "Unsupported architecture.")
endif()


add_library(asco
	"${ASCO_SOURCE_DIR}/asco.c"
	"${ASCO_INCLUDE_FILES}"
	"${ASCO_PLATFORM_FILES}"
)

target_include_directories(asco PUBLIC ${ASCO_INCLUDE_DIR})
