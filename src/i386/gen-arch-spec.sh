#!/bin/sh

# if you want to regenerate the .s, .asm files in this directory, run:
#
# rm sysv* win*
# ./gen_arch_spec.sh


SOURCE_FILENAME=source
PREPROC=cpp
OBJCONV=objconv
SYSV_ASM=i686-unknown-linux-gnu-as


$PREPROC -P "$SOURCE_FILENAME.S" > "sysv-att.s"

$SYSV_ASM -o "$SOURCE_FILENAME.sysv.o" "sysv-att.s"

$OBJCONV -fnasm "$SOURCE_FILENAME.sysv.o"
mv "$SOURCE_FILENAME.sysv.asm" sysv-nasm.asm
$OBJCONV -fmasm "$SOURCE_FILENAME.sysv.o"
mv "$SOURCE_FILENAME.sysv.asm" sysv-masm.asm

rm "$SOURCE_FILENAME.sysv.o"
