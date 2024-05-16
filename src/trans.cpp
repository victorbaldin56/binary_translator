/**
 * @file
 * @brief This file is a part of binary translator project.
 *
 * @copyright (C) Victor Baldin, 2024.
 */

#include "trans.h"

#include <cassert>

#include "disasm.h"
#include "x86-64.h"

bool trans::translate(Arguments args) {
    assert(args.inputFile && args.outputFile);

    ir::IR* ir = disasm::disassemble(args);
    if (!ir)
        return false;

    x86_64::Instruction* instr =
        (x86_64::Instruction*)std::calloc(ir::IRBufLen(ir), sizeof(*instr));

    for (ir::Node* it = ir::IRHead(ir); it->next_ != ir::IRHead(ir);
        it = it->next_) {
        trans::InstrMap map = trans::instrMappings[it->instrNumber_];
        map.mapFunc(ir, it);
    }

    ir::destroyIR(ir);
    return true;
}
