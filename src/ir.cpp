/**
 * @file
 * @brief This file is a part of binary translator project.
 *
 * @copyright (C) Victor Baldin, 2024.
 */

#include "ir.h"

#include <cassert>
#include <cstdlib>

struct ir::IR {
    Node fakeNode_;
    std::size_t size_;
    std::size_t bufLen_;

    Node** buf_;
};

ir::IR* ir::createIR(std::size_t bufLen) {
    IR* res = (IR*)std::calloc(1, sizeof(*res));
    if (!res)
        return nullptr;

    res->bufLen_ = bufLen;
    res->fakeNode_ = {.prev_ = &res->fakeNode_, .next_ = &res->fakeNode_ };

    return res;
}

void ir::destroyIR(IR* self) {
    assert(self);

    for (Node* it = self->fakeNode_.next_; it != &self->fakeNode_;) {
        Node* tmp = it->next_;
        std::free(it);
        it = tmp;
    }

    std::free(self);
}

ir::Node* ir::insertIRNode(IR* self, Node* node, unsigned instrNumber,
                           Operand firstOp, Operand secondOp,
                           std::uint64_t addr, long tmpOffset) {
    assert(self);
    assert(node);

    Node* newNode = (Node*)std::calloc(1, sizeof(*newNode));
    if (!newNode)
        return nullptr;

    *newNode = {.instrNumber_ = instrNumber,
                .firstOp_ = firstOp, .secondOp_ = secondOp,
                .prev_ = node, .next_ = node->next_, .addr_ = addr,
                .disasmPos_ = tmpOffset};

    node->next_->prev_ = newNode;
    node->next_ = newNode;
    ++self->size_;

    return newNode;
}

ir::Node* ir::insertIRNodeBack(IR* self, unsigned instrNumber,
                               Operand firstOp, Operand secondOp,
                               std::uint64_t addr, long tmpOffset) {
    return insertIRNode(self, self->fakeNode_.prev_, instrNumber,
                        firstOp, secondOp, addr, tmpOffset);
}

ir::Node* ir::IRHead(IR* self) {
    return &self->fakeNode_;
}

std::size_t ir::bufLen(IR* self) {
    return self->bufLen_;
}
