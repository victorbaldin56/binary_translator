/**
 * @file
 * @brief This file is a part of binary translator project.
 *
 * @copyright (C) Victor Baldin, 2024.
 */

#ifndef BINARY_TRANSLATOR_BUFFER_FILE_H_
#define BINARY_TRANSLATOR_BUFFER_FILE_H_

#include <cassert>
#include <cstddef>
#include <cstdlib>

#include <sys/mman.h>
#include <unistd.h>

namespace buffer_file {

/** @brief */
struct Buffer {
    unsigned char* buf;
    std::size_t len;
    int fd;  ///< To close after use
    std::size_t pos;
};

Buffer* createBuffer(const char* fileName);

inline void freeBuffer(Buffer* buffer) {
    assert(buffer);

    munmap(buffer->buf, buffer->len);
    close(buffer->fd);
    std::free(buffer);
}

}

#endif  // BINARY_TRANSLATOR_BUFFER_FILE_H_
