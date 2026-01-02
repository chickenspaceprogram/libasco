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

i intend to port this to work on the following processors:

- arm
- aarch64
- riscv
- riscv64
- ppc
- ppc64(le)
- i386
- x86-64

currently, the following have been implemented:

- aarch64

mostly this is intended to run with both the Microsoft and GNU toolchains. it
should be reasonably portable though, you may just have to add the appropriate
preprocessor directives if the ones here don't cover things.

all my testing does occur on hosted systems but this library should build
fine freestanding. you might have to disable building tests, though.

i'm open to porting to other platforms, so if you have trouble compiling or the
tests fail, open an issue, or [email me](mailto:pestpestthechicken@yahoo.com).

if you're on a windows system, Intel syntax is assumed.
if you're anywhere else, AT&T syntax is assumed.
