/**
 * @file
 * @brief This file is a part of binary translator project.
 *
 * @copyright (C) Victor Baldin, 2024.
 */

#ifndef BINARY_TRANSLATOR_ASM_LISTING_H_
#define BINARY_TRANSLATOR_ASM_LISTING_H_

#include <cstdio>

#include "x86-64.h"

namespace listing {

bool dumpAsm(x86_64::InstrArray* arr, const char* file);

}  // namespace listing

#endif  // BINARY_TRANSLATOR_ASM_LISTING_H_
