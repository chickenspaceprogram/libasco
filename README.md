# libasco

## awful simple coroutines

this library is a replacement for POSIX's ucontext functions, which can be
awfully slow. it's less a proper coroutine library and more the guts you'd need
to write your own coroutine library.

check out `asco/asco.h` for the documentation.

there is one catch. the signal mask of each coroutine isn't saved. so, if you
switch back to a coroutine, the signal mask will still be whatever it was
before you switched.

having said that. you shouldn't be using POSIX signals anyways. if you *really*
need them, save/restore the signal mask yourself, or just use the ucontext
functions.

i intend to port this to work on at least the following processors:

- armv5
- aarch64
- riscv64
- ppc64(be/le)
- i386
- x86-64


currently, the following have been implemented:

- aarch64
- x86-64
- armv5 (partial, only softfp ABI is supported)

mostly this is intended to run with both the Microsoft and GNU toolchains. it
should be reasonably portable though, you may just have to add the appropriate
preprocessor directives if the ones here don't cover things.

all my testing does occur on hosted systems, and CMake is configured for that.
technically speaking, only the tests require a hosted system (even then it's
for abort() and fprintf()), so you'd probably be fine removing the asserts and
setting up a makefile to compile your desired architecture manually.

i don't know much about freestanding environments so i don't currently have
plans to officially support them; that might come in future if i do get
experience though.

porting to new platforms should be pretty straightforward if you already know
that platform's assembly; you need to implement 3 assembly routines and a C
function that aligns and sets up the stack pointer properly. unfortunately,
prior to this project I'd only touched z80 assembly so porting's gonna be slow.
this project was mostly an excuse to mess around a bit with a bunch of assembly
languages to be honest.

i also need to setup benchmarks at some point to compare these routines with
standard function calls; that'll come after I implement the most common
architectures.

i'm open to porting to other platforms, so if you have trouble compiling or the
tests fail, open an issue, or [email me](mailto:pestpestthechicken@yahoo.com).
