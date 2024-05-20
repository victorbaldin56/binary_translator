/**
 * @file
 * @brief This file is a part of binary translator project.
 *
 * @copyright (C) Victor Baldin, 2024.
 */

#ifndef BINARY_TRANSLATOR_X86_64_H_
#define BINARY_TRANSLATOR_X86_64_H_

#include <cassert>
#include <cstdio>
#include <cstdint>

#include "ir.h"

extern const char scanf_fmt[];

namespace x86_64 {

enum OperandType {
    Empty,
    Immed,
    Reg,
    Mem,
};

#define DEF_X86_REG(reg) reg,

enum Register {
#include "x86_registers.h"
};

#undef DEF_X86_REG

#define DEF_X86_INSTRUCTION(instr) instr,

enum Opcode {
#include "x86_instr.h"
};

#undef DEF_X86_INSTRUCTION

/** @brief */
struct Instr {
    Opcode opcode_;
    struct Operand {
        OperandType type_;

        union {
            std::int64_t qword_;
            Register reg_;
        };
    } lhs_, rhs_;

    std::uint64_t absOffset_;
    long disasmFileOffset_;
};

struct InstrArray {
    std::size_t* oldAddrToNew_;
    std::size_t bufLen_;

    Instr* data_;
    std::size_t sz_;
    std::size_t cap_;

    std::size_t curAddr_;
};

inline bool createInstrArray(InstrArray* arr, std::size_t bufLen) {
    assert(arr);

    arr->oldAddrToNew_
        = (std::size_t*)std::calloc(bufLen, sizeof(*arr->oldAddrToNew_));
    arr->data_ = (Instr*)std::calloc(1, sizeof(*arr->data_));
    arr->sz_ = arr->curAddr_ = 0;
    arr->cap_ = 1;
    arr->bufLen_ = bufLen;

    return true;
}

inline void destroyInstrArray(InstrArray* arr) {
    assert(arr);

    free(arr->data_);
    free(arr->oldAddrToNew_);
}

inline bool reallocInstrArray(InstrArray* arr, std::size_t capacity) {
    assert(arr);

    Instr* newData
        = (Instr*)reallocarray(arr->data_, capacity, sizeof(*newData));
    if (!newData)
        return false;

    arr->data_ = newData;
    arr->cap_ = capacity;

    return true;
}

inline void incrementAddress(InstrArray* arr, Opcode opcode,
                             Instr::Operand lhs, Instr::Operand rhs) {
    // SSE instructions
    if (addsd <= opcode) {
        if (opcode == movsd)
            arr->curAddr_ += 5;
        else
            arr->curAddr_ += 4;
    } else {
        if (opcode == jmp)
            arr->curAddr_ += 5;

        if (ja <= opcode && opcode <= je)
            arr->curAddr_ += 6;

        if (opcode == call) {
            if (lhs.type_ == Reg)
                arr->curAddr_ += 2;
            else
                arr->curAddr_ += 5;
        }

        if (opcode == add || opcode == sub)
            arr->curAddr_ += 4;

        if (opcode == ret || opcode == push)
            arr->curAddr_ += 1;

        if (opcode == mov) {
            if (rhs.type_ == Immed)
                arr->curAddr_ += 10;
            else
                arr->curAddr_ += 3;
        }
    }
}

inline bool pushNewInstr(InstrArray* arr,
                         ir::Node* node,
                         Opcode opcode,
                         Instr::Operand lhs = {},
                         Instr::Operand rhs = {}) {
    assert(arr);

    if (arr->sz_ == arr->cap_) {
        if (!reallocInstrArray(arr, arr->cap_ * 2))
            return false;
    }

    arr->data_[arr->sz_++] = {.opcode_ = opcode,
                              .lhs_ = lhs, .rhs_ = rhs,
                              .absOffset_ = arr->curAddr_,
                              .disasmFileOffset_ = node->disasmPos_};
    if (opcode == nop)
        arr->oldAddrToNew_[node->addr_] = arr->sz_;  // next after nop separator

    incrementAddress(arr, opcode, lhs, rhs);

    return true;
}

typedef bool MapFunc(InstrArray* arr, ir::IR* ir, ir::Node* node);

struct RegMap {
    const char* nameInSPU;
    const char* nameInSSE;
    x86_64::Register reg;
};

#define DEF_REG_MAPPING(spu_name, xmm_name)                                    \
    {#spu_name, #xmm_name, x86_64::xmm_name}

static const RegMap regMappings[] = {
    {nullptr, nullptr},
    DEF_REG_MAPPING(rax, xmm2),
    DEF_REG_MAPPING(rbx, xmm3),
    DEF_REG_MAPPING(rcx, xmm4),
    DEF_REG_MAPPING(rdx, xmm5)};

#define DEC(func) MapFunc translate_##func

//================================ Arithmetic =================================
DEC(add);
DEC(sub);
DEC(mul);
DEC(div);
DEC(sqrt);
//=============================================================================

//================================== Jumps ====================================
DEC(jmp);
DEC(jae);
DEC(jbe);
DEC(ja);
DEC(jb);
DEC(je);
DEC(call);
DEC(ret);
//=============================================================================

//================================== Stack ====================================
DEC(push);
DEC(pop);
//=============================================================================

//==================================== IO =====================================
DEC(in);
DEC(out);
//=============================================================================

DEC(hlt);

#undef DEC

}  // namespace x86_64

#endif  // BINARY_TRANSLATOR_X86_64_H_
