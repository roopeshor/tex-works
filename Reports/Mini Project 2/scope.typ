#import "@preview/acrostiche:0.7.0": *
= Future Scope

+ *Increasing Bandwidth / High-Volume Data:*
  
  The current system is limited by the 32-byte payload constraint of the nRF24L01+ module. This can be improved using techniques such as packet fragmentation, where large data is split into smaller packets and reassembled at the destination. Pipelining and efficient encoding methods can further enhance throughput. Alternatively an entirely different radio hardware can be incorporated instead which has higher payload capacity. These improvements would enable transmission of more complex data such as sensor outputs beyond simple control signals.

+ *Ad-hoc Networking:*

  The system can be extended into a full Ad-hoc network where nodes dynamically organize without centralized control. By implementing routing protocols like #acf("AODV"), the network can determine optimal paths automatically which is useful for high data bandwidth domains. This would allow the system to adapt to node failures and topology changes. Such enhancements improve scalability and robustness.

+ *#acrfpl("VANET"):*

  The project can be extended to #acp("VANET") where vehicles communicate in real time. Multi-hop communication enables messages such as accident alerts or traffic updates to propagate across vehicles. Additional features like #acs("GNSS") integration and low-latency communication would enhance performance. This can contribute to safer and more efficient transportation systems.

+ *#acfp("WSN"):*

  The system is well-suited for Wireless Sensor Network applications in remote environments. Sensor nodes can collect data such as temperature or smoke levels and transmit it across multiple hops. This is useful in applications like wildfire detection and environmental monitoring. Energy-efficient communication strategies can further improve long-term deployment.

+ *#acr("IoT") and Smart Systems:*

  The system can be applied into #acr("IoT") applications for smart environments. Devices can communicate over a decentralized mesh network for tasks like smart agriculture or home automation. Data collected from multiple nodes can be used for monitoring and decision-making. Future integration with cloud platforms can enable remote access and analytics.