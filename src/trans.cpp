/**
 * @file
 * @brief This file is a part of binary translator project.
 *
 * @copyright (C) Victor Baldin, 2024.
 */

#include "trans.h"

#include <cassert>

#include "asm_listing.h"
#include "disasm.h"
#include "jit.h"
#include "x86-64.h"

namespace {

void setRelJumps(x86_64::InstrArray* instr) {
    assert(instr);

    for (std::size_t i = 0; i < instr->sz_; ++i) {
        x86_64::Instr cur = instr->data_[i];

        if (x86_64::call <= cur.opcode_ && cur.opcode_ <= x86_64::je &&
            cur.lhs_.type_ == x86_64::Immed) {
            std::uint64_t nextAddr
                = instr->data_[instr->oldAddrToNew_[cur.lhs_.qword_
                + disasm::signatureSize]].absOffset_;

            unsigned jmpOffset = 0;

            if (cur.opcode_ == x86_64::call)
                jmpOffset = 1;
            else if (cur.opcode_ == x86_64::jmp)
                jmpOffset = 3;
            else
                jmpOffset = 2;

            instr->data_[i].lhs_.qword_
                = (std::int64_t)(nextAddr - cur.absOffset_ - jmpOffset);
        }
    }
}

void translateToX86(ir::IR* ir, trans::Arguments args, std::FILE* disasm) {
    x86_64::InstrArray instr;
    x86_64::createInstrArray(&instr, ir::bufLen(ir));

    for (ir::Node* it = ir::IRHead(ir)->next_; it != ir::IRHead(ir);
        it = it->next_) {
        trans::InstrMap map = trans::instrMappings[it->instrNumber_];
        map.mapFunc(&instr, ir, it);
    }

    setRelJumps(&instr);

    if (args.asmFile)
        listing::dumpAsm(&instr, args.asmFile, disasm);

    jit::run(&instr);
    x86_64::destroyInstrArray(&instr);
}

}

bool trans::translate(Arguments args) {
    assert(args.inputFile);

    // To store SPU code disassembly and annotate output x86 assembly.
    std::FILE* tmpDisasm = std::tmpfile();

    ir::IR* ir = disasm::disassemble(args, tmpDisasm);
    if (!ir)
        return false;

    translateToX86(ir, args, tmpDisasm);

    std::fclose(tmpDisasm);
    ir::destroyIR(ir);
    return true;
}
