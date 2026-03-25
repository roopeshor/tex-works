#import "@preview/algorithmic:1.0.7"
#import algorithmic: style-algorithm, algorithm-figure
#show: style-algorithm

= System Overview

== Working
Controlled flooding @controlled-flooding

== Algorithm
This section outlines the algorithm of custom controlled flooding method. @routing
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