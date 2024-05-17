/**
 * @file
 * @brief This file is a part of binary translator project.
 *
 * @copyright (C) Victor Baldin, 2024.
 */

#include <cassert>
#include <cstdio>
#include <cstdlib>

#include <getopt.h>

#include "trans.h"

namespace {

const char helpMessage[] =
    "Binary translator\n"
    "Copyright (C) Victor Baldin, 2024\n"
    "Usage: trans [intput file] [options]\n"
    "Options:\n"
    "  -h           Print this message and exit\n"
    "  -v           Verbose output\n";

}

int main(int argc, char** argv) {
    const option options[] = {{"help", no_argument, 0, 'h'},
                              {"verbose", no_argument, 0, 'v'},
                              {0, 0, 0, 0}};

    trans::Arguments args = {};
    opterr = 0;

    while (optind < argc) {
        int ch = getopt_long(argc, argv, "hvS:", options, nullptr);

        switch (ch) {
        case -1:
            args.inputFile = argv[optind++];
            break;
        case 'h':
            std::puts(helpMessage);
            return 0;
        case 'v':
            args.verbose = true;
            break;
        case 'S':
            args.asmFile = optarg;
            break;
        case '?':
            std::puts(helpMessage);
            return EXIT_FAILURE;
        default:
            assert(0 && "Unexpected getopt_long return value");
        }
    }

    if (!trans::translate(args))
        return EXIT_FAILURE;
    return 0;
}
