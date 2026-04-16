#import "@preview/algorithmic:1.0.7"
#import "@preview/acrostiche:0.7.0": *
#import "@preview/wrap-it:0.1.1": wrap-content
#import algorithmic: algorithm-figure, style-algorithm
#show: style-algorithm

= System Overview

The system is made with portability in mind. The development board and nRF module are connected via berg strips soldered on a small section of prototype board. The algorithm is custom developed based on already available Controlled flooding algorithms @controlled-flooding @dapf

== Block diagram
The operation of the system is as following:
+ User sends SOS message
+ Transmitter transmits 
+ Routing network routs the packet
+ SOS station receives it. (only if it is ment for this receiver)
+ Sends a ACK message through netwrok.
+ On successfull reception, an appropriate LED is turned on.

#context {
  figure(
		caption: [Block diagram],
    image(
      "images/block.svg",
      width: page.width - page.margin.left - page.margin.right,
    ),
  )
}
== Hardware
The nRF module is interfaced to STM board via #acr("SPI") through hardware #acr("SPI") peripheral of STM32. An indicator LED used to indicate the status of transmission is attached to `PB11` pin of STM. Built-in LED in the development board -- which is accessed by `PC13` is used to indicate reception of radio packet reducing the need for additional LED and current limiting resistor.

#figure(
  grid(
    columns: 2,
    column-gutter: .5cm,
    row-gutter: 5pt,
    image("images/transmitter.svg", height: 6cm), image("images/transceiver-ckt.svg", height: 6cm),
    [Transmitter], [Receiver],
  ),
  gap: 25pt,
  caption: [Transmitter and Receiver circuit diagrams],
)
For visual feedback green and blue LEDs (`D1`) where used along with a 1k$Omega$ resistor (`R1`) for current limiting. For initiating the transmission of SOS signal, a push button (`SW1`) is used which is connected to ground via 1k$Omega$ resistor (`R2`). Choice of 1k$Omega$ is well-satisfies maximum I/O source/sink current capability of STM32 which is 25mA @stm-datasheet

While creating finalized prototype, we soldered female berg strip onto prototype board. For transmitter, we were experimenting various configurations hence it was not soldered in a prototype board.

The relay nodes are powered by a 3.7V 18650 Li-ion battery with 2600mAh capacity. The battery has enough capacity to run the nodes continuously for weeks. To use the battery in the nodes, usually a voltage regulator is needed. However the onboard voltage regulator in STM32 development board which has a high drop off voltage of 1V to 1.2V. Hence applying battery directly to 5V pin of board will result in very reduced output voltage. For demonstration purpose, we decided to use partially charged battery with voltage close to 3.4 to 3.5V and connect it directly to 3.3V. The absolute voltage ratings are still satisfied as the maximum voltage for both STM32 IC and nRF module is 3.6V.
#figure(
  grid(
    columns: 2,
    gutter: 5mm,
    image("images/Tx_final.jpg"), image("images/Rx_final.jpg"),
  ),
  caption: [Transmitter (left) and receiver(right) modules],
)

== Software <sw-section>

This section outlines software part of the project including the custom algorithm for controlled flooding.
#let fig = [#figure(
  image("images/SKU-83581.png", width: 5cm),
  caption: [ST Link V2],
)<stv2>]
#let body = [
  As discussed previously in @stm-board, the program for STM had to be written in Arduino C++ language and was compiled and uploaded via ST-link/V2 @stm-flasing. The wiring scheme is shown in @fig:stm-connection which was taken from @stm-connection. However other variant like ST-link V2 (@stv2) can be used and works in similar way
]
#wrap-content(fig, body, align: top + right)

#figure(
  image("images/stm-to-stlink.png", height: 5cm),
  caption: [Connecting STM32 with ST-Link/V2.],
)<fig:stm-connection>

While setting up the Arduino IDE for development few flash settings had to be adjusted as shown in @fig:stm-settings
The USART support should be set to "Enabled" and USB support option should be set to "CDC" in order for the device to be listed as a serial device and hence can be communicated via programs like Minicom
#figure(
  image("images/stm-flash-settings.png", height: 10cm),
  caption: [Settings to apply while flashing the program to STM32],
) <fig:stm-settings>

Each nodes has its own node ID. During the prototyping stage these IDs are hard coded in the program. Hence while flashing the program, this ID was changed for each node. However this can be simplified by adding a #acr("DIP") switch to each node,and setting the address on the fly.

The details of program and algorithm are discussed in following sections.

=== Transmitter

#show figure: set block(spacing: 20pt)
The transmitter node is initialized by configuring the button and LED GPIO pins. The LED is set to indicate an idle state, and the radio module is checked for proper operation. If the radio is not responding, the system enters an infinite loop to prevent faulty execution. Once verified, the radio is set to listening mode, preparing it for communication.

#algorithm-figure(
  "Transmitter Initialization",
  {
    import algorithmic: *
    Line[Init Button and LED GPIO pins]
    Assign[`LED_SEND`][`HIGH`]
    If([Radio not responding], {
      Line[(Infinite loop)]
    })
    Line[Set radio in listening mode]
  },
)

When the SOS button is pressed and the system is not waiting for an acknowledgment, a new transmission is initiated. The LED is turned on to indicate active transmission, and a packet is constructed in memory. A flag (`waitingForACK`) is set to indicate that the node is now expecting an acknowledgment preventing duplicate transmissions. The current time is stored (`lastSOS_Sent`) to track when the packet was sent. Additionally, the message ID (`msgID`) is incremented to uniquely identify each transmission. In the program a short delay of 500ms is added to prevent rapid repeated transmissions which can overload the network.

#algorithm-figure(
  "SOS Event and Transmission Start",
  {
    import algorithmic: *
    If([`SOS BTN` pressed *and* not waiting For ACK], {
      Assign[`LED_SEND`][`LOW`]
      Line[*Rebuild* `pkt` memory buffer]
      Line[*Transmit* `pkt`]
      Assign[`waitingForACK`][`1`]
      Assign[`lastSOS_Sent`][`currentTime()`]
      Assign[`msgID`][`msgID` + 1]
      Line[Delay 500ms]
    })
  },
)

When the node is awaiting acknowledgment and it receives a packet, it is checked for validity, duplication, or relevance. If the packet has already been seen or is not an SOS signal, it is discarded. If the packet reaches its intended destination, the system blinks an LED to indicate reception and stores its signature to prevent reprocessing. Expired packets are also discarded to maintain efficiency.


#algorithm-figure(
  "ACK Reception",
  {
    import algorithmic: *
    If([`waitingForACK` *and* payload received], {
      Assign[`pkt`][Received payload]
      If([`pkt.msg_type` != `SOS` *or* `pkt` already seen], {
        Break
      })

      If([`pkt` destination = This Node], {
        Line[*Blink* Indications]
        Line[*Save* packet signature]
        Break
      })

      If([`pkt` expired], {
        Line[*Save* packet signature]
        Break
      })
    })
  },
)

The transmitter can stay in listening mode while waiting for acknowledge signal only for 3 seconds. If no acknowledge is received the system goes in normal state. This delay also prevents the spamming of network with repeated button presses.

=== Receiver and Repeater
The receiver and repeater nodes shares the same program and logic. Similar to transmitter node, the receiver node is initialized by configuring the required LED GPIO pins, used for indicating reception and transmission activity. The radio module is then initialized and checked for proper operation; if it fails, the system halts to avoid unreliable communication. Once verified, the radio is configured with the appropriate address and settings for receiving data. Finally, the node is set to listening mode, allowing it to continuously monitor for incoming packets.
#algorithm-figure(
  "Receiver Initialization",
  {
    import algorithmic: *
    Line[Init LED GPIO pins]
    Assign[`LED_SEND`][`HIGH`]
    If([Radio not responding], {
      Line[(Infinite loop)]
    })
    Line[Set radio in listening mode]
  },
)

When a payload is received, the packet is first read and checked against previously seen packets to avoid duplication and unnecessary retransmission. If the packet has already been processed, it is immediately discarded. The algorithm also checks whether the packet has expired (based on hop limit -- `ttl` field of packet); expired packets are ignored to prevent network congestion. After validating the packet, the node appends its own ID to the packet path, allowing tracking of the route taken. If the current node is the destination, it indicates successful reception by blinking the RX LED, stores the packet signature to avoid future duplicates, and constructs an acknowledgment (ACK) packet addressed to the original sender. Regardless of whether it is the destination or an intermediate node, the packet’s signature is saved to prevent reprocessing. Finally, the packet is transmitted further in the network, and the TX LED blinks to indicate forwarding activity.


#algorithm-figure(
  "Handle arrival of new package",
  {
    import algorithmic: *
    If([Payload Received], {
      Assign[`pkt`][Receive Packet]
      If([`pkt` already seen], {
        Break
      })

      If([`pkt` expired], {
        Line[*Save* packet signature]
        Break
      })
      Line[*Append* This node's ID to `pkt.path`]
      If([`pkt` destination = This Node], {
        Line[*Blink* RX LED]
        Line[*Save* packet signature]
        Line[*Construct* ACK packet using `pkt` buffer with `dest` = original sender]
      })


      Line[*Save* `pkt`'s packet signature]
      Line[*Transmit* `pkt`]
      Line[*Blink* TX LED]
    })
  },
)

=== Packet structure
nRF24L01 Accepts a 32 byte sized memory chunk for transmission. The packet structure in the current protocol implementation is as following:
```
packet = {
    byte msgID;
    byte msg_type;
    byte ttl;
    byte src;
    byte dest;
    byte path[27];
}```

Description of each fields are following:
+ *`msgID`*: a byte long ID used to identify the message sent by a node. By design 256 unique messages are possible. Every node keeps a internal variable to keep track of the number of messages sent by it, which after each transmission increments it.
+ *`msg_type`*: indicates whether packet is a SOS (value = 0) or ACK (value = 1)
+ *`ttl`*: Time to Live. Specifies the maximum number of hops allowed for a packet.
+ *`src`*: Node ID of the originating node.
+ *`dest`*; Node ID of the final destination node.
+ *`path`*: A stack that stores all the nodes through which the packet was routed. When a node receives a packet and decides to forward it, the node appends its node ID to this field. Hence at the destination node, the receiver can know which node was nearest to the transmitter. If all relay nodes are geolocated, then the location of transmitter can be estimated from this field.
