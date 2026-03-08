#set page(columns: 2, paper: "a4", margin: (x: 1.5cm, y: 2.3cm))
#set par(justify: true)
#set text(size: 12pt)
#set columns(gutter: 1cm)
#set enum(spacing: 15pt)
#set list(spacing: 10pt)
#let lstint = 20pt

#place(top + center, float: true, scope: "parent")[
  = Experiment 3:  Magic Tee Structure Using HFSS
	#v(20pt)
]
== Aim
To design and simulate a Magic Tee (Hybrid Tee)
junction using ANSYS HFSS and to study the
electric and magnetic field distributions.
== Software Required
• ANSYS Electronics Desktop (HFSS)
== Theory
A Magic Tee, also called a Hybrid Tee, is a four-
port waveguide junction formed by combining an E-plane tee and an H-plane tee.
- It has #strong[4 ports]:
	- #strong[Port-1 and Port-2]: Collinear ports
	- #strong[Port-3]: E-arm (difference port)
	- #strong[Port-4]: H-arm (sum port)
- When power is fed into the #strong[H-arm], it divides equally between Ports 1 and 2 #strong[in phase].
- When power is fed into the #strong[E-arm], it divides equally between Ports 1 and 2 but #strong[180° out of phase].
- Ports 3 and 4 are #strong[isolated from each other].
- Magic Tee is widely used in #strong[microwave mixers, duplexers, and power dividers].
#v(1cm)
#figure(
	image("image.png")
)-

#colbreak()
== Procedure
+ #strong[Creation of the Base Waveguide]
	+ Open ANSYS Electronics Desktop → Select HFSS → New 3D Model.
	+ Go to Draw → Box.
	+ Enter the dimensions:
		- X-dimension: 22.86 mm
		- Y-dimension: 10.16 mm
		- Z-dimension: 60 mm
	+ Set the position:
		- X = -11.43 mm
		- Y = -5.08 mm
		- Z = 0 mm
	+ Click OK.
	+ Press Ctrl + D to view the model clearly.
+ #strong[Creating the E-Plane Arm]
	+ Right-click on the base box.
	+ Select Edit → Duplicate → Around Axis.
	+ Choose:
		- Axis: X-axis
		- Rotation Angle: +90°
	+ Click OK.
+ #strong[Creating the H-Plane Arm]
	+ Right-click on the #strong[original base box].
	+ Select Edit → Duplicate → Around Axis.
	+ Choose:
		- Axis: Y-axis
		- Rotation Angle: +90°
	+ Click OK.
+ #strong[Uniting the Geometry]
	+ Select all four waveguide sections.
	+ Right-click → Edit → Boolean → Unite.
	+ The Magic Tee structure becomes a single solid model.
+ #strong[Assigning Wave Ports]
	+ Select the face at one collinear end.
	+ Right-click → Excitations → Wave Port → Next.
	+ Draw the integration line correctly.
	+ Click Next → Finish.
	+ Repeat the procedure for:
		- Other collinear port
		- E-arm port
		- H-arm port
	+ Ensure all four ports are properly assigned.
+ #strong[Assigning Perfect E Boundary]
	+ Select all faces except wave-port faces.
	+ Right-click → Assign Boundary → Perfect E.
	+ Click OK.
+ #strong[Adding Solution Setup]
	+ Go to Analysis → Add Solution Setup.
	+ Set:
		- Solution Frequency: 10 GHz
		- Maximum Number of Passes: 6
	+ Click OK.
+ #strong[Adding Frequency Sweep]
	+ Go to Analysis → Setup.
	+ Right-click Setup1 → Add Frequency Sweep.
	+ Enter:
		- Start Frequency: 5 GHz
		- Stop Frequency: 15 GHz
	+ Click OK.
	+ Right-click Analysis → Analyze All.
	+ Save the project.
+ #strong[Plotting Electric Field Distribution]
	+ Select the structure → Right-click.
	+ Choose Plot Fields → E → Vector E.
	+ Click Done.
	+ Observe and animate the electric field pattern.
+ #strong[Plotting Magnetic Field Distribution]
	+ Select the required faces.
	+ Right-click → Plot Fields → H → Mag_H.
	+ Click Done.
	+ Animate to observe magnetic field behavior.

== Result
The Magic Tee (Hybrid Tee) junction was
successfully designed and simulated using
ANSYS HFSS, and the electric and magnetic
field distributions were observed.