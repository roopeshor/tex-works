#import "@preview/acrostiche:0.7.0": *
= Component Selection

The key components used are STM32F103 (C6T6 variant), and nRF24L01+. Other minor components used are listed in @cost-estimate

== STM32F103 <stm-board>

The STM32F103 is the main processing unit of each node in the network. It is based on the ARM Cortex-M3 architecture and is responsible for controlling all node operations, including packet creation, packet forwarding, routing logic, path recording, and communication with peripheral devices. The microcontroller offers sufficient processing speed, low power consumption, and multiple communication interfaces such as SPI and UART, which make it well suited for embedded wireless applications. In this project, the STM32F103 handles the software-defined mesh logic and manages the interaction with the nRF24L01+ transceiver.
The microcontroller has following key specifications:
- 16 KiB flash memory and 6 KiB #acs("SRAM").
- 72 MHz Clock frequency
- Supports 2.0 to 3.6V input
- Has one #acs("SPI"), one #acs("I2C"), 2 #acr("USART")
- 37 #acr("GPIO")


#figure(
  image("images/stm32.jpg", width: 10cm),
  caption: [STM32F103 development board]
)


There are many STM32 variants (such as F401) in market however we choose this particular model due to the requirements:
- Very low cost
- No need of floating point operations (hence not considering F401)
- Enough number of #acr("GPIO") pins for future expansion of peripherals.

However programming the board was not a easy task. ST Microelectronics recommends using *_STM32CubeIDE_* -- the official #acs("IDE") for STM boards -- for creating and flashing programs onto the development boards. The board we are currently using is unfortunately unsupported by the IDE. Hence the board was programmed using Arduino IDE by installing STM board package @stm-flasing and setting appropriate settings (shown in @fig:stm-settings in @sw-section) while flashing. The program was hence written in Arduino's C++ language.

== nRF24L01+

The nRF24L01+ module is used to establish wireless communication between nodes in the mesh network. It operates in the 2.4 GHz ISM band and supports low-power, short-range digital communication with good data transfer rates. The transceiver communicates with the STM32F103 through the SPI interface and is responsible for transmitting and receiving packets between neighboring nodes. In this project, the nRF24L01+ enables multi-hop communication through controlled flooding, allowing packets to propagate across the network while recording the relay path followed. The module has following specifications: @nRF-datasheet

- Very low standby current of 22μA
- Supports input voltage of 1.9 to 3.6V, (which can be powered by STM board itself). 
- 12 mA current consumption during operation. 
- Data rate of 250Kbps
- Data transfer through #acr("SPI")

#figure(
 image("images/nRF24.jpg", height: 4.5cm),
 caption: [nRF24L01+ and its pinout]
 
)
We considered other alternatives such as nRF24L01+PA+LNA version which has power amplifier for transmission and a low noise amplifier for receiver extending the #acr("LOS") communication range to 1km. However the module was five times expensive than the base model significantly rising the budget. Moreover due to its extensive range, it is not suitable for the demonstration of our network as we will have to setup large area for testing. Similarly LoRa modules were also not considered due to its wide range and high abstraction from hardware. 
FS1000A was another module taken for consideration for being inexpensive. But from our past experiences, the module is often unstable and has higher rate of failure. Moreover these modules have poor manufacturing quality.

The nRF24L01 was chosen considering the drawbacks of other alternatives.

== Project cost <cost-estimate>

Although a breadboard was used for a single node project, it was solely ment for testing purpose, the total cost listed covers prototype board can in place of breadboard.
#figure(
  caption: [Project cost],
  table(
    columns: (1fr, .4fr, .4fr, .4fr),
    inset: 10pt,
    table.header([*Item*], [*Unit Cost*], [*Units*], [*Total*]),
    [STM32F103], [90], [4], [360],
    [nRF24L01+], [60], [4], [240],
    [LED], [2], [4], [8],
    [Resistors], [1], [4], [4],
    [Prototype board], [60], [1], [60],
    [Push button], [5], [1], [5],
    [18650 battery], [60], [2], [120],
    table.cell(colspan: 3)[*Total*], [*₹797*],
  ),
)
