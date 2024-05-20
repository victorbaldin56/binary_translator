/**
 * @file
 * @brief This file is a part of binary translator project.
 *
 * @copyright (C) Victor Baldin, 2024.
 */

#include "jit.h"

#include <sys/mman.h>
#include <unistd.h>

#include <cstdlib>

#include "x86_emitter.h"

typedef void MemExecutor();

bool jit::run(x86_64::InstrArray* instr) {

#define HANDLE_ERROR(msg)                                                     \
    do {                                                                      \
        std::fprintf(stderr, msg);                                            \
        success = false;                                                      \
        goto cleanup;                                                         \
    } while (0)

    assert(instr);

    std::size_t pageSize = (std::size_t)sysconf(_SC_PAGESIZE);
    std::size_t numPages = instr->curAddr_ / pageSize + 1;
    std::size_t bufSize = numPages * pageSize;

    bool success = true;

    void* jitBuf = aligned_alloc(pageSize, bufSize);
    if (!jitBuf)
        HANDLE_ERROR("Memory exhausted\n");

    emitter::emitCode(instr, jitBuf);

    // Preparing code to execute
    if (mprotect(jitBuf, bufSize, PROT_READ | PROT_EXEC) == -1)
        HANDLE_ERROR("mprotect failed\n");

    // Leap into the unknown...
    ((MemExecutor*)jitBuf)();

#undef HANDLE_ERROR

cleanup:
    std::free(jitBuf);
    return success;
}
