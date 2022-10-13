# piecho
Bare metal Raspberry Pi program that echoes key strokes over a serial connection

I've built both programs on Linux, specifically:

```
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04.4 LTS
Release:	20.04
Codename:	focal
```

I tested it on a 

```Raspberry Pi 2 Model B v1.1```

In order to build the Rasberry Pi image, you need to install the GCC ARM tool chain which can be found [here](https://developer.arm.com/downloads/-/gnu-rm).

Once you have the tool chain setup, you can build the project:

```
export TOOLCHAIN=<path to your ARM toolchain>/arm-none-eabi
make all
```

The kernel image, ```kernel7.img``` is built along with a command line tool for sending characters to the Pi over a serial connection called  ```send```.

In order to test, you'll need a USB to TTL serial cable to connect your Pi to your development machine.  I've had success with the cable from [Adafruit](https://www.adafruit.com/product/954).

To run, connect the Pi to your development machince using the serial cable and boot the Pi with the kernel image.  The green LED light will turn on when it's ready to receive characters.

At this point, your serial connection should manifest itself as a device under ```/dev```.  With Linux, you don't need to install explicit drivers for the device as you would have to do under [Windows](https://learn.adafruit.com/adafruits-raspberry-pi-lesson-5-using-a-console-cable/software-installation-windows).  My device is ```/dev/ttyUSB0```.

Once the Pi is ready to receive characters you run ```send``` passing it the name of your device as the argument. ```send``` will send each character you type to the Pi which will immediately send it back, upon which, ```send``` will output it to the terminal.  Type ```'q'``` to quit ```send``` and the Raspberry Pi will turn off the LED and halt.
