//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//


// This is a modified file I took from LLVM that I'm using for platform
// recognition.
//
// It's originally from OpenMP and was named `kmp_platform.h`.

/* ---------------------- Operating system recognition ------------------- */

#ifndef ASCO_ARCH_DETECTION_H
#define ASCO_ARCH_DETECTION_H

#define ASCO_OS_LINUX 0
#define ASCO_OS_DRAGONFLY 0
#define ASCO_OS_FREEBSD 0
#define ASCO_OS_NETBSD 0
#define ASCO_OS_OPENBSD 0
#define ASCO_OS_DARWIN 0
#define ASCO_OS_WINDOWS 0
#define ASCO_OS_HAIKU 0
#define ASCO_OS_HURD 0
#define ASCO_OS_SOLARIS 0
#define ASCO_OS_WASI 0
#define ASCO_OS_EMSCRIPTEN 0
#define ASCO_OS_AIX 0
#define ASCO_OS_UNIX 0 /* disjunction of ASCO_OS_LINUX, ASCO_OS_DARWIN etc. */

#ifdef _WIN32
#undef ASCO_OS_WINDOWS
#define ASCO_OS_WINDOWS 1
#endif

#if (defined __APPLE__ && defined __MACH__)
#undef ASCO_OS_DARWIN
#define ASCO_OS_DARWIN 1
#endif

// in some ppc64 linux installations, only the second condition is met
#if (defined __linux)
#undef ASCO_OS_LINUX
#define ASCO_OS_LINUX 1
#elif (defined __linux__)
#undef ASCO_OS_LINUX
#define ASCO_OS_LINUX 1
#elif defined(__EMSCRIPTEN__)
#undef ASCO_OS_LINUX
#undef ASCO_OS_EMSCRIPTEN
#define ASCO_OS_LINUX 1
#define ASCO_OS_EMSCRIPTEN 1
#else
#endif

#if (defined __DragonFly__)
#undef ASCO_OS_DRAGONFLY
#define ASCO_OS_DRAGONFLY 1
#endif

#if (defined __FreeBSD__)
#undef ASCO_OS_FREEBSD
#define ASCO_OS_FREEBSD 1
#endif

#if (defined __NetBSD__)
#undef ASCO_OS_NETBSD
#define ASCO_OS_NETBSD 1
#endif

#if (defined __OpenBSD__)
#undef ASCO_OS_OPENBSD
#define ASCO_OS_OPENBSD 1
#endif

#if (defined __HAIKU__)
#undef ASCO_OS_HAIKU
#define ASCO_OS_HAIKU 1
#endif

#if (defined __GNU__)
#undef ASCO_OS_HURD
#define ASCO_OS_HURD 1
#endif

#if (defined __sun__ && defined __svr4__)
#undef ASCO_OS_SOLARIS
#define ASCO_OS_SOLARIS 1
#endif

#if (defined __wasi__)
#undef ASCO_OS_WASI
#define ASCO_OS_WASI 1
#endif

#if (defined _AIX)
#undef ASCO_OS_AIX
#define ASCO_OS_AIX 1
#endif

#if (1 != ASCO_OS_LINUX + ASCO_OS_DRAGONFLY + ASCO_OS_FREEBSD + ASCO_OS_NETBSD +   \
              ASCO_OS_OPENBSD + ASCO_OS_DARWIN + ASCO_OS_WINDOWS + ASCO_OS_HAIKU + \
              ASCO_OS_HURD + ASCO_OS_SOLARIS + ASCO_OS_WASI + ASCO_OS_AIX)
#error Unknown OS
#endif

#if ASCO_OS_LINUX || ASCO_OS_DRAGONFLY || ASCO_OS_FREEBSD || ASCO_OS_NETBSD ||     \
    ASCO_OS_OPENBSD || ASCO_OS_DARWIN || ASCO_OS_HAIKU || ASCO_OS_HURD ||          \
    ASCO_OS_SOLARIS || ASCO_OS_WASI || ASCO_OS_AIX
#undef ASCO_OS_UNIX
#define ASCO_OS_UNIX 1
#endif

// Wall of conditional undefs, makes cmake play nice
#if !ASCO_OS_LINUX
#undef ASCO_OS_LINUX
#endif
#if !ASCO_OS_DRAGONFLY
#undef ASCO_OS_DRAGONFLY
#endif
#if !ASCO_OS_FREEBSD
#undef ASCO_OS_FREEBSD
#endif
#if !ASCO_OS_NETBSD
#undef ASCO_OS_NETBSD
#endif
#if !ASCO_OS_OPENBSD
#undef ASCO_OS_OPENBSD
#endif
#if !ASCO_OS_DARWIN
#undef ASCO_OS_DARWIN
#endif
#if !ASCO_OS_WINDOWS
#undef ASCO_OS_WINDOWS
#endif
#if !ASCO_OS_HAIKU
#undef ASCO_OS_HAIKU
#endif
#if !ASCO_OS_HURD
#undef ASCO_OS_HURD
#endif
#if !ASCO_OS_SOLARIS
#undef ASCO_OS_SOLARIS
#endif
#if !ASCO_OS_WASI
#undef ASCO_OS_WASI
#endif
#if !ASCO_OS_EMSCRIPTEN
#undef ASCO_OS_EMSCRIPTEN
#endif
#if !ASCO_OS_AIX
#undef ASCO_OS_AIX
#endif
#if !ASCO_OS_UNIX
#undef ASCO_OS_UNIX
#endif

/* ---------------------- Architecture recognition ------------------- */

#define ASCO_ARCH_X86 0
#define ASCO_ARCH_X86_64 0
#define ASCO_ARCH_AARCH64 0
#define ASCO_ARCH_AARCH64_32 0
#define ASCO_ARCH_PPC64_ELFv1 0
#define ASCO_ARCH_PPC64_ELFv2 0
#define ASCO_ARCH_PPC64_XCOFF 0
#define ASCO_ARCH_PPC_XCOFF 0
#define ASCO_ARCH_PPC 0
#define ASCO_ARCH_MIPS 0
#define ASCO_ARCH_MIPS64 0
#define ASCO_ARCH_RISCV64 0
#define ASCO_ARCH_LOONGARCH64 0
#define ASCO_ARCH_VE 0
#define ASCO_ARCH_S390X 0
#define ASCO_ARCH_SPARC 0

#if ASCO_OS_WINDOWS
#if defined(_M_AMD64) || defined(__x86_64)
#undef ASCO_ARCH_X86_64
#define ASCO_ARCH_X86_64 1
#elif defined(__aarch64__) || defined(_M_ARM64)
#undef ASCO_ARCH_AARCH64
#define ASCO_ARCH_AARCH64 1
#elif defined(__arm__) || defined(_M_ARM)
#undef ASCO_ARCH_ARMV7
#define ASCO_ARCH_ARMV7 1
#else
#undef ASCO_ARCH_X86
#define ASCO_ARCH_X86 1
#endif
#endif

#if ASCO_OS_UNIX
#if defined __x86_64
#undef ASCO_ARCH_X86_64
#define ASCO_ARCH_X86_64 1
#elif defined __i386
#undef ASCO_ARCH_X86
#define ASCO_ARCH_X86 1
#elif defined __powerpc64__
#if defined(_CALL_ELF)
#if _CALL_ELF == 2
#undef ASCO_ARCH_PPC64_ELFv2
#define ASCO_ARCH_PPC64_ELFv2 1
#else
#undef ASCO_ARCH_PPC64_ELFv1
#define ASCO_ARCH_PPC64_ELFv1 1
#endif
#elif ASCO_OS_AIX
#undef ASCO_ARCH_PPC64_XCOFF
#define ASCO_ARCH_PPC64_XCOFF 1
#endif
#elif defined(__powerpc__) && ASCO_OS_AIX
#undef ASCO_ARCH_PPC_XCOFF
#define ASCO_ARCH_PPC_XCOFF 1
#undef ASCO_ARCH_PPC
#define ASCO_ARCH_PPC 1
#elif defined(__powerpc__) && !defined(__LP64__)
#undef ASCO_ARCH_PPC
#define ASCO_ARCH_PPC 1
#elif defined __ARM64_ARCH_8_32__
#undef ASCO_ARCH_AARCH64_32
#define ASCO_ARCH_AARCH64_32 1
#elif defined __aarch64__
#undef ASCO_ARCH_AARCH64
#define ASCO_ARCH_AARCH64 1
#elif defined __mips__
#if defined __mips64
#undef ASCO_ARCH_MIPS64
#define ASCO_ARCH_MIPS64 1
#else
#undef ASCO_ARCH_MIPS
#define ASCO_ARCH_MIPS 1
#endif
#elif defined __riscv && __riscv_xlen == 64
#undef ASCO_ARCH_RISCV64
#define ASCO_ARCH_RISCV64 1
#elif defined __loongarch__ && __loongarch_grlen == 64
#undef ASCO_ARCH_LOONGARCH64
#define ASCO_ARCH_LOONGARCH64 1
#elif defined __ve__
#undef ASCO_ARCH_VE
#define ASCO_ARCH_VE 1
#elif defined __s390x__
#undef ASCO_ARCH_S390X
#define ASCO_ARCH_S390X 1
#elif defined __sparc || defined __sparc__
#undef ASCO_ARCH_SPARC
#define ASCO_ARCH_SPARC 1
#endif
#endif

#if defined(__ARM_ARCH_7__) || defined(__ARM_ARCH_7R__) ||                     \
    defined(__ARM_ARCH_7A__) || defined(__ARM_ARCH_7VE__)
#define ASCO_ARCH_ARMV7 1
#endif

#if defined(ASCO_ARCH_ARMV7) || defined(__ARM_ARCH_6__) ||                      \
    defined(__ARM_ARCH_6J__) || defined(__ARM_ARCH_6K__) ||                    \
    defined(__ARM_ARCH_6Z__) || defined(__ARM_ARCH_6T2__) ||                   \
    defined(__ARM_ARCH_6ZK__)
#define ASCO_ARCH_ARMV6 1
#endif

#if defined(ASCO_ARCH_ARMV6) || defined(__ARM_ARCH_5T__) ||                     \
    defined(__ARM_ARCH_5E__) || defined(__ARM_ARCH_5TE__) ||                   \
    defined(__ARM_ARCH_5TEJ__)
#define ASCO_ARCH_ARMV5 1
#endif

#if defined(ASCO_ARCH_ARMV5) || defined(__ARM_ARCH_4__) ||                      \
    defined(__ARM_ARCH_4T__)
#define ASCO_ARCH_ARMV4 1
#endif

#if defined(ASCO_ARCH_ARMV4) || defined(__ARM_ARCH_3__) ||                      \
    defined(__ARM_ARCH_3M__)
#define ASCO_ARCH_ARMV3 1
#endif

#if defined(ASCO_ARCH_ARMV3) || defined(__ARM_ARCH_2__)
#define ASCO_ARCH_ARMV2 1
#endif

#if defined(ASCO_ARCH_ARMV2)
#define ASCO_ARCH_ARM 1
#endif

#if defined(__wasm32__)
#define ASCO_ARCH_WASM 1
#endif

#define ASCO_ARCH_PPC64                                                         \
  (ASCO_ARCH_PPC64_ELFv2 || ASCO_ARCH_PPC64_ELFv1 || ASCO_ARCH_PPC64_XCOFF)

#if defined(ASCO_ARCH_SPARC)
#undef ASCO_ARCH_SPARC32
#undef ASCO_ARCH_SPARC64
#if defined(__sparcv9) || defined(__sparc64__)
#define ASCO_ARCH_SPARC64 1
#endif
#if defined(__sparc) && !defined(__sparcv9) && !defined(__sparc64__)
#define ASCO_ARCH_SPARC32 1
#endif
#endif

#if defined(__MIC__) || defined(__MIC2__)
#define ASCO_MIC 1
#if __MIC2__ || __KNC__
#define ASCO_MIC1 0
#define ASCO_MIC2 1
#else
#define ASCO_MIC1 1
#define ASCO_MIC2 0
#endif
#else
#define ASCO_MIC 0
#define ASCO_MIC1 0
#define ASCO_MIC2 0
#endif

/* Specify 32 bit architectures here */
#define ASCO_32_BIT_ARCH                                                        \
  (ASCO_ARCH_X86 || ASCO_ARCH_ARM || ASCO_ARCH_MIPS || ASCO_ARCH_WASM ||           \
   ASCO_ARCH_PPC || ASCO_ARCH_AARCH64_32 || ASCO_ARCH_SPARC32)

// Platforms which support Intel(R) Many Integrated Core Architecture
#define ASCO_MIC_SUPPORTED                                                      \
  ((ASCO_ARCH_X86 || ASCO_ARCH_X86_64) && (ASCO_OS_LINUX || ASCO_OS_WINDOWS))

// TODO: Fixme - This is clever, but really fugly
#if (1 != ASCO_ARCH_X86 + ASCO_ARCH_X86_64 + ASCO_ARCH_ARM + ASCO_ARCH_PPC64 +     \
              ASCO_ARCH_AARCH64 + ASCO_ARCH_MIPS + ASCO_ARCH_MIPS64 +             \
              ASCO_ARCH_RISCV64 + ASCO_ARCH_LOONGARCH64 + ASCO_ARCH_VE +          \
              ASCO_ARCH_S390X + ASCO_ARCH_WASM + ASCO_ARCH_PPC +                  \
              ASCO_ARCH_AARCH64_32 + ASCO_ARCH_SPARC)
#error Unknown or unsupported architecture
#endif


// few more special undefs
// probably won't use these but hey why not

#if !ASCO_MIC
#undef ASCO_MIC
#endif

#if !ASCO_MIC1
#undef ASCO_MIC1
#endif

#if !ASCO_MIC2
#undef ASCO_MIC2
#endif


#if !ASCO_32_BIT_ARCH
#undef ASCO_32_BIT_ARCH
#endif

#if !ASCO_MIC_SUPPORTED
#undef ASCO_MIC_SUPPORTED
#endif


// wall of undefs

#if !ASCO_ARCH_X86
#undef ASCO_ARCH_X86
#endif
#if !ASCO_ARCH_X86_64
#undef ASCO_ARCH_X86_64
#endif
#if !ASCO_ARCH_AARCH64
#undef ASCO_ARCH_AARCH64
#endif
#if !ASCO_ARCH_AARCH64_32
#undef ASCO_ARCH_AARCH64_32
#endif
#if !ASCO_ARCH_PPC64_ELFv1
#undef ASCO_ARCH_PPC64_ELFv1
#endif
#if !ASCO_ARCH_PPC64_ELFv2
#undef ASCO_ARCH_PPC64_ELFv2
#endif
#if !ASCO_ARCH_PPC64_XCOFF
#undef ASCO_ARCH_PPC64_XCOFF
#endif
#if !ASCO_ARCH_PPC_XCOFF
#undef ASCO_ARCH_PPC_XCOFF
#endif
#if !ASCO_ARCH_PPC
#undef ASCO_ARCH_PPC
#endif
#if !ASCO_ARCH_MIPS
#undef ASCO_ARCH_MIPS
#endif
#if !ASCO_ARCH_MIPS64
#undef ASCO_ARCH_MIPS64
#endif
#if !ASCO_ARCH_RISCV64
#undef ASCO_ARCH_RISCV64
#endif
#if !ASCO_ARCH_LOONGARCH64
#undef ASCO_ARCH_LOONGARCH64
#endif
#if !ASCO_ARCH_VE
#undef ASCO_ARCH_VE
#endif
#if !ASCO_ARCH_S390X
#undef ASCO_ARCH_S390X
#endif
#if !ASCO_ARCH_SPARC
#undef ASCO_ARCH_SPARC
#endif


#endif
