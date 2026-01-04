# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# SPDX-License-Identifier: MPL-2.0

cmake_minimum_required(VERSION 3.21)

include(CheckSymbolExists)

check_symbol_exists("ASCO_ARCH_AARCH64" "${ASCO_INCLUDE_DIR}/asco/arch-detection.h" ASCO_ARCH_AARCH64)
check_symbol_exists("ASCO_ARCH_X86_64" "${ASCO_INCLUDE_DIR}/asco/arch-detection.h" ASCO_ARCH_X86_64)
check_symbol_exists("ASCO_OS_UNIX" "${ASCO_INCLUDE_DIR}/asco/arch-detection.h" ASCO_OS_UNIX)
check_symbol_exists("ASCO_OS_WINDOWS" "${ASCO_INCLUDE_DIR}/asco/arch-detection.h" ASCO_OS_WINDOWS)

if(ASCO_ARCH_X86_64 AND ASCO_OS_UNIX)
	if (ASCO_ASM_ATT)
		enable_language(ASM-ATT)
		set(ASCO_PLATFORM_FILES "${ASCO_SOURCE_DIR}/x86_64/sysv-att.s")
	elseif(ASCO_ASM_NASM)
		enable_language(ASM_NASM)
		set(ASCO_PLATFORM_FILES "${ASCO_SOURCE_DIR}/x86_64/sysv-nasm.asm")
	elseif(ASCO_ASM_ASM)
		enable_language(ASM) # maybe it'll work
		set(ASCO_PLATFORM_FILES "${ASCO_SOURCE_DIR}/x86_64/sysv-att.s")
	else()
		message(FATAL_ERROR "Couldn't find a suitable assembler")
	endif()
elseif(ASCO_ARCH_X86_64 AND ASCO_OS_WINDOWS)
	if (ASCO_ASM_ATT)
		enable_language(ASM-ATT)
		set(ASCO_PLATFORM_FILES "${ASCO_SOURCE_DIR}/x86_64/win64-att.s")
	elseif(ASCO_ASM_NASM)
		enable_language(ASM_NASM)
		set(ASCO_PLATFORM_FILES "${ASCO_SOURCE_DIR}/x86_64/win64-nasm.asm")
	elseif(ASCO_ASM_MASM)
		enable_language(ASM_MASM)
		set(ASCO_PLATFORM_FILES "${ASCO_SOURCE_DIR}/x86_64/win64-masm.asm")
	elseif(ASCO_ASM_ASM)
		enable_language(ASM) # maybe it'll work
		set(ASCO_PLATFORM_FILES "${ASCO_SOURCE_DIR}/x86_64/win64-att.s")
	else()
		message(FATAL_ERROR "Couldn't find a suitable assembler")
	endif()
elseif(ASCO_ARCH_AARCH64)
	if (ASCO_ASM_ASM)
		enable_language(ASM)
		set(ASCO_PLATFORM_FILES "${ASCO_SOURCE_DIR}/aarch64/as.s")
	elseif(ASCO_ASM_MARMASM)
		enable_language(ASM_MARMASM)
		set(ASCO_PLATFORM_FILES "${ASCO_SOURCE_DIR}/aarch64/marmasm.asm")
	else()
		message(FATAL_ERROR "Couldn't find a suitable assembler")
	endif()
else()
message(SEND_ERROR "Unsupported architecture.")
endif()


add_library(asco
	"${ASCO_PLATFORM_FILES}"
	"${ASCO_SOURCE_DIR}/asco.c"
	"${ASCO_INCLUDE_FILES}"
)

target_include_directories(asco PUBLIC ${ASCO_INCLUDE_DIR})
