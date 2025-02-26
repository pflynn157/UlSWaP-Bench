/* +++Date last modified: 05-Jul-1997 */

/*
**  Bit counter by Ratko Tomic
*/

#include "bitops.h"

uint32_t bit_count(uint32_t x)
{
    uint32_t n = 0;
    /*
    ** The loop will execute once for each bit of x set, this is in average
    ** twice as fast as the shift/test method.
    */
    if (x)
    {
        do
        {
            n++;
        }
        while (0 != (x = x & (x - 1)));
    }

    return (n);
}

#ifdef TEST

#include <stdlib.h>
#include "snip_str.h" /* For plural_text() macro    */

main(int argc, char *argv[])
{
    uint32_t n;

    while (--argc)
    {
        uint32_t i;

        n = atol(*++argv);
        i = bit_count(n);
        printf("%ld contains %d bit%s set\n", n, i, plural_text(i));
    }
    return 0;
}

#endif /* TEST */
