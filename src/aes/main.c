#include <stdio.h>
#include <string.h>
#include <stdint.h>

// Enable both ECB and CBC mode. Note this can be done before including aes.h or at compile-time.
// E.g. with GCC by using the -D flag: gcc -c aes.c -DCBC=0 -DECB=1
#define CBC 0
#define ECB 1

#include "common.h"
#include "aes.h"

#define ECB_MSG_SIZE 16
#define ECB_ITERATIONS 65536 / ECB_MSG_SIZE
#define CBC_MSG_SIZE 64
#define CBC_ITERATIONS 32768 / CBC_MSG_SIZE

uint8_t key[] = {0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c};
uint8_t iv[] = {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f};

void test_encrypt_ecb(void);
void test_decrypt_ecb(void);
void test_encrypt_cbc(void);
void test_decrypt_cbc(void);

static void print_char_array(uint8_t *arr, uint8_t len, const char* label)
{
    printf("%s: ", label);
    for (int i = 0; i < len; i++)
    {
        printf("%02x", arr[i]);
    }
    printf("\r\n");
}

int benchmark_main(void)
{
    printf("Mode: ECB\r\n");
    print_char_array(key, 16, "Key");
    printf("\r\n");

    test_encrypt_ecb();
    printf("\r\n");
    test_decrypt_ecb();

    return 0;
}

void test_encrypt_ecb(void)
{
    uint8_t in[] = {0x6b, 0xc1, 0xbe, 0xe2, 0x2e, 0x40, 0x9f, 0x96, 0xe9, 0x3d, 0x7e, 0x11, 0x73, 0x93, 0x17, 0x2a};
    uint8_t out[16];

    printf("Encrypting %u bytes %u times (%u bytes total) \r\n", ECB_MSG_SIZE, ECB_ITERATIONS, ECB_MSG_SIZE * ECB_ITERATIONS);
    for (int i = 0; i < ECB_ITERATIONS; i++)
    {
        AES128_ECB_encrypt(in, key, out);
    }

    print_char_array(in, 16, "Plaintext");
    print_char_array(out, 16, "Ciphertext");
}

void test_decrypt_ecb(void)
{
    uint8_t in[] = {0x3a, 0xd7, 0x7b, 0xb4, 0x0d, 0x7a, 0x36, 0x60, 0xa8, 0x9e, 0xca, 0xf3, 0x24, 0x66, 0xef, 0x97};
    uint8_t out[16];

    printf("Decrypting %u bytes %u times (%u bytes total) \r\n", ECB_MSG_SIZE, ECB_ITERATIONS, ECB_MSG_SIZE * ECB_ITERATIONS);
    for (int i = 0; i < ECB_ITERATIONS; i++)
    {
        AES128_ECB_decrypt(in, key, out);
    }

    print_char_array(in, 16, "Ciphertext");
    print_char_array(out, 16, "Plaintext");
}

#if CBC
void test_encrypt_cbc(void)
{
    uint8_t in[] = {0x6b, 0xc1, 0xbe, 0xe2, 0x2e, 0x40, 0x9f, 0x96, 0xe9, 0x3d, 0x7e, 0x11, 0x73, 0x93, 0x17, 0x2a,
                    0xae, 0x2d, 0x8a, 0x57, 0x1e, 0x03, 0xac, 0x9c, 0x9e, 0xb7, 0x6f, 0xac, 0x45, 0xaf, 0x8e, 0x51,
                    0x30, 0xc8, 0x1c, 0x46, 0xa3, 0x5c, 0xe4, 0x11, 0xe5, 0xfb, 0xc1, 0x19, 0x1a, 0x0a, 0x52, 0xef,
                    0xf6, 0x9f, 0x24, 0x45, 0xdf, 0x4f, 0x9b, 0x17, 0xad, 0x2b, 0x41, 0x7b, 0xe6, 0x6c, 0x37, 0x10};
    uint8_t out[] = {0x76, 0x49, 0xab, 0xac, 0x81, 0x19, 0xb2, 0x46, 0xce, 0xe9, 0x8e, 0x9b, 0x12, 0xe9, 0x19, 0x7d,
                     0x50, 0x86, 0xcb, 0x9b, 0x50, 0x72, 0x19, 0xee, 0x95, 0xdb, 0x11, 0x3a, 0x91, 0x76, 0x78, 0xb2,
                     0x73, 0xbe, 0xd6, 0xb8, 0xe3, 0xc1, 0x74, 0x3b, 0x71, 0x16, 0xe6, 0x9e, 0x22, 0x22, 0x95, 0x16,
                     0x3f, 0xf1, 0xca, 0xa1, 0x68, 0x1f, 0xac, 0x09, 0x12, 0x0e, 0xca, 0x30, 0x75, 0x86, 0xe1, 0xa7};
    uint8_t buffer[64];

    printf("Encrypting %u bytes %u times (%u bytes total) \r\n", CBC_MSG_SIZE, CBC_ITERATIONS, CBC_MSG_SIZE * CBC_ITERATIONS);
    for (int i = 0; i < CBC_ITERATIONS; i++)
    {
        AES128_CBC_encrypt_buffer(buffer, in, 64, key, iv);
    }

    print_char_array(in, 64, "Plaintext");
    print_char_array(buffer, 64, "Ciphertext");

    if (0 == strncmp((char *)out, (char *)buffer, 64))
    {
        printf("SUCCESS!\r\n\r\n");
    }
    else
    {
        printf("FAILURE!\r\n\r\n");
    }
}

void test_decrypt_cbc(void)
{
    uint8_t in[] = {0x76, 0x49, 0xab, 0xac, 0x81, 0x19, 0xb2, 0x46, 0xce, 0xe9, 0x8e, 0x9b, 0x12, 0xe9, 0x19, 0x7d,
                    0x50, 0x86, 0xcb, 0x9b, 0x50, 0x72, 0x19, 0xee, 0x95, 0xdb, 0x11, 0x3a, 0x91, 0x76, 0x78, 0xb2,
                    0x73, 0xbe, 0xd6, 0xb8, 0xe3, 0xc1, 0x74, 0x3b, 0x71, 0x16, 0xe6, 0x9e, 0x22, 0x22, 0x95, 0x16,
                    0x3f, 0xf1, 0xca, 0xa1, 0x68, 0x1f, 0xac, 0x09, 0x12, 0x0e, 0xca, 0x30, 0x75, 0x86, 0xe1, 0xa7};
    uint8_t out[] = {0x6b, 0xc1, 0xbe, 0xe2, 0x2e, 0x40, 0x9f, 0x96, 0xe9, 0x3d, 0x7e, 0x11, 0x73, 0x93, 0x17, 0x2a,
                     0xae, 0x2d, 0x8a, 0x57, 0x1e, 0x03, 0xac, 0x9c, 0x9e, 0xb7, 0x6f, 0xac, 0x45, 0xaf, 0x8e, 0x51,
                     0x30, 0xc8, 0x1c, 0x46, 0xa3, 0x5c, 0xe4, 0x11, 0xe5, 0xfb, 0xc1, 0x19, 0x1a, 0x0a, 0x52, 0xef,
                     0xf6, 0x9f, 0x24, 0x45, 0xdf, 0x4f, 0x9b, 0x17, 0xad, 0x2b, 0x41, 0x7b, 0xe6, 0x6c, 0x37, 0x10};
    uint8_t buffer[64];

    printf("Decrypting %u bytes %u times (%u bytes total) \r\n", CBC_MSG_SIZE, CBC_ITERATIONS, CBC_MSG_SIZE * CBC_ITERATIONS);
    for (int i = 0; i < CBC_ITERATIONS; i++)
    {
        AES128_CBC_decrypt_buffer(buffer, in, 64, key, iv);
    }

    print_char_array(in, 64, "Ciphertext");
    print_char_array(buffer, 64, "Plaintext");

    if (0 == strncmp((char *)out, (char *)buffer, 64))
    {
        printf("SUCCESS!\r\n\r\n");
    }
    else
    {
        printf("FAILURE!\r\n\r\n");
    }
}
#endif  // CBC
