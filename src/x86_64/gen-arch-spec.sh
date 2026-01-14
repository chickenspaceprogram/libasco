#!/bin/sh

# if you want to regenerate the .s, .asm files in this directory, run:
#
# rm sysv* win*
# ./gen_arch_spec.sh


SOURCE_FILENAME=source
PREPROC=cpp
OBJCONV=objconv
#SYSV_ASM=x86_64-unknown-linux-gnu-as
SYSV_ASM=x86_64-elf-as

$PREPROC -DSYSV_CALL -P "$SOURCE_FILENAME.S" > "sysv-att.s"
$PREPROC -DWIN_CALL -P "$SOURCE_FILENAME.S" > "win64-att.s"

$SYSV_ASM -o "$SOURCE_FILENAME.sysv.o" "sysv-att.s"
$SYSV_ASM -o "$SOURCE_FILENAME.win.o" "win64-att.s"


$OBJCONV -fnasm "$SOURCE_FILENAME.sysv.o"
mv "$SOURCE_FILENAME.sysv.asm" sysv-nasm.asm

rm "$SOURCE_FILENAME.sysv.o"

$OBJCONV -fnasm "$SOURCE_FILENAME.win.o"
mv "$SOURCE_FILENAME.win.asm" win64-nasm.asm
$OBJCONV -fmasm "$SOURCE_FILENAME.win.o"
mv "$SOURCE_FILENAME.win.asm" win64-masm.asm

rm "$SOURCE_FILENAME.win.o"
