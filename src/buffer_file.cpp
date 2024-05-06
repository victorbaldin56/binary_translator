/**
 * @file
 * @brief This file is a part of binary translator project.
 *
 * @copyright (C) Victor Baldin, 2024.
 */

#include "buffer_file.h"

#include <cassert>
#include <cstdio>

#include <fcntl.h>
#include <sys/stat.h>

buffer_file::Buffer* buffer_file::createBuffer(const char* fileName) {
    assert(fileName);

    Buffer* buffer = (Buffer*)std::calloc(1, sizeof(*buffer));
    if (!buffer)
        goto freeBuffer;

    struct stat statbuf;

    buffer->fd = open(fileName, O_RDONLY);
    if (buffer->fd == -1) {
        std::perror("open");
        goto freeBuffer;
    }

    if (fstat(buffer->fd, &statbuf) == -1) {
        std::perror("fstat");
        goto closeFile;
    }

    buffer->len = (std::size_t)statbuf.st_size;
    buffer->buf = (unsigned char*)mmap(nullptr, buffer->len,
                                       PROT_READ, MAP_PRIVATE, buffer->fd, 0);
    if (buffer->buf == MAP_FAILED) {
        std::perror("mmap");
        goto closeFile;
    }

    return buffer;

closeFile:
    close(buffer->fd);
freeBuffer:
    std::free(buffer);
    return nullptr;
}
