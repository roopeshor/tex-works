= Components Used

List all components in various sub headings..

== STM32F103

The STM32F103 is the main processing unit of each node in the network. It is based on the ARM Cortex-M3 architecture and is responsible for controlling all node operations, including packet creation, packet forwarding, routing logic, path recording, and communication with peripheral devices. The micro-controller offers sufficient processing speed, low power consumption, and multiple communication interfaces such as SPI and UART, which make it well suited for embedded wireless applications. In this project, the STM32F103 handles the software-defined mesh logic and manages the interaction with the nRF24L01+ transceiver.

== nRF

The nRF24L01+ module is used to establish wireless communication between nodes in the mesh network. It operates in the 2.4 GHz ISM band and supports low-power, short-range digital communication with good data transfer rates. The transceiver communicates with the STM32F103 through the SPI interface and is responsible for transmitting and receiving packets between neighboring nodes. In this project, the nRF24L01+ enables multi-hop communication through controlled flooding, allowing packets to propagate across the network while recording the relay path followed. Its low cost, compact size, and ease of integration make it an ideal choice.

== Cost estimate

get a rough estimate of project.

#figure(
  caption: [Cost estimate],
  table(
    columns: (1fr, .4fr, .4fr),
    inset: 10pt,
    table.header([*Item*], [*Unit Cost*], [*Total*]),
    [STM32], [90], [450],
    [nRF], [60], [300],
    [add more components],[], [],
    table.cell(colspan: 2)[*Total*], [*750*],
  ),
)
