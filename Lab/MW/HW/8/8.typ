#set page(paper: "a4", margin: (x: 2cm, y: 2.3cm))
#set par(justify: true)
#set text(size: 12pt)
#set columns(gutter: 1cm)

#place(top + center, float: true, scope: "parent")[
  = Experiment 8: Measurement of Unknown Impedance using Slotted Line
  #v(20pt)
]


== Aim
To measure an unknown impedance using the slotted line method and Smith chart technique
== Apparatus required:
- Klystron Power Supply
- Klystron tube with Klystron mounts
- Isolator
- Variable attenuator
- Frequency meter
- Slotted section
- Tunable probe
- oscilloscope
- BNC cable
== Theory
When a load is connected to a transmission line, if the load impedance $Z_L$ is not equal to the characteristic impedance $Z_0$,
part of the incident wave is reflected back.The interference between incident and reflected waves forms standing waves.
==== Reflection Coefficient
$ Gamma = (Z_L - Z_0)/(Z_L + Z_0) $
==== Standing wave ratio (SWR):
$ S = V_max/V_min = (1+|Gamma|)/(1-|Gamma|) $
Hence
$ |Gamma| = (S-1)/(S+1) $

==== Guide Wavelength
Distance between two successive minima = $λ_g/2$
$ λ_g=2 times ("distance between two minima") $

==== Normalized Impedance
$ z_L = Z_L / Z_0 $
==== Actual load impedance
$ Z_L = Z_0 times z_L $

Smith chart is used to determine the normalized impedance graphically.

== Procedure
+ Set up the components and equipment's as shown in figure.
+ Set Mode selector switch to AM-Mode position with AM amplitude and AM frequency knob at mid position.
+ Keep beam voltage control knob fully anticlockwise(minimum) and reflector voltage knob to fully clockwise(Maximum).
+ Place the cooling fan in front of the klystron tube and switch ON the fan to avoid overheating.
+ Adjust the repeller voltage until a clear square wave is observed on the DSO
+ Move the control knob of the slotted line slowly from a minimum position. Observe the output on the Oscilloscope and note the distance at the point where a peak is achieved.
+ Record this position as $d_1$
+ Move to the next adjacent minimum position and record it as $d_2$. Repeat this procedure
+ Calculate $lambda_g$ : The distance between two successive minima is half the guide wavelength:
$ 𝜆_g = 2|d_1 - d_2| $
+ Replace matched load with unknown load. Again locate minima and Calculate SWR.
+ Calculate reflection coefficient. Plot on Smith chart.
+ Determine normalized impedance. Multiply by $Z_0$ to get load impedance.

== Result
The unknown load impedance was determined using the slotted line method and Smith chart technique.

#pagebreak()

== Setup
#figure(
  image("image.png"),
)
== Observation table

#v(10pt)
*Beam Voltage V = #h(2.2cm) Beam Current = #h(2.2cm) Repeller Voltage = #h(2.2cm)*

#table(
  columns: 5,
  inset: 10pt,
  align: (x, y) => {
    if y == 0 {
      // Target the second row (y is 0-indexed)
      center + horizon // Align content to the center horizontally and vertically
    } else {
      left + horizon // Use the default/outer alignment for other rows
    }
  },
  table.header(
    [*Parameters*],
    [*Shorted\ ($x_1$)\ [cm]*],
    [*Guided \
    Wavelength [cm] *],
    [*Horn\ antenna ($x_2$)\ [cm]*],
    [*Distance\ $D = x_2 - x_1$*],
  ),
  [$d_1$], [#h(1cm)], [], [#h(2cm)], [$D_1 =$],
  [$d_2$], [#h(1cm)], [$ lambda_(g 1) &= 2|d_2 - d_1| \ &= #h(2cm) $], [#h(2cm)], [$D_2 =$],
  [$d_3$], [#h(1cm)], [$ lambda_(g 2) &= 2|d_3 - d_2| \ &= #h(2cm) $], [#h(2cm)], [$D_3 =$],
  table.cell(colspan: 3)[$ lambda_g = (lambda_(g 1) + lambda_(g 2))/2 = #h(2cm) $],
  table.cell(colspan: 2)[$ D = (D_1 + D_2 + D_3)/3 = #h(2cm) $],
  table.cell(colspan: 3)[$ lambda_c = (2a)/m = #h(6cm) $ 
    (wave-guide inner broad dimension '$a$' will be
    around 22.86 mm for X band)
    $ lambda_0 = (lambda_g lambda_c)/sqrt(lambda_g^2 + lambda_c^2) = #h(5cm) $ \
    Characteristics impedance: $ Z_0 = 377/sqrt(1-(lambda_0/lambda_c)^2) = #h(2cm) $
  ],
  table.cell(colspan: 2)[Normalized distance: $ d=D/ λ_g = #h(2.3cm) $
    $ V_"max" = #h(4cm) $

    $ V_"min" = #h(4cm) $

    $ "VSWR" = V_"max"/V_"min" = #h(3cm) $\
    Using smith chart, normalized impedance $z_L$ = \
		#v(12pt)
  ],
  table.cell(colspan: 5)[
    $z_L$ = Normalized load \
    $𝑍_0$ = Characteristic impedance \
    $Z_L$ = Actual load impedance = $Z_0 z_L$ =
  ],
)
