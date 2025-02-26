#include <stdint.h>

/* Parameters to generate Join Accept message
 * --anonce 0xBB1872
 * --devaddr 0x12345678
 * --netid 0x02468A
 * --appkey 0x2B7E151628AED2A6ABF7158809CF4F3C
 * --dnonce 0xDC25
*/

// 0x1122334455667788
uint8_t g_dev_eui[] = {
    0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88
};

// 0x1234567890ABCDEF
uint8_t g_app_eui[] = {
    0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF
};

// 0x2B7E151628AED2A6ABF7158809CF4F3C
uint8_t g_app_key[] = {
    0x2B, 0x7E, 0x15, 0x16, 0x28, 0xAE, 0xD2, 0xA6,
    0xAB, 0xF7, 0x15, 0x88, 0x09, 0xCF, 0x4F, 0x3C
};

// 0x610C273A883B6BBFF0E349781A6BB7D5
uint8_t g_nwk_skey[] = {
    0x61, 0x0C, 0x27, 0x3A, 0x88, 0x3B, 0x6B, 0xBF,
    0xF0, 0xE3, 0x49, 0x78, 0x1A, 0x6B, 0xB7, 0xD5
};

// 0x5226DC9CDB8E113172A865FA808BAB10
uint8_t g_app_skey[] = {
    0x52, 0x26, 0xDC, 0x9C, 0xDB, 0x8E, 0x11, 0x31,
    0x72, 0xA8, 0x65, 0xFA, 0x80, 0x8B, 0xAB, 0x10
};

// const uint32_t g_dev_address = 0x12345678;
// const uint32_t g_port        = 2;
// const uint32_t g_fcnt        = 1234;
const uint16_t g_devnonce    = 0xDC25;

// 20DC659BA13B4313FEB4E0000BDAD04BED
uint8_t g_input_ja_msg[] = {
    0x20, 0xDC, 0x65, 0x9B, 0xA1, 0x3B, 0x43, 0x13,
    0xFE, 0xB4, 0xE0, 0x00, 0x0B, 0xDA, 0xD0, 0x4B,
    0xED
};

uint32_t g_input_ja_msg_len = sizeof(g_input_ja_msg);

// 607856341200D20402744587666982B6B4935656010308E0D52F3B360D17B7387D3B884C16A489C158B19E97A54026D2AF30AB3753EC2B70D1AFD2BF98347
// F20CA842AA8D043DAB813D8A97F7EEEB56425CAA88335C130460B64723D7217DB1B52688BECC0E41856B3F7E49D5B4D1C187EF06910525302CBF0664C991E
// 15FFB42EB668B17305628CDA444A07B84AD1A0623172176C0CCA325791463AF0AFE2FD464ED113F271EDB7C6A74CBE81F071C075992A0C40DB11A69A3325F
// CA4B0A661DC82ABF6D1DDC4E7ACB176FFD61C896B20A6B9A111C901B7D4BBCAA97DC5F72005053951E0F77C35AE0C04846702510DAF04D9CC76E90CB0D5D8
// 14C1
uint8_t g_input_ud_msg[] = {
    0x60, 0x78, 0x56, 0x34, 0x12, 0x00, 0xD2, 0x04,
    0x02, 0x74, 0x45, 0x87, 0x66, 0x69, 0x82, 0xB6,
    0xB4, 0x93, 0x56, 0x56, 0x01, 0x03, 0x08, 0xE0,
    0xD5, 0x2F, 0x3B, 0x36, 0x0D, 0x17, 0xB7, 0x38,
    0x7D, 0x3B, 0x88, 0x4C, 0x16, 0xA4, 0x89, 0xC1,
    0x58, 0xB1, 0x9E, 0x97, 0xA5, 0x40, 0x26, 0xD2,
    0xAF, 0x30, 0xAB, 0x37, 0x53, 0xEC, 0x2B, 0x70,
    0xD1, 0xAF, 0xD2, 0xBF, 0x98, 0x34, 0x7F, 0x20,
    0xCA, 0x84, 0x2A, 0xA8, 0xD0, 0x43, 0xDA, 0xB8,
    0x13, 0xD8, 0xA9, 0x7F, 0x7E, 0xEE, 0xB5, 0x64,
    0x25, 0xCA, 0xA8, 0x83, 0x35, 0xC1, 0x30, 0x46,
    0x0B, 0x64, 0x72, 0x3D, 0x72, 0x17, 0xDB, 0x1B,
    0x52, 0x68, 0x8B, 0xEC, 0xC0, 0xE4, 0x18, 0x56,
    0xB3, 0xF7, 0xE4, 0x9D, 0x5B, 0x4D, 0x1C, 0x18,
    0x7E, 0xF0, 0x69, 0x10, 0x52, 0x53, 0x02, 0xCB,
    0xF0, 0x66, 0x4C, 0x99, 0x1E, 0x15, 0xFF, 0xB4,
    0x2E, 0xB6, 0x68, 0xB1, 0x73, 0x05, 0x62, 0x8C,
    0xDA, 0x44, 0x4A, 0x07, 0xB8, 0x4A, 0xD1, 0xA0,
    0x62, 0x31, 0x72, 0x17, 0x6C, 0x0C, 0xCA, 0xA3,
    0x25, 0x79, 0x14, 0x63, 0xAF, 0x0A, 0xFE, 0xC2,
    0xFD, 0x46, 0x4E, 0xD1, 0x13, 0xF2, 0x71, 0xED,
    0xB7, 0xC6, 0xA7, 0x4C, 0xBE, 0x81, 0xF0, 0x71,
    0xC0, 0x75, 0x99, 0x2A, 0x0C, 0x40, 0xDB, 0x11,
    0xA6, 0x9A, 0x33, 0x25, 0xFC, 0xA4, 0xB0, 0xA6,
    0x61, 0xDC, 0x82, 0xAB, 0xF6, 0xD1, 0xDD, 0xC4,
    0xE7, 0xAC, 0xB1, 0x76, 0xFF, 0xD6, 0x1C, 0x89,
    0x6B, 0x20, 0xA6, 0xB9, 0xA1, 0x11, 0xC9, 0x01,
    0xB7, 0xD4, 0xBB, 0xCA, 0xA9, 0x7D, 0xC5, 0xF7,
    0x20, 0x05, 0x05, 0x39, 0x51, 0xE0, 0xF7, 0x7C,
    0x35, 0xAE, 0x0C, 0x04, 0x84, 0x67, 0x02, 0x51,
    0x0D, 0xAF, 0x04, 0xD9, 0xCC, 0x76, 0xE9, 0x0C,
    0xB0, 0xD5, 0xD8, 0x14, 0xC1,
};

uint32_t g_input_ud_msg_len = sizeof(g_input_ud_msg);
