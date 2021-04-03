# Simple example of reading the MCP3008 analog input channels and printing
# them all out.
# Author: Tony DiCola
# License: Public Domain
import time

# Import SPI library (for hardware SPI) and MCP3008 library.
import Adafruit_GPIO.SPI as SPI
import Adafruit_MCP3008
import RPi.GPIO as  GPIO

GPIO.setmode(GPIO.BCM)
# Software SPI configuration:
CLK  = 18
MISO = 23
MOSI = 24
CS   = 25
pos_x = 06
GPIO.setup(pos_x, GPIO.OUT)
neg_x = 13
GPIO.setup(neg_x, GPIO.OUT)
pos_y = 19
GPIO.setup(pos_y, GPIO.OUT)
neg_y = 26
GPIO.setup(neg_y, GPIO.OUT)
sel_but = 22
GPIO.setup(sel_but, GPIO.OUT)
mcp = Adafruit_MCP3008.MCP3008(clk=CLK, cs=CS, miso=MISO, mosi=MOSI)

# Hardware SPI configuration:
# SPI_PORT   = 0
# SPI_DEVICE = 0
# mcp = Adafruit_MCP3008.MCP3008(spi=SPI.SpiDev(SPI_PORT, SPI_DEVICE))

#values[i] = mcp.read_adc(i)
print('Reading MCP3008 values, press Ctrl-C to quit...')
# Print nice channel column headers.
print('| {0:>4} | {1:>4} | {2:>4} | {3:>4} | {4:>4} | {5:>4} | {6:>4} | {7:>4} |'.format(*range(8)))
print('-' * 57)
# Main program loop.
while True:
    if (mcp.read_adc(0) >= 600):
        GPIO.output(pos_x, True)
    elif (mcp.read_adc(0) <= 400):
        GPIO.output(neg_x, True)
    else:
        GPIO.output(neg_x, False)
        GPIO.output(pos_x, False)

    if (mcp.read_adc(1) >= 600):
        GPIO.output(pos_y, True)
    elif (mcp.read_adc(1) <= 400):
        GPIO.output(neg_y, True)
    else:
        GPIO.output(neg_y, False)
        GPIO.output(pos_y, False)

    if (mcp.read_adc(2) > 50):
        GPIO.output(sel_but, True)
    else:
        GPIO.output(sel_but, False)
