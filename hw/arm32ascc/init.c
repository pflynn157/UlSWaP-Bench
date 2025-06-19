#include <stdio.h>
#include <stdint.h>

#define WDT_BASE            0xE000E010
#define WDT_TIME            WDT_BASE
#define WDT_INTERRUPT       WDT_BASE + 0x4
#define WDT_CMD             WDT_BASE + 0x8

#define WDT_EN          0x1
#define WDT_RST         0x2
#define WDT_ACT_RST     0x4
#define WDT_ACT_INT     0x8

extern void restore();

/*void setup_wdt(uint32_t clock, uint32_t run_time) {
    uint32_t *wdt = (uint32_t*)WDT_BASE;
    *wdt = clock * 1000 * run_time;      // should only get called a few times
    *(wdt+1) = 13;                        // Interrupt 13
   
    uint8_t *wdt_cmd = (uint8_t*)WDT_CMD;
    *wdt_cmd = WDT_EN | WDT_RST | WDT_ACT_INT;
}*/

void init() {
    // Setup the watchdog timer
    //setup_wdt(24, 120);

    // Check to see if we have any saved checkpoints
    restore();
}

