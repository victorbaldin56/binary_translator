/**
 * @file
 * @brief This file is a part of binary translator project.
 *
 * @copyright (C) Victor Baldin, 2024.
 */

#ifndef BINARY_TRANSLATOR_X86_EMITTER_H_
#define BINARY_TRANSLATOR_X86_EMITTER_H_

#include "x86-64.h"

namespace emitter {

void emitCode(x86_64::InstrArray* instr, void* codeBuf);

}

#endif  // BINARY_TRANSLATOR_X86_EMITTER_H_
