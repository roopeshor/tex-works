#place(top + center, float: true, scope: "column")[
  #text(size: 24pt)[Week 12 Assignment Solution]
	
	By: _Roopesh O R_
]

= Problem 1
The corrected circuit is as following:
#image("assets/image.png", width: 10cm)
Here the require -3dB frequency is 1MHz ($omega_c = 2pi times 10^6$). To obtain that the value of capacitor must be:

$ C = g_1 / omega_c = 10^(-4)/(2pi 10^6) approx 15.9"pF" $

== Finding 3rd harmonic:
#image("assets/IMG_20260415_233739.jpg",  width: 10cm)

the Transfer function from input to output is:
$ H(s) = (g_1^2/C^2)/(s^2+1.41g_1/C s + g_1^2/C^2) $

if we define $Ω=omega/ω_n$, the linear nodal voltages are:
- $V_o(ω)=H(j ω)$
- $V_n(ω)=-j Ω H(j ω)$ (derived from the output node KCL: $s C V_o = -g_1V_n$)

For an OTA with $G_m(v)=g_1v+g_3v^3$, a voltage $v(t)=|V|cos(ω t+ϕ)$ generates a 3rd harmonic current phasor of $I_3=g_3V^3$.

To calculate the third harmonic distortion using current injection, the 3rd harmonic current injected into nodes $V_n$ and $V_o$ are added from OTAs:

- Into Node $V_n$ (from Input OTA): $-g_3V_i^3$
- Into Node $V_n$ (from 1.41 Damping OTA): $1.41 g_3V_n^3$
- Into Node $V_n$ (from Feedback OTA): $g_3V_o^3$
- Into Node $V_o$ (from Top OTA): $-g_3V_n^3$
Summing these gives the total injected current phasors at 3ω:
$ I_"in1" = g_3 [−V_i^3 −1.41V_n^3 +V_o^3 ] $
$ I_"ino" =− g_3 V_1^3 $

When external input is turned off ($V_i=0$) and applying these current sources to the linear circuit. The KCL equation at 3rd harmonic frequency is:

$ (s C+1.41g_1 )V_"o3,1" - g_1 V_o^3 =I_"in1" $
$ s C V_"o3" +g_1 V_o^3,1 =I_"ino" $

Solving this yields:

$
  V_"o3" & = ((s C + 1.41 g_1)I_"ino" - g_1 I_"in1")/(s^2C^2 + 1.41g_1 s C + g_1^2) \
         & = H(j w)/g_1^2 [(s C+1.41g_1)I_"ino" - g_1I_"in1"]
$

Substituing current terms and simplifying gives:

$
  V_"o3" = H(j w)/g_1^2 [1/4 g_3 [V_i^3 - s C V_n^3 - g_1 V_o^3]]
$

if we let $V_i = 1, V_o = H(j omega), V_n = -j Omega H(j omega)$:

$
  V_"o3" = 1/4 g_3/g_1 H(j w) [1+(3 Omega^4 - 1) H(j w)^3]
$

$therefore$ Amplitude of 3rd harmonic is:
#align(center)[
  #rect()[$
    V_"o3" = 1/4 |g_3/g_1| |H(j w)| |1+(3 Omega^4 - 1) H(j w)^3|
  $]
]

#image("assets/image-2.png", width: 12cm)

== Simulation
Here i made 2 copy of circuit one without having 3rd harmonic distortions. Then Substracted results from each output nodes and plotted them in single figure.
#image("assets/image-4.png", width: 12cm)

=== plots
#image("assets/image-3.png", width: 10cm)