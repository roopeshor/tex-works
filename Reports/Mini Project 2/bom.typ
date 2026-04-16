= Bill of materials <cost-estimate>

Although a breadboard was used for a single node project, it was solely ment for testing purpose.
#figure(
  caption: [Bill of materials],
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
    [Breadboard 400 points], [35], [1], [35],
    table.cell(colspan: 3)[*Total*], [*₹832*],
  ),
)
