/**
 * @file
 * @brief This file is a part of binary translator project.
 *
 * @copyright (C) Victor Baldin, 2024.
 */

#include "disasm.h"

#include <cerrno>
#include <cstdio>
#include <cstdint>
#include <cstring>

#include "buffer_file.h"

#define ARRAY_SIZE(x) sizeof(x) / sizeof(x[0])

namespace {

enum DisasmStatus {
    Proceeding,
    Halt,
    Error,
};

enum OperandMask {
    Immed = 0x20,
    Reg = 0x40,
};

const unsigned char OpcodeMask = 0x1f;

// -------------------- Specific constants ---------------------------

const unsigned char HaltInstruction = 0x10;
const std::int64_t signature = 0x1156414223;
const unsigned signatureSize = 5;

const disasm::SPUInstruction SPUInstructionSet[] = {
    {"in"  ,           0},
    {"out" ,           0},
    {"push", Immed | Reg},
    {"add" ,           0},
    {"sub" ,           0},
    {"mul" ,           0},
    {"div" ,           0},
    {"sqrt",           0},
    {"pop" ,         Reg},
    {"jmp" , Immed | Reg},
    {"jae" , Immed | Reg},
    {"jbe" , Immed | Reg},
    {"ja"  , Immed | Reg},
    {"jb"  , Immed | Reg},
    {"je"  , Immed | Reg},
    {"call", Immed | Reg},
    {"hlt" ,           0},
    {"ret" ,           0}};

const char* const Registers[] = {
    nullptr,
    "rax",
    "rbx",
    "rcx",
    "rdx"};

// -------------------------------------------------------------------

inline bool checkSignature(buffer_file::Buffer* buffer) {
    assert(buffer);

    if (buffer->len <= sizeof(int32_t) ||
        (std::memcmp(buffer->buf, &signature, signatureSize) != 0))
        return false;

    buffer->pos += signatureSize;
    return true;
}

DisasmStatus disassembleFromCurrent(buffer_file::Buffer* buffer, FILE* output) {
    assert(buffer && output);

    unsigned char fullOpcode = buffer->buf[buffer->pos++];
    unsigned char opcode = fullOpcode & OpcodeMask;
    if (opcode == HaltInstruction)
        return Halt;

    if (opcode >= ARRAY_SIZE(SPUInstructionSet)) {
        std::fprintf(stderr, "Invalid opcode\n");
        return Error;
    }

    std::fprintf(output, "%s", SPUInstructionSet[opcode].name);

    if (fullOpcode & Reg) {
        if (!(SPUInstructionSet[opcode].operandTypes & Reg)) {
            std::fprintf(stderr, "Invalid operand type\n");
            return Error;
        }

        if (buffer->len - buffer->pos <= 1) {
            std::fprintf(stderr, "Operand expected\n");
            return Error;
        }

        unsigned char regNum = buffer->buf[buffer->pos++];

        if (regNum == 0 || regNum > ARRAY_SIZE(Registers)) {
            std::fprintf(stderr, "Invalid register\n");
            return Error;
        }

        std::fprintf(output, " %s", Registers[regNum]);
    }

    if (fullOpcode & Immed) {
        if (!(SPUInstructionSet[opcode].operandTypes & Immed)) {
            std::fprintf(stderr, "Invalid operand type\n");
            return Error;
        }

        double imm = 0;
        if (buffer->len - buffer->pos <= sizeof(imm)) {
            std::fprintf(stderr, "Operand expected\n");
            return Error;
        }

        // Get double by misaligned address
        std::memcpy(&imm, &buffer->buf[buffer->pos], sizeof(imm));
        std::fprintf(output, " %lg", imm);


        buffer->pos += sizeof(imm);
    }

    std::fprintf(output, "\n");
    return Proceeding;
}

bool disassembleSPUCode(buffer_file::Buffer* buffer, FILE* output) {
    assert(buffer && output);

    if (!checkSignature(buffer)) {
        std::fprintf(stderr, "Invalid input file format\n");
        return false;
    }

    while (buffer->pos < buffer->len) {
        switch (disassembleFromCurrent(buffer, output)) {
        case Proceeding:
            break;
        case Halt:
            return true;
        case Error:
            return false;
        default:
            assert(0 && "Unhandled enum value");
        }
    }

    return true;
}

}

bool disasm::disassemble(Arguments args) {
    assert(args.inputFile);
    assert(args.outputFile);

    bool isDisassembled = true;

    buffer_file::Buffer* inputBuffer =
        buffer_file::createBuffer(args.inputFile);
    if (!inputBuffer)
        return false;

    FILE* output = std::fopen(args.outputFile, "w");
    if (!output) {
        std::fprintf(stderr,
                     "Failed to open %s: %s\n",
                     args.outputFile, std::strerror(errno));
        isDisassembled = false;
        goto cleanup;
    }

    if (!disassembleSPUCode(inputBuffer, output)) {
        // std::remove(args.outputFile);
        isDisassembled = false;
    }

    std::fclose(output);

cleanup:
    buffer_file::freeBuffer(inputBuffer);
    return isDisassembled;
}
