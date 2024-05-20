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
    Error,
};

const unsigned char OpcodeMask = 0x1f;

// -------------------- Specific constants ---------------------------

const std::int64_t signature = 0x1156414223;

using disasm::signatureSize;

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
                                  std::FILE* output,
                                  ir::IR* ir) {
    assert(buffer);
    assert(ir);

    std::size_t pos = buffer->pos;
    unsigned char fullOpcode = buffer->buf[buffer->pos++];
    unsigned char opcode = fullOpcode & OpcodeMask;

    ir::Operand firstOp = {.type_ = ir::Operand::Empty};
    ir::Operand secondOp = {.type_ = ir::Operand::Empty};

    if (opcode >= ARRAY_SIZE(instrMappings)) {
        std::fprintf(stderr, "Invalid opcode\n");
        return Error;
    }

    long disasmFilePos = std::ftell(output);
    std::fprintf(output, "%s", instrMappings[opcode].name);

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

        std::fprintf(output, " %s", x86_64::regMappings[regNum].nameInSPU);
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
        std::fprintf(output, " %lg", imm);
        if (firstOp.type_ == ir::Operand::Reg) {
            secondOp.type_ = ir::Operand::Immed;
            secondOp.data_ = {.immed_ = imm};
        } else {
            firstOp.type_ = ir::Operand::Immed;
            firstOp.data_ = {.immed_ = imm};
        }

        buffer->pos += sizeof(imm);
    }

    std::fputc(0, output);
    // save pointer to node for future iterations
    ir::insertIRNodeBack(ir, opcode, firstOp, secondOp, pos, disasmFilePos);
    return Proceeding;
}

bool disassembleSPUCode(buffer_file::Buffer* buffer,
                        std::FILE* output, ir::IR* ir) {
    assert(buffer);

    if (!checkSignature(buffer)) {
        std::fprintf(stderr, "Invalid input file format\n");
        return false;
    }

    while (buffer->buf[buffer->pos] != 0xbe) {
        switch (disassembleOnCurrent(buffer, output, ir)) {
        case Proceeding:
            break;
        case Error:
            return false;
        default:
            assert(0 && "Unhandled enum value");
        }
    }

    return true;
}

}

ir::IR* disasm::disassemble(trans::Arguments args, std::FILE* output) {
    assert(args.inputFile);
    assert(args.asmFile);

    buffer_file::Buffer* inputBuffer =
        buffer_file::createBuffer(args.inputFile);
    if (!inputBuffer)
        return nullptr;

    ir::IR* ir = ir::createIR(inputBuffer->len);

    if (!disassembleSPUCode(inputBuffer, output, ir)) {
        // std::remove(args.outputFile);
        goto cleanup;
    }

    buffer_file::freeBuffer(inputBuffer);
    return ir;

cleanup:
    ir::destroyIR(ir);
    buffer_file::freeBuffer(inputBuffer);
    return ir;
}
