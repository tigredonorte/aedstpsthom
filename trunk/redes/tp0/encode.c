#include <stdio.h>
#include <stdlib.h>
#include "base64.h"

/*
 * 
 */
int main(int argc, char** argv) {
    encode(argv[1], argv[2]);
    decode(argv[2], "in.test");
    return (EXIT_SUCCESS);
}

