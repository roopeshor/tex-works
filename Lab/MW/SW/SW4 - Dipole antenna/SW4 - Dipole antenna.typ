#set page(columns: 2, paper: "a4", margin: (x: 1.5cm, y: 2.3cm))
#set par(justify: true)
#set text(size: 12pt)
#set columns(gutter: 1cm)

#place(top + center, float: true, scope: "parent")[
  = Experiment 4: Dipole Antenna Design Using HFSS
  #v(20pt)
]


== Aim
To design and simulate a dipole antenna using
ANSYS HFSS and to study its S-parameter
characteristics, radiation pattern, gain, and electric
field distribution at an operating frequency of 5
GHz..
== Software Required
- ANSYS Electronics Desktop (HFSS)
== Theory:
A dipole antenna is one of the simplest and most
widely used antennas in wireless communication
systems. It consists of two equal-length conductive
arms placed collinearly and fed at the center by a
balanced source. The most common form is the
half-wave dipole, whose total length is
approximately $λ/2$, where $λ$ is the wavelength of
operation.

When an alternating current is applied at the feed
point, currents flow in opposite directions in the
two arms of the dipole. These time-varying currents
produce electromagnetic radiation. The maximum
current occurs at the center of the dipole and
gradually decreases to zero at the ends, while the
voltage is minimum at the center and maximum at
the ends.

The dipole antenna radiates maximum power in the
plane perpendicular to its axis and minimum power
along the axis of the antenna. Hence, its radiation
pattern is bidirectional and resembles a figure-of-
eight in the E-plane. The radiation is linearly
polarized, and the polarization depends on the
orientation of the dipole.

#colbreak()

== Procedure
#set enum(spacing: 15pt)
#set list(spacing: 10pt)
#let lstint = 20pt
+ #strong[#strong[Insert HFSS]]
  - Open ANSYS HFSS
  - New Project → Insert HFSS Design
+ #strong[#strong[Draw Dipole (Copper Cylinder)]]
  - Draw → Cylinder
  - Material: #strong[Copper]
  - Axis: Z
  - Radius: 1mm
  - Height: 12mm
  - Position: (0, 0, +0.5mm)
  - No. of segments: 0
  - Fit All (Ctrl +D)
+ #strong[#strong[Duplicate for Second Arm]]
  - Duplicate the cylinder
  - Rotate about X-axis = 180°
  - OK
+ #strong[#strong[Dipole Formation]]
  - Select both cylinders
  - Ensure double arm dipole
  - Unite
  - Change color
  - Set Transparency = 0.6
+ #strong[#strong[Feed Creation]]
  - Select YZ Plane
  - Draw → Rectangle
  - Zoom in and rotate
  - Rectangle name: Rectangle1 (Feed)
  Rectangle Properties: #list(indent: lstint, [Position: $(0, -1, -0.5)$], [Axis: X], [Y-size: 2mm], [Z-size: 1mm])

  (feed be placed at the center of the dipole)
+ #strong[Assign Excitation]
  - Select Rectangle1
  - Excitations → Assign → Lumped Port
  - Click New Line
  - Assign reference conductor
  - OK
  (Dipole feed gap is very small and not a transmission line-hence lumped port is used)
+ #strong[Radiation Box]
  - Select XY Plane
  - Create → Box
  - Dimensions: #list(indent: lstint, [X = 40], [Y = 40], [Z = 40])
  - Position: $(-20, -20, -20)$
  - Set Transparency = $0.8$
  - Assign Radiation Boundary
+ #strong[Analysis Setup]
  - Analysis $->$ Add Solution Setup
  - Frequency = 5 GHz
+ #strong[Frequency Sweep]
  - Sweep Type: Fast
  - Start: 5 GHz
  - Stop: 10 GHz
  - Points: 451
+ #strong[Far Field Setup]
  - Results → Create Far Fields Report
  - Select Radiation
  - Insert Far Field Setup
  - Magnitude & Phase
  Angular Values: #list(
    indent: lstint,
    [Phi ($φ$): -180° to +180°, Step = 2°],
    [Theta ($θ$): -180° to +180°, Step = 2°],
  )
+ #strong[Visibility OFF]
  - Turn axis / grid visibility OFF
  - Used for clear plots
+ #strong[Field Overlay]
  - Results → Field Overlay
  - Plot Fields → E
  - Shows electric field distribution
+ #strong[Validation & Analysis]
  - HFSS → Validate Design
  - Click Analyze All
+ #strong[S-Parameter Plot]
  - Results → Create Modal Solution Data Report
  - Rectangular Plot
  - $S(1,1)$ in dB
  - Add marker if required
+ #strong[3D Far Field Plot]
  - Results → Create Far Field Report
  - 3D Polar Plot
  - Quantity: Gain (Total)
  - Units: dB
+ #strong[Radiation Pattern]
  - Results → Create Far Field Report
  - Radiation Pattern
  - Gain (Total) in dB
+ #strong[E-Field Animation]
  - Results → Animate Fields
  - Select #strong[Mag_E]
  - Observe radiation behavior

== Result
A dipole antenna was designed and
simulated in HFSS at 5 GHz. The S11 plot shows
good impedance matching, and the radiation
pattern obtained is bidirectional, confirming
proper dipole antenna operation.
