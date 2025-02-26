/* +++Date last modified: 05-Jul-1997 */

/*
**  Make an ascii binary string into an integer.
**
**  Public domain by Bob Stout
*/

#include <string.h>
#include <stdint.h>
#include "bitops.h"

uint32_t bstr_i(char *cptr)
{
    uint32_t i, j = 0;

    while (cptr && *cptr && strchr("01", *cptr))
    {
        i = *cptr++ - '0';
        j <<= 1;
        j |= (i & 0x01);
    }
    return (j);
}

#ifdef TEST

#include <stdlib.h>

int main(int argc, char *argv[])
{
    char *arg;
    uint32_t x;

    while (--argc)
    {
        x = bstr_i(arg = *++argv);
        printf("Binary %s = %d = %04Xh\n", arg, x, x);
    }
    return EXIT_SUCCESS;
}

#endif /* TEST */
