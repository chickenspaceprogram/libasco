# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# SPDX-License-Identifier: MPL-2.0

cmake_minimum_required(VERSION 3.21)
project(hmacro C ASM)

set(CMAKE_C_STANDARD 11)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(ASCO_INCLUDE_DIR "${CMAKE_SOURCE_DIR}/include")
set(ASCO_SOURCE_DIR "${CMAKE_SOURCE_DIR}/src")
set(ASCO_INCLUDE_FILES "${ASCO_INCLUDE_DIR}/asco/asco.h")

include(CTest)

add_subdirectory(src)
