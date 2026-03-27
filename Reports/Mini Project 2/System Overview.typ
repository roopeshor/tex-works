#import "@preview/algorithmic:1.0.7"
#import "@preview/acrostiche:0.7.0": *
#import algorithmic: style-algorithm, algorithm-figure
#show: style-algorithm

= System Overview

The system is made with portability in mind. The development board and nRF module are inserted onto header pins soldered on a small section of prototype board. The algorithm is custom developed based on already available Controlled flooding algorithms @controlled-flooding @dapf
== Hardware 
The nRF module is interfaced to STM board via #acr("SPI") through hardware #acr("SPI") peripheral of STM32. An indicator LED used to indicate the status of transmission is attached to `PB11` pin of STM. Built-in LED in the development board -- which is accessed by `PC13` is used to indicate reception of radio packet reducing the need for additional LED and current limiting resistor.
#figure(
  grid(
    columns: 2,
    column-gutter: .5cm,
    row-gutter: 5pt,
    image("images/transmitter.svg", height: 6cm),
    image("images/transceiver-ckt.svg", height: 6cm),
    [Transmitter],
    [Receiver]
  ),
  gap: 25pt,
  caption: [Transmitter and Receiver circuit diagrams]
)

While implementing, we soldered female berg strip onto prototype board. For transmitter, we were experimenting various configurations hence it was not soldered in a prototype board.

#figure(
  grid(
    columns: 2,
    gutter: 5mm,
    image("images/Tx_final.jpg"),
    image("images/Rx_final.jpg"),
  ),
  caption: [Transmitter (left) and receiver(right) modules]
)

== Software <sw-section>
This section outlines the algorithm of custom controlled flooding method. @routing


While setting up the Arduino IDE for development few flash settings had to be adjusted as shown in @fig:stm-settings

#figure(
  image("images/stm-flash-settings.png", height: 10cm),
  caption: [Settings to apply while flashing the program to STM32]
) <fig:stm-settings>


=== Transmitter
#import "@preview/algorithmic:1.0.7"
#import algorithmic: style-algorithm, algorithm-figure
#show: style-algorithm

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
  }
)

The transmitter node is initialized by configuring the button and LED GPIO pins. The LED is set to indicate an idle state, and the radio module is checked for proper operation. If the radio is not responding, the system enters an infinite loop to prevent faulty execution. Once verified, the radio is set to listening mode, preparing it for communication.

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
  }
)

When the SOS button is pressed and the system is not waiting for an acknowledgment, a new transmission is initiated. The LED is turned on to indicate active transmission, and a packet is constructed in memory. A flag (`waitingForACK`) is set to indicate that the node is now expecting an acknowledgment preventing duplicate transmissions. The current time is stored (`lastSOS_Sent`) to track when the packet was sent. Additionally, the message ID (`msgID`) is incremented to uniquely identify each transmission. A short delay is added to prevent rapid repeated transmissions and avoid confusion with previously sent packets.

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
  }
)

When the node is awaiting acknowledgment and it receives a packet, it is checked for validity, duplication, or relevance. If the packet has already been seen or is not an SOS signal, it is discarded. If the packet reaches its intended destination, the system blinks an LED to indicate reception and stores its signature to prevent reprocessing. Expired packets are also discarded to maintain efficiency.

=== Receiver

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
  }
)

The receiver node is initialized by configuring the required LED GPIO pins, used for indicating reception and transmission activity. The radio module is then initialized and checked for proper operation; if it fails, the system halts to avoid unreliable communication. Once verified, the radio is configured with the appropriate address and settings for receiving data. Finally, the node is set to listening mode, allowing it to continuously monitor for incoming packets.

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
  }
)

When a payload is received, the packet is first read and checked against previously seen packets to avoid duplication and unnecessary retransmission. If the packet has already been processed, it is immediately discarded. The algorithm also checks whether the packet has expired (based on hop limit); expired packets are ignored to prevent network congestion. After validating the packet, the node appends its own ID to the packet path, allowing tracking of the route taken. If the current node is the destination, it indicates successful reception by blinking the RX LED, stores the packet signature to avoid future duplicates, and constructs an acknowledgment (ACK) packet addressed to the original sender. Regardless of whether it is the destination or an intermediate node, the packet’s signature is saved to prevent reprocessing. Finally, the packet is transmitted further in the network, and the TX LED blinks to indicate forwarding activity.

