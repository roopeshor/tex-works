#set page(columns: 2, paper: "a4", margin: (x: 1.5cm, y: 2.3cm))
#set par(justify: true)
#set text(size: 12pt)
#set columns(gutter: 1cm)
#set enum(spacing: 15pt)
#set list(spacing: 10pt)
#let lstint = 20pt

#place(top + center, float: true, scope: "parent")[
  = Experiment 5: Microstrip Patch Antenna Using HFSS
  #v(20pt)
]

== Aim
To design and simulate a rectangular inset-fed microstrip patch antenna using ANSYS HFSS and to obtain its S-parameters, radiation pattern, and electric field distribution at an operating frequency of 2.4 GHz.
== Software Used
- ANSYS HFSS (High Frequency Structure Simulator)
== Specifications

#table(
  columns: 2,
  stroke: none,
  row-gutter: 2pt,
  table.header([*Parameter*], [*Value*]),
  [Substrate Material], [FR4 Epoxy],
  [Dielectric Constant ($epsilon_r$)], [4.4],
  [Substrate Thickness ($h$)], [1.6 mm],
  [Ground Plane Size], [60 mm $times$ 60 mm],
  [Patch Length ($L$)], [29.4 mm],
  [Patch Width ($W$)], [38 mm],
  [Feed Type], [Inset Microstrip Feed],
  [Feed Impedance], [50 Ω],
)
== Theory
A microstrip patch antenna consists of a conducting patch printed on a dielectric substrate backed by a ground plane. It is widely used due to its low profile, light weight, low fabrication cost, and ease of integration.

The antenna resonates when the patch length is approximately half of the guided wavelength. The resonant frequency is approximately given by:

$ f_r = c/(2L sqrt(epsilon_"eff")) $

#strong[Where]:
- c = speed of light
- L = effective patch length
- $ε_"eff"$ = effective dielectric constant

The #strong[patch width (W)] is calculated using the standard
design formula:

$ W = c/(2f_r) sqrt(2/(epsilon_r + 1)) $

#strong[Where]:
- c = Speed of light = $3 times 10^8$ m/s
- $f_r$= Resonant frequency
- $epsilon_r$ = Dielectric constant of substrate

Inset feeding is used for impedance matching to achieve 50 Ω input impedance.

#figure(
  image(
    "Prof. Shiva panchakshari T G - 2 4GHz Microstrip patch antenna design using HFSS [Y_Ytzgt-2iw - 1006x566 - 0m01s].png",
  ),
)

== Procedure:
+ #strong[Insert HFSS Design]
  - Open ANSYS HFSS
  - New project - Insert new HFSS design
+ #strong[Create Ground Plane]
  - Draw → Rectangle
  - Name: Ground_Plane
  - Axis: Z
  - X size = 60 mm
  - Y size = 60 mm
  - Position: (-60/2 , -60/2 , 0)
+ #strong[Create Substrate]
  - Draw → Box
  - Name: Substrate
  - Material: FR4 Epoxy
  - Position: (-30 , -30 , 0)
  - Size:
    - X = 60 mm
    - Y = 60 mm
    - Z = 1.6 mm (thickness)
+ #strong[Create Patch]
  - Draw → Rectangle
  - Name: Patch
  - Position: (-38/2 , -29.4/2 , 1.6)
  - Size:
    - X = 38 mm
    Y = 29.4 mm
  (placed on top of substrate at Z = 1.6 mm)
+ #strong[Create Inset Feed (for impedance matching)]
  - Draw small rectangular cut:
    - Name: Cut
    - Position: (-5/2 , -29.4/2 , 1.6)
    - Size: X = 5 mm Y = 9.5 mm
  - Subtract Cut from Patch
    - Select: #strong[Patch + Cut]
    - Modeler → Boolean → Subtract
    - Blank part = Patch
    - Tool part = Cut
+ #strong[Create Feed Line]
  - Draw rectangle:
    - Name: Feed_Line
    - Width ≈ 3 mm
    - Length ≈ 30 mm
    - Position: (-3/2 , -30 , 1.6)
  - Unite #strong[Patch + Feed Line]
    Modeler → Boolean → Unite
+ #strong[Assign Excitation]
  - Draw rectangle on ZX plane at feed end:
  - Name: Port
    - Assign → Lumped Port
    - Impedance = 50 Ω
    - Integration line: bottom → top
+ #strong[Assign Perfect E Boundary]
  - Select:
    - Ground plane
    - Patch
    - Feed line
  - Assign → Perfect E
+ #strong[Create Radiation Box]
  - Draw Box:
    - Size: 80 mm × 80 mm × 40 mm
    - Material: Air
  - Assign Boundary → Radiation
+ #strong[Analysis Setup]
  - HFSS → Analysis Setup → Add Solution
    - Frequency = 2.4306 GHz
    - Max delta S = 0.02
    - Max passes = 15 to 20
  - Add Frequency Sweep:
    - Type: Interpolating
    - Start: 1 GHz Stop: 4 GHz
    - Step: 0.01 GHz
+ #strong[Validate & Analyze]
  - HFSS → Validate
    Analyze All
+ #strong[Results]
	#set enum(numbering: n => strong[12.#n])
  + #strong[S-Parameter Plot (Return Loss)]
    - Go to Results → Create Modal Solution Data Report → Rectangular Plot
      - Select: $S(1,1)$
      - Format: dB
      - Click New Report
    - Add Marker:
    - Right click on graph → Add Marker
    - Check resonant frequency ($f_r$)
    Note: Return loss (should be < -10 dB)
  + #strong[Radiation Pattern]
    - Radiation Setup (Far Field)
    - Insert Far Field Setup:
      Radiation → Insert Far Field Setup → Infinite Sphere
    - Set: #table(
        columns: 2,
        stroke: none,
        table.header([*Parameter*], [*Value*]),
        [Phi start], [0°],
        [Phi stop], [360°],
        [Theta start], [0°],
        [Theta stop], [180°],
        [Step size], [10°],
      )
    - Click OK.
  + #strong[3D Radiation Pattern]
    - Results → Create Far Field Report → 3D Polar Plot
    - Select: #strong[dB(RealizedGainTotal)]
    - Click New Report
    - Modify Scale (Optional but Important)
    - In 3D plot window:
      Modify scale
      Use limits:
      - Max = 8 or 10 dB (depending on gain)
      - Min = 0 dB
  + #strong[2D Radiation Pattern]
    - Results → Create Far Field Report → Rectangular Plot
    - Choose: #strong[dB(RealizedGainTotal)]
    - Then set cuts:
    - #strong[For E-plane]:
      - Phi = 0°
      - Theta = 0° to 180°
    - #strong[For H-plane]:
      - Phi = 90°
      - Theta = 0° to 180°
    - Click New Report.

  + #strong[Electric Field Distribution]
		- Plotting E-Field
		- Right click on Patch $->$ Select Plot Fields
			Choose: #strong[Mag_E]
			Select: All Objects
		- Click OK
  	- Maximum electric field is observed at the radiating edges of the patch.
	#set enum(start: 6)
	+ #strong[E-Field Animation]
		- Results → Animate Fields
		- Select Quantity: #strong[Mag_E]
		- Intrinsic: Phase
		- Set:
			- Phase variation: 0° to 360°
			- Number of frames: 20 or 30
		- Click: Animate
		The electric field will oscillate sinusoidally showing standing wave behavior on the patch.

== Result
A rectangular inset-fed microstrip patch antenna was successfully designed and simulated using HFSS. The antenna shows good impedance matching with return loss less than -10 dB at the resonant frequency. The radiation pattern is broadside with satisfactory gain, making it suitable for wireless communication applications. 