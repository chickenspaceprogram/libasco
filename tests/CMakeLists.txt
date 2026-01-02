# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

# SPDX-License-Identifier: MPL-2.0

cmake_minimum_required(VERSION 3.21)


# can take libs to link as an optional arg
function(asco_make_test testfilename)
get_filename_component(EXENAME ${testfilename} NAME_WLE)
add_executable(${EXENAME} ${testfilename})
target_link_libraries(${EXENAME} ${ARGN})
add_test(
	NAME ${EXENAME}
	COMMAND $<TARGET_FILE:${EXENAME}>
)
endfunction()

asco_make_test(test-asco.c PUBLIC asco)
