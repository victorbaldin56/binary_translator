/**
 * @file
 * @brief This file is a part of binary translator project.
 *
 * @copyright (C) Victor Baldin, 2024.
 */

#ifndef BINARY_TRANSLATOR_X86_64_H_
#define BINARY_TRANSLATOR_X86_64_H_

#include <cstdio>
#include <cstdint>

#include "ir.h"

namespace x86_64 {

struct Instruction {
    std::int32_t opcode_;

    std::uint64_t absOffset_;
    Instruction* next_;
};

typedef void MapFunc(ir::IR* ir, ir::Node* node);

MapFunc hlt;

//================================ Arithmetic =================================
MapFunc add;
MapFunc sub;
MapFunc mul;
MapFunc div;
MapFunc sqrt;
//=============================================================================

//================================== Jumps ====================================
MapFunc jmp;
MapFunc jae;
MapFunc jbe;
MapFunc ja;
MapFunc jb;
MapFunc je;
MapFunc call;
MapFunc ret;
//=============================================================================

//================================== Stack ====================================
MapFunc push;
MapFunc pop;
//=============================================================================

//==================================== IO =====================================
MapFunc in;
MapFunc out;
//=============================================================================

}  // namespace x86_64

#endif  // BINARY_TRANSLATOR_X86_64_H_
