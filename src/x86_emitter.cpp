/**
 * @file
 * @brief This file is a part of binary translator project.
 *
 * @copyright (C) Victor Baldin, 2024.
 */

#include "x86_emitter.h"

#include <cstring>

namespace {

#define DEF_XMM(xmm, mask) xmm = mask,

enum Masks {
    je_mask = 0x84,
    jne_mask = 0x85,
    jb_mask = 0x8f,
    jae_mask = 0x83,
    jbe_mask = 0x8d,
    ja_mask = 0x87,

    addsd_mask = 0x58,
    subsd_mask = 0x5c,
    mulsd_mask = 0x59,
    divsd_mask = 0x5e,

    // Generating enum with reusability of members names.
    #include "xmm_reg.def"

    rax_mask = 0xb8,
    rbx_mask = 0xbb,
    rdi_mask = 0xbf,
};

#undef DEF_XMM

inline void emitBytes(char** bufPtr, void* src, std::size_t size) {
    std::memcpy(*bufPtr, src, size);
    (*bufPtr) += size;
}

typedef void InstrBinMapper(x86_64::Instr::Operand lhs,
                            x86_64::Instr::Operand rhs,
                            char** bufPtr);

// ================================= Definitions ===============================
#define DEF(name)                                                              \
void emit_##name([[maybe_unused]] x86_64::Instr::Operand lhs,                  \
                 [[maybe_unused]]x86_64::Instr::Operand rhs,                   \
                 [[maybe_unused]] char** bufPtr)

// nop not emitted actually, used only in MCInst for debug purposes
DEF(nop) {}

DEF(mov) {
    std::int16_t movOpcode = 0x0048;
    if (rhs.type_ == x86_64::Immed) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wswitch-enum"
        switch (lhs.reg_) {
        case x86_64::rax:
            movOpcode |= (rax_mask << 8);
            break;
        case x86_64::rbx:
            movOpcode |= (rbx_mask << 8);
            break;
        case x86_64::rdi:
            movOpcode |= (rdi_mask << 8);
            break;
        default:
            assert(0 && "Unhandled register (mov)");
        }
#pragma clang diagnostic pop
        emitBytes(bufPtr, &movOpcode, sizeof(movOpcode));
        emitBytes(bufPtr, &rhs.qword_, sizeof(rhs.qword_));
    } else {
        const int size = 3;

        std::int32_t opcode = 0xe68948;
        emitBytes(bufPtr, &opcode, size);
    }
}

// Only add rsp, 0x8 & sub rsp, 0x8
DEF(add) {
    std::uint32_t opcode = 0x08c48348;
    emitBytes(bufPtr, &opcode, sizeof(opcode));
}

DEF(sub) {
    std::uint32_t opcode = 0x08ec8348;
    emitBytes(bufPtr, &opcode, sizeof(opcode));
}

DEF(push) {
    **bufPtr = 0x53;  // push rbx
    ++*bufPtr;
}

// Only call rbx & call rel32 used
DEF(call) {
    if (lhs.type_ == x86_64::Reg) {
        std::uint16_t opcode = 0xd3ff;
        emitBytes(bufPtr, &opcode, sizeof(opcode));
    } else {
        std::uint8_t opcode = 0xe8;
        lhs.qword_ -= 4;
        emitBytes(bufPtr, &opcode, sizeof(opcode));
        emitBytes(bufPtr, &lhs.qword_, 4);
    }
}

// Only jmp rel32
DEF(jmp) {
    std::uint8_t opcode = 0xe9;
    lhs.qword_ -= 2;
    emitBytes(bufPtr, &opcode, sizeof(opcode));
    emitBytes(bufPtr, &lhs.qword_, 4);
}

#define DEF_COND_JMP(name)                                                     \
DEF(name) {                                                                    \
    const int condJmpSize = 6;                                                 \
    lhs.qword_ -= 4;                                                           \
    std::int64_t jmp = (lhs.qword_ << 16)                                      \
        + (0x000f | (name##_mask << 8));                                       \
    std::memcpy(*bufPtr, &jmp, condJmpSize);                                   \
    (*bufPtr) += condJmpSize;                                                  \
}

DEF_COND_JMP(je);
DEF_COND_JMP(jae);
DEF_COND_JMP(ja);
DEF_COND_JMP(jbe);
DEF_COND_JMP(jb);

#undef DEF_COND_JMP

DEF(ret) {
    **bufPtr = (char)0xc3;
    ++*bufPtr;
}

DEF(comisd) {
    const int comisdSize = 4;
    std::int64_t op = 0xc12f0f66;   // comisd xmm0, xmm1
    std::memcpy(*bufPtr, &op, comisdSize);
    (*bufPtr) += comisdSize;
}

#define DEF_BIN_ARITH_XMM0_XMM1(op)                                            \
DEF(op) {                                                                      \
    std::int32_t opcode = 0xc8000ff2 | (op##_mask << 16);                      \
    /*                        ^ <- bit mask is to be applied here */           \
    std::memcpy(*bufPtr, &opcode, sizeof(opcode));                             \
    (*bufPtr) += sizeof(opcode);                                               \
}

DEF_BIN_ARITH_XMM0_XMM1(addsd);
DEF_BIN_ARITH_XMM0_XMM1(subsd);
DEF_BIN_ARITH_XMM0_XMM1(mulsd);
DEF_BIN_ARITH_XMM0_XMM1(divsd);

#undef DEF_BIN_ARITH_XMM0_XMM1

DEF(sqrtsd) {
    std::uint32_t opcode = 0xc1510ff2;  // sqrtsd xmm0, xmm1
    std::memcpy(*bufPtr, &opcode, sizeof(opcode));
    (*bufPtr) += sizeof(opcode);
}

DEF(movsd) {
    // TODO
    const int movsdSize = 5;
    std::int64_t opcode = 0x2400000ff2;
    //                        ^ ^
    //                        | |
    // xmm register --------->+ +<------ movsd xmm, mem or movsd mem, xmm

#define DEF_XMM(xmm, mask)                                                    \
    case x86_64::xmm:                                                         \
        opcode |= (mask << 24);                                               \
        break;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wswitch-enum"
    if (lhs.type_ == x86_64::Mem && lhs.reg_ == x86_64::rsp) {
        opcode |= (0x11 << 16);

        switch (rhs.reg_) {
            #include "xmm_reg.def"
        }
    } else {
        opcode |= (0x10 << 16);

        switch (lhs.reg_) {
            #include "xmm_reg.def"
        }
    }
#pragma clang diagnostic pop
#undef DEF_XMM

    emitBytes(bufPtr, &opcode, movsdSize);
}

#undef DEF

#define DEF_X86_INSTRUCTION(instr) emit_##instr,

InstrBinMapper* instrMappings[] = {
    #include "x86_instr.h"
};

#undef DEF_X86_INSTRUCTION

void emitInstruction(x86_64::Instr instr, char** bufPtr) {
    assert(bufPtr && *bufPtr);

    instrMappings[instr.opcode_](instr.lhs_, instr.rhs_, bufPtr);
}

}

void emitter::emitCode(x86_64::InstrArray* instr, void* codeBuf) {
    assert(instr);
    assert(codeBuf);

    char* bufPtr = (char*)codeBuf;
    *bufPtr = (char)0xcc;   // for debugging
    ++bufPtr;
    for (std::size_t i = 0; i < instr->sz_; ++i) {
        emitInstruction(instr->data_[i], &bufPtr);
    }
}
