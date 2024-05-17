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

const unsigned char JmpOpcode = 0x09;
const unsigned char CallOpcode = 0x0f;
const unsigned char RetOpcode = 0x11;

const unsigned signatureSize = 5;

ir::IR* disassemble(trans::Arguments args, std::FILE* output);

}

#endif  // BINARY_TRANSLATOR_DISASM_H_
