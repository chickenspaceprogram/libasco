# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# SPDX-License-Identifier: MPL-2.0

cmake_minimum_required(VERSION 3.21)
project(libasco C)

include(CheckLanguage)

check_language(ASM)
if (CMAKE_ASM_COMPILER)
set(ASCO_ASM_ASM ON)
endif()

check_language(ASM_NASM)
if (CMAKE_ASM_NASM_COMPILER)
set(ASCO_ASM_NASM ON)
endif()

check_language(ASM_MARMASM)
if (CMAKE_ASM_MARMASM_COMPILER)
set(ASCO_ASM_MARMASM ON)
endif()

check_language(ASM_MASM)
if (CMAKE_ASM_MASM_COMPILER)
set(ASCO_ASM_MASM ON)
endif()

check_language(ASM-ATT)
if (CMAKE_ASM-ATT_COMPILER)
set(ASCO_ASM_ATT ON)
endif()

set(CMAKE_C_STANDARD 11)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(ASCO_INCLUDE_DIR "${CMAKE_SOURCE_DIR}/include")
set(ASCO_SOURCE_DIR "${CMAKE_SOURCE_DIR}/src")
set(ASCO_TEST_DIR "${CMAKE_SOURCE_DIR}/tests")
set(ASCO_INCLUDE_FILES
	"${ASCO_INCLUDE_DIR}/asco/arch-detection.h"
	"${ASCO_INCLUDE_DIR}/asco/asco.h")

include(CTest)
enable_testing()

add_subdirectory(src)
add_subdirectory(tests)
