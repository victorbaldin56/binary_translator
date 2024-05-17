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
#include "x86-64.h"

// #define DEBUG

#ifdef DEBUG
#define ON_DEBUG(...) __VA_ARGS__
#else
#define ON_DEBUG(...)
#endif

#define ARRAY_SIZE(x) sizeof(x) / sizeof(x[0])

namespace {

using trans::Immed;
using trans::Reg;
using trans::instrMappings;

enum DisasmStatus {
    Proceeding,
    Halt,
    Error,
};

const unsigned char OpcodeMask = 0x1f;

// -------------------- Specific constants ---------------------------

const unsigned char HaltInstruction = 0x10;
const std::int64_t signature = 0x1156414223;
const unsigned signatureSize = 5;

// -------------------------------------------------------------------

inline bool checkSignature(buffer_file::Buffer* buffer) {
    assert(buffer);

    if (buffer->len <= signatureSize ||
        (std::memcmp(buffer->buf, &signature, signatureSize) != 0))
        return false;

    buffer->pos += signatureSize;
    return true;
}

DisasmStatus disassembleOnCurrent(buffer_file::Buffer* buffer,
                                  ON_DEBUG(std::FILE* output,)
                                  ir::IR* ir) {
    assert(buffer);
    assert(ir);

    unsigned char fullOpcode = buffer->buf[buffer->pos++];
    unsigned char opcode = fullOpcode & OpcodeMask;
    std::size_t pos = buffer->pos;

    ir::Operand firstOp = {.type_ = ir::Operand::Empty};
    ir::Operand secondOp = {.type_ = ir::Operand::Empty};

    if (opcode == HaltInstruction)
        return Halt;

    if (opcode >= ARRAY_SIZE(instrMappings)) {
        std::fprintf(stderr, "Invalid opcode\n");
        return Error;
    }

    ON_DEBUG(std::fprintf(output, "%s", instrMappings[opcode].name));

    if (fullOpcode & Reg) {
        if (!(instrMappings[opcode].operandTypes & Reg)) {
            std::fprintf(stderr, "Invalid operand type\n");
            return Error;
        }

        if (buffer->len - buffer->pos <= 1) {
            std::fprintf(stderr, "Operand expected\n");
            return Error;
        }

        unsigned char regNum = buffer->buf[buffer->pos++];

        if (regNum == 0 || regNum > ARRAY_SIZE(x86_64::regMappings)) {
            std::fprintf(stderr, "Invalid register\n");
            return Error;
        }

        ON_DEBUG(std::fprintf(output, " %s", x86_64::regMappings[regNum].nameInSPU));
        firstOp.type_ = ir::Operand::Reg;
        firstOp.data_ = {.regNum_ = regNum};
    }

    if (fullOpcode & Immed) {
        if (!(instrMappings[opcode].operandTypes & Immed)) {
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
        ON_DEBUG(std::fprintf(output, " %lg", imm));
        if (firstOp.type_ == ir::Operand::Reg) {
            secondOp.type_ = ir::Operand::Immed;
            secondOp.data_ = {.immed_ = imm};
        } else {
            firstOp.type_ = ir::Operand::Reg;
            firstOp.data_ = {.immed_ = imm};
        }

        buffer->pos += sizeof(imm);
    }

    ON_DEBUG(std::fprintf(output, "\n"));
    // save pointer to node for future iterations
    ir::insertIRNodeBack(ir, opcode, firstOp, secondOp, pos);
    return Proceeding;
}

bool disassembleSPUCode(buffer_file::Buffer* buffer,
                        ON_DEBUG(std::FILE* output,) ir::IR* ir) {
    assert(buffer);

    if (!checkSignature(buffer)) {
        std::fprintf(stderr, "Invalid input file format\n");
        return false;
    }

    while (buffer->pos < buffer->len) {
        switch (disassembleOnCurrent(buffer, ON_DEBUG(output,) ir)) {
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

ir::IR* disasm::disassemble(trans::Arguments args) {
    assert(args.inputFile);
    assert(args.asmFile);

    buffer_file::Buffer* inputBuffer =
        buffer_file::createBuffer(args.inputFile);
    if (!inputBuffer)
        return nullptr;

    ir::IR* ir = ir::createIR(inputBuffer->len);

#ifdef DEBUG
    std::FILE* output = std::fopen(args.asmFile, "w");
    if (!output) {
        std::fprintf(stderr,
                     "Failed to open %s: %s\n",
                     args.asmFile, std::strerror(errno));
        goto cleanup;
    }
#endif

    if (!disassembleSPUCode(inputBuffer, ON_DEBUG(output,) ir)) {
        // std::remove(args.outputFile);
        goto cleanup;
    }

    buffer_file::freeBuffer(inputBuffer);
    ON_DEBUG(std::fclose(output));
    return ir;

cleanup:
    ir::destroyIR(ir);
    buffer_file::freeBuffer(inputBuffer);
    return ir;
}
