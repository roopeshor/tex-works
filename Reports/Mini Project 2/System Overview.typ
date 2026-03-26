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
    column-gutter: 1cm,
    image("images/transceiver-ckt.svg"),
    image("images/transceiver-ckt.svg"),
  ),
  caption: [Circuit diagram]
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