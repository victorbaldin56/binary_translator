/**
 * @file
 * @brief This file is a part of binary translator project.
 *
 * @copyright (C) Victor Baldin, 2024.
 */

#include "asm_listing.h"

#include <cassert>
#include <cerrno>
#include <cstring>

namespace {

const int MaxDisasmLine = 80;

void printInstruction(x86_64::Opcode instr, std::FILE* fp) {

#define DEF_X86_INSTRUCTION(instr)                                             \
    case x86_64::instr:                                                        \
        std::fprintf(fp, "    " #instr);                                       \
        break;

    switch (instr) {
    #include "x86_instr.h"
    default:
        assert(0 && "Unhandled enum value");
    }

#undef DEF_X86_INSTRUCTION

}

inline void printRegister(x86_64::Register reg, std::FILE* fp) {

#define DEF_X86_REG(reg)                                                       \
    case x86_64::reg:                                                          \
        std::fprintf(fp, #reg);                                                \
        break;

    switch (reg) {
    #include "x86_registers.h"
    }

#undef DEF_X86_REG

}

inline void printOperand(x86_64::Instr::Operand op, std::FILE* fp) {
    if (op.type_ == x86_64::Immed)
        fprintf(fp, "0x%lx", op.qword_);
    else if (op.type_ == x86_64::Reg)
        printRegister(op.reg_, fp);
    else if (op.type_ == x86_64::Mem) {
        fprintf(fp, "[");
        printRegister(op.reg_, fp);
        fprintf(fp, "]");
    }
}

void dumpInstruction(x86_64::Instr instr, std::FILE* fp, std::FILE* disasm) {
    assert(fp);
    assert(disasm);

    if (instr.opcode_ == x86_64::nop) {
        std::fseek(disasm, instr.disasmFileOffset_, 0);
        char disasmBuf[MaxDisasmLine] = {};
        std::fgets(disasmBuf, MaxDisasmLine, disasm);

        // Print translation annotation.
        fprintf(fp, "\n"
                    "    ; %s\n", disasmBuf);
        return;
    }

    printInstruction(instr.opcode_, fp);

    if (instr.lhs_.type_ != x86_64::Empty) {
        fprintf(fp, " ");
        printOperand(instr.lhs_, fp);
    }

    if (instr.rhs_.type_ != x86_64::Empty) {
        fprintf(fp, ", ");
        printOperand(instr.rhs_, fp);
    }

    std::fprintf(fp, "\n");
}

}

bool listing::dumpAsm(x86_64::InstrArray* arr, const char* file,
                      std::FILE* tmpDisasm) {
    assert(arr);
    assert(file);

    std::FILE* fp = std::fopen(file, "w");
    if (!fp) {
        std::fprintf(
            stderr,
            "Failed to open file %s: %s",
            file,
            std::strerror(errno));
        return false;
    }

    std::fprintf(
        fp,
        "global _start\n"
        "\n"
        "section .text\n"
        "\n"
        "_start:\n");

    for (std::size_t i = 0; i < arr->sz_; ++i)
        dumpInstruction(arr->data_[i], fp, tmpDisasm);

    std::fprintf(
        fp,
        "\n"
        "    mov rax, 0x3c\n"
        "    mov rdx, 0x0\n"
        "    syscall\n");

    std::fclose(fp);

    return true;
}
