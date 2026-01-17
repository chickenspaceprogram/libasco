# libasco

## awful simple coroutines



this library is a replacement for POSIX's ucontext functions, which can be
awfully slow. it's less a proper coroutine library and more the guts you'd need
to write your own coroutine runtime. it's also intended to be small enough that
you can just statically link this into such a wrapper library.

check out `asco/asco.h` for the documentation.

there are a couple catches. the POSIX signal mask isn't altered on an
`asco_swap`. if you need that, use the `ucontext` functions. also, if you're
saving the stack of a thread that was allocated by the OS, you can't load
that stack from another thread.

in my opinion, both these catches are fine to deal with. in a sensible
coroutine runtime, each coroutine will have to jump back to its parent OS
thread anyways when it finishes to handle cleanup of the old stack and to grab
a new context from the ready list.

i intend to port this to work on at least the following processors:

- armv5
- aarch64
- riscv64
- ppc64(be/le)
- x86-64
- i386


currently, the following have been implemented:

- aarch64
- x86-64
- armv5 (partial, only softfp ABI is supported)
- i386 (only tested on i686, but no i386 features used)

mostly this is intended to run with both the Microsoft and GNU toolchains.
support for anything on Windows should be considered experimental. Microsoft
does not follow any relevant standards or document the behavior of their
operating system.

i don't know much about freestanding environments so i don't currently have
plans to officially support them. i don't think it'd be too difficult to port,
though. the actual library is freestanding, the tests aren't.

porting to new platforms should be pretty straightforward if you already know
that platform's assembly; you need to implement an assembly routine to swap
stacks, and a C function that prepares a stack to be swapped to.

this project was mostly an excuse to mess around a bit with a bunch of assembly
languages. don't use it in prod, just... be sensible. maybe once i more
extensively test it by integrating it into a proper async runtime that'll be
reasonable.

i also need to setup benchmarks at some point to compare these routines with
standard function calls; that'll come after I implement the most common
architectures.

i'm open to porting to other platforms, so if you have trouble compiling or the
tests fail, open an issue, or [email me](mailto:pestpestthechicken@yahoo.com).
