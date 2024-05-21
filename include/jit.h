/**
 * @file
 * @brief This file is a part of binary translator project.
 *
 * @copyright (C) Victor Baldin, 2024.
 */

#ifndef BINARY_TRANSLATOR_JIT_H_
#define BINARY_TRANSLATOR_JIT_H_

#include "x86-64.h"

namespace jit {

int run(x86_64::InstrArray* instr);

}

#endif  // BINARY_TRANSLATOR_JIT_H_
