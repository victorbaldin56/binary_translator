/**
 * @file
 * @brief This file is a part of binary translator project.
 *
 * @copyright (C) Victor Baldin, 2024.
 */

#ifndef DEF_X86_INSTRUCTION
#error "DEF_X86_INSTRUCTION must be defined"
#endif

DEF_X86_INSTRUCTION(mov)
DEF_X86_INSTRUCTION(add)
DEF_X86_INSTRUCTION(sub)
DEF_X86_INSTRUCTION(push)
DEF_X86_INSTRUCTION(call)
DEF_X86_INSTRUCTION(jmp)
DEF_X86_INSTRUCTION(ret)

DEF_X86_INSTRUCTION(addsd)
DEF_X86_INSTRUCTION(subsd)
DEF_X86_INSTRUCTION(mulsd)
DEF_X86_INSTRUCTION(divsd)
DEF_X86_INSTRUCTION(sqrtsd)
DEF_X86_INSTRUCTION(movsd)
DEF_X86_INSTRUCTION(comisd)