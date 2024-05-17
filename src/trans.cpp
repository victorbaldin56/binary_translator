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
#include "x86-64.h"
namespace {

void translateToX86(ir::IR* ir, trans::Arguments args) {
    x86_64::InstrArray instr;
    x86_64::createInstrArray(&instr, ir::bufLen(ir));

    for (ir::Node* it = ir::IRHead(ir)->next_; it != ir::IRHead(ir);
        it = it->next_) {
        trans::InstrMap map = trans::instrMappings[it->instrNumber_];
        map.mapFunc(&instr, ir, it);
    }

    listing::dumpAsm(&instr, args.asmFile);
    x86_64::destroyInstrArray(&instr);
}

}

bool trans::translate(Arguments args) {
    assert(args.inputFile && args.asmFile);

    ir::IR* ir = disasm::disassemble(args);
    if (!ir)
        return false;

    translateToX86(ir, args);

    ir::destroyIR(ir);
    return true;
}
