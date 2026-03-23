#set page(paper: "a4", margin: (x: 2cm, y: 2.3cm))
#set par(justify: true)
#set text(size: 12pt)
#set columns(gutter: 1cm)

#place(top + center, float: true, scope: "parent")[
  = Experiment 6(b):  Isolator
	#v(20pt)
]


== Aim
To study the characteristics of a microwave isolator and determine its insertion loss and isolation.
== Apparatus required:
- Klystron power supply
- Klystron tube with Klystron mounts
- Isolator
- Variable attenuator
- Frequency meter
- Detector mount
- DSO
- Isolator
- Matched load
== Theory:
An isolator is a non-reciprocal microwave device that allows electromagnetic waves to pass only in one
direction and provides high attenuation in the reverse direction.

=== Insertion Loss
Insertion loss is the ratio of input voltage to output voltage in the forward direction.
#rect()[$ "Insertion Loss(dB), IL"= 20log_10 (V_"in"/V_"out") $]

Indicates voltage drop when signal passes through the isolator
Lower value = better performance

=== Isolation
Isolation is the ratio of reverse-direction input voltage to the reverse-direction output voltage.
#rect()[$ "Isolation(dB), I"= 20log_10 (V_"reverse in"/V_"reverse out") $]
Measures how much the isolator suppresses voltage traveling backward
Higher value = better isolation

== Procedure
+ Set up the components and equipment's as shown in figure.
+ Set Mode selector switch to AM-Mode position with AM amplitude and AM frequency knob at mid position.
+ Keep beam voltage control knob fully anticlockwise(minimum) and reflector voltage knob to fully clockwise(Maximum).
+ Place the cooling fan in front of the klystron tube and switch ON the fan to avoid overheating.
+ Adjust the repeller voltage until a clear square wave is observed on the DSO
+ Measure the input voltage by disconnecting the Isolator and Connect the detector mount directly to the output of the microwave bench. Note the voltage indicated on the DSO. This voltage is taken as the input reference voltage $V_1$.
+ Connect the isolator between the microwave source and the detector mount, ensuring correct orientation (forward direction). Observe and note the voltage on the DSO. This voltage is taken as the forward output voltage ($V_2$).
+ Reverse the isolator orientation (interchange its input and output ports).Observe the reduced voltage indicated on the DSO. This voltage is taken as the reverse output voltage ($V_r$).
+ Calculate isolation Loss, Insertion Loss using voltage formulas

== Result
The characteristics of the microwave isolator were studied. It was observed that the isolator allows microwave power to pass in the forward direction with minimum insertion loss, while providing high attenuation in the reverse direction. Thus, the isolator exhibits non-reciprocal behaviour and effectively protects the microwave source from reflected power.

#pagebreak()

== Setup
#figure(
	image("6b.png")
)

== Observation table

#table(
	columns: 5,
	inset: 15pt,
	 align: left + horizon,
  table.header([*Input\ port*], [*Input\ Voltage $(V_1)$*], [*Output\ port*], [*Output\ Voltage*], [*Parameters*]),
	[Port 1], [#h(2cm)], [Port 2], [$V_2$ = #h(1.5cm)], [$"IL" = 20log_10 frac(V_1,V_2,style: "skewed") = $ #h(2cm)],
	[Port 2], [ ], [Port 1], [$V_r$ = ], [$I = 20log_10 frac(V_1,V_r,style: "skewed") = $],
)
