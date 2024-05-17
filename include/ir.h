/**
 * @file
 * @brief This file is a part of binary translator project.
 *
 * @copyright (C) Victor Baldin, 2024.
 */

#ifndef BINARY_TRANSLATOR_IR_H_
#define BINARY_TRANSLATOR_IR_H_

#include <cstddef>
#include <cstdlib>
#include <cstdint>

namespace ir {

/** @brief */
struct Operand {
    enum {
        Immed,
        Reg,
        Empty,
    } type_;

    union {
        double immed_;
        unsigned char regNum_;
    } data_;
};

/** @brief Node of IR doubly-linked list. */
struct Node {
    unsigned instrNumber_;   ///< IR instruction
    Operand firstOp_;        ///< First operand
    Operand secondOp_;       ///< Second operand

    Node* prev_;             ///< Prev node
    Node* next_;             ///< Next node

    std::uint64_t addr_;
};

/** @brief Forward-declaration to hide implementation details. */
struct IR;

/** @brief Constructor. */
IR* createIR(std::size_t bufLen);

/** Destructor. */
void destroyIR(IR* self);

Node* insertIRNode(IR* self, Node* node, unsigned instrNumber,
                   Operand firstOp, Operand secondOp,
                   std::uint64_t addr);
Node* insertIRNodeBack(IR* self, unsigned instrNumber,
                       Operand firstOp, Operand secondOp,
                       std::uint64_t addr);
Node* IRHead(IR* self);
Node* getNodeByAddr(IR* self, std::uint64_t addr);

std::size_t bufLen(IR* self);

}  // namespace ir

#endif  // BINARY_TRANSLATOR_IR_H_
