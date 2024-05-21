/**
 * @file
 * @brief This file is a part of binary translator project.
 *
 * @copyright (C) Victor Baldin, 2024.
 */

#include "jit.h"

#include <sys/mman.h>
#include <unistd.h>

#include <cstdio>
#include <cstdlib>

#include "x86_emitter.h"

typedef int MemExecutor();

int jit::run(x86_64::InstrArray* instr) {

#define HANDLE_ERROR(msg)                                                     \
    do {                                                                      \
        std::fprintf(stderr, msg);                                            \
        retCode = -1;                                                         \
        goto cleanup;                                                         \
    } while (0)

    assert(instr);

    std::size_t pageSize = (std::size_t)sysconf(_SC_PAGESIZE);
    std::size_t numPages = instr->curAddr_ / pageSize + 1;
    std::size_t bufSize = numPages * pageSize;
    std::FILE* out = 0;

    int retCode = 0;

    void* jitBuf = aligned_alloc(pageSize, bufSize);
    if (!jitBuf)
        HANDLE_ERROR("Memory exhausted\n");

    emitter::emitCode(instr, jitBuf);

    // Preparing code to execute
    if (mprotect(jitBuf, bufSize, PROT_READ | PROT_EXEC) == -1)
        HANDLE_ERROR("mprotect failed\n");

    out = std::fopen("jitbuf.dump", "wb");
    fwrite(jitBuf, 1, bufSize, out);

    // Leap into the unknown...
    retCode = ((MemExecutor*)jitBuf)();

#undef HANDLE_ERROR

cleanup:
    std::free(jitBuf);
    return retCode;
}
