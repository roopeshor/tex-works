#set page(paper: "a4", margin: (x: 2cm, y: 2.3cm))
#set par(justify: true)
#set text(size: 12pt)
#set columns(gutter: 1cm)

#place(top + center, float: true, scope: "parent")[
  = Experiment 6(a): Directional Coupler
	#v(20pt)
]


== Aim
To study the characteristics of a directional coupler and to determine Coupling factor, Directivity, Isolation, Insertion loss
== Software Required
- Klystron power supply
- Klystron tube with Klystron mounts
- Isolator
- Variable attenuator
- Frequency meter
- Detector mount
- DSO
- Directional coupler
- Matched load
- BNC cable

== Theory:
A directional coupler is a passive microwave device used to sample a small portion of power flowing in a
transmission line in a specific direction while isolating power flowing in the opposite direction.
It has four ports: Port 1 → Input port , Port 2 → Through port , Port 3 → Coupled port , Port 4 → Isolated
port.When power is applied at Port 1: Most power appears at Port 2 A small fraction appears at Port
3.Ideally no power appears at Port 4.Only power traveling in one direction is coupled to the coupled port;
ideally, no power appears at the isolated port.
Let:
- $V_1$ = Voltage at Port 1 (input)
- $V_2$ = Voltage at Port 2 (through)
- $V_3$ = Voltage at Port 3 (coupled)
- $V_4$ = Voltage at Port 4 (isolated)

+ Coupling factor (C) $ C = 20log_10 (V_1/V_3) "dB" $
+ Isolation (I) $ I = 20log_10 (V_1/V_4) "dB" $
+ Directivity (D) $ D = 20log_10 (V_3/V_4)= I-C "dB" $
+ Insertion loss (IL) $ "IL" = 20log_10 (V_1/V_2) "dB" $
== Procedure
+ Set up the components and equipment’s as shown in figure.
+ Set Mode selector switch to AM-Mode position with AM amplitude and AM frequency knob at mid position.
+ Keep beam voltage control knob fully anticlockwise(minimum) and reflector voltage knob to fully clockwise(Maximum).
+ Place the cooling fan in front of the klystron tube and switch ON the fan to avoid overheating.
+ Adjust the repeller voltage until a clear square wave is observed on the DSO
+ Measure the input voltage by disconnecting the Directional coupler and Connect the detector mount
+ directly to the output of the microwave bench. Note the voltage indicated on the DSO. This voltage is taken as the input reference voltage $V_1$.
+ Connect the Directional Coupler to the setup.
+ Connect the detector mount to one port and terminate the other port with a matched load.
+ Measure the output voltage on the DSO . This voltage is taken as output voltage 𝑉2.
+ Interchange the position of the matched load and detector mount.
+ Note the change in DSO reading and calculate coupling factor, isolation Loss, Directivity, Insertion Loss using voltage formulas.

== Result
The directional coupler characteristics were measured, and the values of coupling factor, isolation, directivity, and insertion loss were determined. The coupler was found to couple power predominantly in one direction, confirming its directional behaviour.

#pagebreak()

== Setup
#figure(
	image("1.png")
)

== Observation table

#table(
	columns: 5,
	inset: 15pt,
	 align: left + horizon,
  table.header([*Input\ port*], [*Input\ Voltage*], [*Output\ port*], [*Output\ Voltage*], [*Parameters*]),
	table.cell(rowspan: 2)[Port 1], table.cell(rowspan: 2)[#h(2cm)], [Port 2], [V2 = #h(1.5cm)], [$C = 20log_10 frac(V_1,V_3, style: "skewed")= $ #h(1.3cm)],
	[Port 3], [V3 = ], [$I = 20log_10 frac(V_1,V_4, style: "skewed") = $],
	table.cell(rowspan: 2)[Port 2], table.cell(rowspan: 2)[ ], [Port 3], [V4 = ], [$D = 20log_10 frac(V_3,V_4, style: "skewed") =$],
	[Port 1], [V4 = ], [$"IL" = 20log_10 frac(V_1,V_2, style: "skewed") = $],
)