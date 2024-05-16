/**
 * @file
 * @brief This file is a part of binary translator project.
 *
 * @copyright (C) Victor Baldin, 2024.
 */

#ifndef BINARY_TRANSLATOR_DISASM_H_
#define BINARY_TRANSLATOR_DISASM_H_

#include "ir.h"
#include "trans.h"
namespace disasm {

ir::IR* disassemble(trans::Arguments args);

}

#endif  // BINARY_TRANSLATOR_DISASM_H_
