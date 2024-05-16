/**
 * @file
 * @brief This file is a part of binary translator project.
 *
 * @copyright (C) Victor Baldin, 2024.
 */

#ifndef BINARY_TRANSLATOR_TRANS_H_
#define BINARY_TRANSLATOR_TRANS_H_

#include "x86-64.h"

namespace trans {

enum OperandMask {
    Immed = 0x20,
    Reg = 0x40,
};

struct InstrMap {
    const char* name;
    unsigned char operandTypes;
    x86_64::MapFunc* mapFunc;
};

struct Arguments {
    const char* inputFile;
    const char* outputFile;
    bool verbose;
};

#define DEF_INSTR_MAPPING(instr, args) {#instr, args, x86_64::instr}

static const InstrMap instrMappings[] = {
    DEF_INSTR_MAPPING(in  ,           0),
    DEF_INSTR_MAPPING(out ,           0),
    DEF_INSTR_MAPPING(push, Immed | Reg),
    DEF_INSTR_MAPPING(add ,           0),
    DEF_INSTR_MAPPING(sub ,           0),
    DEF_INSTR_MAPPING(mul ,           0),
    DEF_INSTR_MAPPING(div ,           0),
    DEF_INSTR_MAPPING(sqrt,           0),
    DEF_INSTR_MAPPING(pop ,         Reg),
    DEF_INSTR_MAPPING(jmp , Immed | Reg),
    DEF_INSTR_MAPPING(jae , Immed | Reg),
    DEF_INSTR_MAPPING(jbe , Immed | Reg),
    DEF_INSTR_MAPPING(ja  , Immed | Reg),
    DEF_INSTR_MAPPING(jb  , Immed | Reg),
    DEF_INSTR_MAPPING(je  , Immed | Reg),
    DEF_INSTR_MAPPING(call, Immed | Reg),
    DEF_INSTR_MAPPING(hlt ,           0),
    DEF_INSTR_MAPPING(ret ,           0)};

struct RegMap {
    const char* nameInSPU;
    const char* nameInSSE;
};

static const RegMap regMappings[] = {
    {nullptr, nullptr},
    {"rax", "xmm2"},
    {"rbx", "xmm3"},
    {"rcx", "xmm4"},
    {"rdx", "xmm5"}};

bool translate(Arguments args);

}

#endif  // BINARY_TRANSLATOR_TRANS_H_
