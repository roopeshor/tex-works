= Results and Discussion

#figure(
  grid(
    columns: 2,
    gutter: 5mm,
    image("images/Tx_final.jpg"),
    image("images/Rx_final.jpg"),
  ),
  caption: [Transmitter (left) and receiver(right) modules]
)

== Latency Measure

#figure(
  image("images/latency-direct.png", width: 10cm),
  caption: [Round trip Transmission delay in direct communication]
)

#figure(
  caption: "Latency for direct communication",
  table(
    align: center+horizon,
    inset: 9pt,
    columns: 10,
    [*Latency\
    ($mu s$)*], [1301], [1306], [1312], [1304], [1304], [1304], [1305], [1304], [1304],
    [*Average*],table.cell(colspan: 9)[*1304$mu s$*]
  )
)

#figure(
 caption: "Latency for 1-hop communication",
  table(
  columns: 5,
  align: center+horizon,
  inset: 12pt,
  [*Latency($mu s$)*], [32198], [32210], [32023], [32034],
  [*Average*],table.cell(colspan: 4)[*32116
$mu s$*]
) 
)
== limitations
The physical RF layer of this prototype is powered by the standard nRF24L01+ transceiver (without the external Power Amplifier and Low Noise Amplifier stages). While this choice keeps the prototype highly cost-effective and energy-efficient, it introduces specific physical and programmatic limitations:
- Range Constraints: Without a PA+LNA, the transmission range of the standard nRF24L01+ is strictly limited (typically 10 to 30 meters depending on obstacles). In a real forest deployment, RF absorption by trees would further reduce this range, necessitating a higher density of relay nodes.
- MAC-Layer Abstraction: The nRF24L01+ chip features a built-in hardware protocol called Enhanced ShockBurst (ESB). ESB automatically handles hardware-level ACKs and auto-retransmissions (e.g., automatically resending a failed packet up to 3 times, or up to 15 times depending on register settings). While convenient for simple point-to-point links, this hardware abstraction removes granular software control from the developer. It makes it difficult to implement precise, custom collision-avoidance algorithms at the MAC (Media Access Control) layer, as the hardware dictates the timing of the retransmissions independent of the STM32's software mesh logic.