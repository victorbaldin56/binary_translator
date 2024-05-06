/**
 * @file
 * @brief This file is a part of binary translator project.
 *
 * @copyright (C) Victor Baldin, 2024.
 */

#ifndef BINARY_TRANSLATOR_DISASM_H_
#define BINARY_TRANSLATOR_DISASM_H_

namespace disasm {

struct Arguments {
    const char* inputFile;
    const char* outputFile;
    bool verbose;
};

struct SPUInstruction {
    const char* name;
    unsigned char operandTypes;
};

bool disassemble(Arguments args);

}

#endif  // BINARY_TRANSLATOR_DISASM_H_
