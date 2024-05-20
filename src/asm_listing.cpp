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
const int MaxListingLine = 60;

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

inline void printOperand(x86_64::Instr::Operand op, std::FILE* fp,
                         bool asDword = false) {
#define GEN_SYMBOL(func)                                                      \
    do {                                                                      \
        if (op.qword_ == (std::int64_t)func) {                                \
            std::fprintf(fp, #func);                                          \
            return;                                                           \
        }                                                                     \
    } while (0)

    if (op.type_ == x86_64::Immed) {
        GEN_SYMBOL(printf);
        GEN_SYMBOL(scanf);
        GEN_SYMBOL(fmt_string);

        if (asDword)
            std::fprintf(fp, "0x%x", (std::int32_t)op.qword_);
        else
            std::fprintf(fp, "strict qword 0x%lx", op.qword_);
    } else if (op.type_ == x86_64::Reg)
        printRegister(op.reg_, fp);
    else if (op.type_ == x86_64::Mem) {
        std::fprintf(fp, "[");
        printRegister(op.reg_, fp);
        std::fprintf(fp, "]");
    }

#undef GEN_SYMBOL

}

void dumpInstruction(x86_64::Instr instr, std::FILE* output, std::FILE* disasm) {
    assert(output);
    assert(disasm);

#define PRINT_OP(op)                                                           \
    do {                                                                       \
        if (instr.opcode_ == x86_64::mov)                                      \
            printOperand(op, output);                                          \
        else                                                                   \
            printOperand(op, output, true); /* Print as dword */               \
    } while (0)

    long strPos = std::ftell(output);

    if (instr.opcode_ == x86_64::nop) {
        std::fseek(disasm, instr.disasmFileOffset_, 0);
        char disasmBuf[MaxDisasmLine] = {};
        std::fgets(disasmBuf, MaxDisasmLine, disasm);

        // Print translation annotation.
        std::fprintf(output, "\n"
                    "    ; %s\n", disasmBuf);
        return;
    }

    printInstruction(instr.opcode_, output);

    if (instr.lhs_.type_ != x86_64::Empty) {
        fprintf(output, " ");
        PRINT_OP(instr.lhs_);
    }

    if (instr.rhs_.type_ != x86_64::Empty) {
        std::fprintf(output, ", ");
        PRINT_OP(instr.rhs_);
    }

    long printedChars = std::ftell(output) - strPos;
    for (long i = printedChars; i < MaxListingLine; ++i)
        std::fputc(' ', output);

    std::fprintf(output, "; %08x\n", (std::uint32_t)instr.absOffset_);

#undef PRINT_OP
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
        "extern printf\n"
        "extern scanf\n"
        "\n"
        "global main\n"
        "\n"
        "section .text\n"
        "\n"
        "main:\n"
        "    default abs\n");

    for (std::size_t i = 0; i < arr->sz_; ++i)
        dumpInstruction(arr->data_[i], fp, tmpDisasm);

    std::fprintf(
        fp,
        "\n"
        "section .rodata\n"
        "fmt_string db '%%lg '\n");

    std::fclose(fp);

    return true;
}
