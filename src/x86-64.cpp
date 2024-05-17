/**
 * @file
 * @brief This file is a part of binary translator project.
 *
 * @copyright (C) Victor Baldin, 2024.
 */

#include "x86-64.h"

#include <cassert>
#include <cstdlib>
#include <cstring>

extern const char fmt_string[] = "%lg";

#define DEF(func)                                                             \
bool x86_64::translate_##func(InstrArray* arr,                                \
                  [[maybe_unused]] ir::IR* ir,                                \
                  [[maybe_unused]] ir::Node* node)

#define INSERT_NEW_INSTRUCTION(...)                                           \
    do {                                                                      \
        if (!pushNewInstr(arr, node, __VA_ARGS__))                            \
            return false;                                                     \
    } while (0)

DEF(in) {
    INSERT_NEW_INSTRUCTION(nop);
    INSERT_NEW_INSTRUCTION(sub, {Reg, {.reg_ = rsp}}, {Immed, {8}});
    INSERT_NEW_INSTRUCTION(mov, {Reg, {.reg_ = rdi}},
                           {Immed, {(std::int64_t)fmt_string}});
    INSERT_NEW_INSTRUCTION(mov, {Reg, {.reg_ = rsi}}, {Reg, {.reg_ = rsp}});
    INSERT_NEW_INSTRUCTION(mov, {Reg, {.reg_ = rax}},
                           {Immed, {(std::int64_t)scanf}});
    INSERT_NEW_INSTRUCTION(call, {Reg, {.reg_ = rax}});

    return true;
}

DEF(out) {
    INSERT_NEW_INSTRUCTION(nop);
    INSERT_NEW_INSTRUCTION(sub, {Reg, {.reg_ = rsp}}, {Immed, {8}});
    INSERT_NEW_INSTRUCTION(mov, {Reg, {.reg_ = rdi}},
                           {Immed, {(std::int64_t)fmt_string}});
    INSERT_NEW_INSTRUCTION(movsd, {Reg, {.reg_ = xmm0}}, {Mem, {.reg_ = rsp}});
    INSERT_NEW_INSTRUCTION(add, {Reg, {.reg_ = rsp}}, {Immed, {8}});
    INSERT_NEW_INSTRUCTION(mov, {Reg, {.reg_ = rax}},
                           {Immed, {(std::int64_t)printf}});
    INSERT_NEW_INSTRUCTION(call, {Reg, {.reg_ = rax}});

    return true;
}

DEF(jmp) {
    INSERT_NEW_INSTRUCTION(nop);
    INSERT_NEW_INSTRUCTION(jmp, {Immed,
                           {(std::int64_t)node->firstOp_.data_.immed_}});
    return true;
}

DEF(call) {
    INSERT_NEW_INSTRUCTION(nop);
    INSERT_NEW_INSTRUCTION(call, {Immed,
                           {(std::int64_t)node->firstOp_.data_.immed_}});

    return true;
}

#define DEF_CONDITIONAL_JMP(instr)                                             \
DEF(instr) {                                                                   \
    INSERT_NEW_INSTRUCTION(nop);                                               \
    INSERT_NEW_INSTRUCTION(movsd, {Reg, {.reg_ = xmm0}},                       \
                            {Mem, {.reg_ = rsp}});                             \
    INSERT_NEW_INSTRUCTION(add, {Reg, {.reg_ = rsp}}, {Immed, {8}});           \
    INSERT_NEW_INSTRUCTION(movsd, {Reg, {.reg_ = xmm1}},                       \
                           {Mem, {.reg_ = rsp}});                              \
    INSERT_NEW_INSTRUCTION(add, {Reg, {.reg_ = rsp}}, {Immed, {8}});           \
    INSERT_NEW_INSTRUCTION(comisd, {Reg, {.reg_ = xmm0}},                      \
                           {Reg, {.reg_ = xmm1}});                             \
    INSERT_NEW_INSTRUCTION(x86_64::instr, {Immed,                              \
                           {(std::int64_t)node->firstOp_.data_.immed_}});      \
    return true;                                                               \
}

DEF_CONDITIONAL_JMP(jae);
DEF_CONDITIONAL_JMP(jbe);
DEF_CONDITIONAL_JMP(ja);
DEF_CONDITIONAL_JMP(jb);
DEF_CONDITIONAL_JMP(je);

#undef DEF_CONDITIONAL_JMP

DEF(ret) {
    INSERT_NEW_INSTRUCTION(nop);
    INSERT_NEW_INSTRUCTION(ret);
    return true;
}

DEF(push) {
    INSERT_NEW_INSTRUCTION(nop);
    if (node->firstOp_.type_ == ir::Operand::Reg) {
        Register reg = regMappings[node->firstOp_.data_.regNum_].reg;
        INSERT_NEW_INSTRUCTION(sub, {Reg, {.reg_ = rsp}}, {Immed, {8}});
        INSERT_NEW_INSTRUCTION(movsd, {Mem, {.reg_ = rsp}},
                               {Reg, {.reg_ = reg}});
    } else {
        std::int64_t immed = 0;
        std::memcpy(&immed, &node->firstOp_.data_.immed_, sizeof(immed));
        INSERT_NEW_INSTRUCTION(mov, {Reg, {.reg_ = rax}}, {Immed, {immed}});
        INSERT_NEW_INSTRUCTION(push, {Reg, {.reg_ = rax}});
    }

    return true;
}

DEF(pop) {
    INSERT_NEW_INSTRUCTION(nop);
    Register reg = regMappings[node->firstOp_.data_.regNum_].reg;
    INSERT_NEW_INSTRUCTION(movsd, {Reg, {.reg_ = reg}}, {Mem, {.reg_ = rsp}});
    INSERT_NEW_INSTRUCTION(add, {Reg, {.reg_ = rsp}}, {Immed, {8}});

    return true;
}

DEF(sqrt) {
    INSERT_NEW_INSTRUCTION(nop);
    INSERT_NEW_INSTRUCTION(movsd, {Reg, {.reg_ = xmm1}},
                           {Mem, {.reg_ = rsp}});
    INSERT_NEW_INSTRUCTION(sqrtsd, {Reg, {.reg_ = xmm0}},
                           {Reg, {.reg_ = xmm1}});
    INSERT_NEW_INSTRUCTION(movsd, {Mem, {.reg_ = rsp}},
                           {Reg, {.reg_ = xmm0}});

    return true;
}

#define DEF_ARITH_BIN_OP(op)                                                   \
DEF(op) {                                                                      \
    INSERT_NEW_INSTRUCTION(nop);                                               \
    INSERT_NEW_INSTRUCTION(movsd, {Reg, {.reg_ = xmm0}},                       \
                            {Mem, {.reg_ = rsp}});                             \
    INSERT_NEW_INSTRUCTION(add, {Reg, {.reg_ = rsp}}, {Immed, {8}});           \
    INSERT_NEW_INSTRUCTION(movsd, {Reg, {.reg_ = xmm1}},                       \
                           {Mem, {.reg_ = rsp}});                              \
    INSERT_NEW_INSTRUCTION(add, {Reg, {.reg_ = rsp}}, {Immed, {8}});           \
    INSERT_NEW_INSTRUCTION(op##sd, {Reg, {.reg_ = xmm0}},                      \
                           {Reg, {.reg_ = xmm1}});                             \
    INSERT_NEW_INSTRUCTION(sub, {Reg, {.reg_ = rsp}}, {Immed, {8}});           \
    INSERT_NEW_INSTRUCTION(movsd, {Mem, {.reg_ = rsp}},                        \
                           {Reg, {.reg_ = xmm0}});                             \
    return true;                                                               \
}

DEF_ARITH_BIN_OP(add);
DEF_ARITH_BIN_OP(sub);
DEF_ARITH_BIN_OP(mul);
DEF_ARITH_BIN_OP(div);

#undef DEF_ARITH_BIN_OP
#undef INSERT_NEW_INSTRUCTION
#undef DEF
