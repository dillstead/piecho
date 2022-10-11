#include "gpio.h"
#include "mmio.h"
#include "led.h"

void led_init(void)
{
    uint32_t selector;

    selector = mmio_read(GPFSEL4);
    selector &= ~(7 << 21);
    selector |= 1 << 21;
    mmio_write(GPFSEL4, selector);
}

// ~10000000 for interval
void led_blink(int times, int32_t interval)
{
    for (int i = 0; i < times; i++)
    {
        led_on();
        delay(interval);
        led_off();
        delay(interval);
    }
}

void led_on(void)
{
    mmio_write(GPSET1, 1 << (47 - 32));
}

void led_off(void)
{
    mmio_write(GPCLR1, 1 << (47 - 32));
}
