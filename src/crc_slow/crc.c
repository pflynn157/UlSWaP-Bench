/**********************************************************************
 *
 * Filename:    main.c
 *
 * Description: A simple test program for the CRC implementations.
 *
 * Notes:       To test a different CRC standard, modify crc.h.
 *
 *
 * Copyright (c) 2000 by Michael Barr.  This software is placed into
 * the public domain and may be used for any purpose.  However, this
 * notice must not be changed or removed and no warranty is either
 * expressed or implied by its publication or distribution.
 **********************************************************************/

#include <stdio.h>
#include <string.h>

#include "crc.h"
#include "text_input_16k.h"

/*
 * Derive parameters from the standard-specific parameters in crc.h.
 */
#define WIDTH (8 * sizeof(crc))
#define TOPBIT (1 << (WIDTH - 1))

#if (REFLECT_DATA == TRUE)
#undef REFLECT_DATA
#define REFLECT_DATA(X) ((uint8_t)reflect((X), 8))
#else
#undef REFLECT_DATA
#define REFLECT_DATA(X) (X)
#endif

#if (REFLECT_REMAINDER == TRUE)
#undef REFLECT_REMAINDER
#define REFLECT_REMAINDER(X) ((crc)reflect((X), WIDTH))
#else
#undef REFLECT_REMAINDER
#define REFLECT_REMAINDER(X) (X)
#endif

/*********************************************************************
 *
 * Function:    reflect()
 *
 * Description: Reorder the bits of a binary sequence, by reflecting
 *				them about the middle position.
 *
 * Notes:		No checking is done that nBits <= 32.
 *
 * Returns:		The reflection of the original data.
 *
 *********************************************************************/
static uint32_t
reflect(uint32_t data, uint8_t nBits)
{
    uint32_t reflection = 0x00000000;
    uint8_t bit;

    /*
     * Reflect the data about the center bit.
     */
    for (bit = 0; bit < nBits; ++bit)
    {
        /*
         * If the LSB bit is set, set the reflection of it.
         */
        if (data & 0x01)
        {
            reflection |= (1 << ((nBits - 1) - bit));
        }

        data = (data >> 1);
    }

    return (reflection);

} /* reflect() */

/*********************************************************************
 *
 * Function:    crcSlow()
 *
 * Description: Compute the CRC of a given message.
 *
 * Notes:
 *
 * Returns:		The CRC of the message.
 *
 *********************************************************************/
crc crcSlow(uint8_t const message[], uint32_t nBytes)
{
    crc remainder = INITIAL_REMAINDER;
    uint32_t byte;
    uint8_t bit;

    /*
     * Perform modulo-2 division, a byte at a time.
     */
    for (byte = 0; byte < nBytes; ++byte)
    {
        /*
         * Bring the next byte into the remainder.
         */
        remainder ^= (REFLECT_DATA(message[byte]) << (WIDTH - 8));

        /*
         * Perform modulo-2 division, a bit at a time.
         */
        for (bit = 8; bit > 0; --bit)
        {
            /*
             * Try to divide the current data bit.
             */
            if (remainder & TOPBIT)
            {
                remainder = (remainder << 1) ^ POLYNOMIAL;
            }
            else
            {
                remainder = (remainder << 1);
            }
        }
    }

    /*
     * The final remainder is the CRC result.
     */
    return (REFLECT_REMAINDER(remainder) ^ FINAL_XOR_VALUE);

} /* crcSlow() */

int benchmark_main(void)
{
    printf("Computing the CRC of a %li byte message\r\n", strlen((char*)test_data));
    uint32_t crc = crcSlow(test_data, strlen((char*)test_data));
    printf("%x\r\n", crc);
    printf("Expected: 63cf8222\n");
    
    return 0;
}

