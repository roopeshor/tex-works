#set page(columns: 2, paper: "a4", margin: (x: 1.5cm, y: 2.3cm))
#set par(justify: true)
#set text(size: 12pt)
#set columns(gutter: 1cm)
#set enum(spacing: 15pt)
#set list(spacing: 10pt)
#let lstint = 20pt

#place(top + center, float: true, scope: "parent")[
  = Experiment 7: Rectangular Waveguide Using HFSS
  #v(20pt)
]

== Aim
To design a Rectangular Waveguide (WR-90) using HFSS and analyse cut off frequency, and field  distribution of dominant and higher-order modes. 
== Software Used
- ANSYS HFSS (High Frequency Structure Simulator)

== Theory
A rectangular waveguide is a hollow metallic 
conductor used for transmitting microwave signals from 
one point to another with very low loss. It operates 
based on electromagnetic wave propagation inside a 
closed conducting structure. Unlike transmission lines, 
waveguides do not support TEM mode. Only *TE 
(Transverse Electric)* and *TM (Transverse 
Magnetic)* modes can propagate.

- TE Mode → Longitudinal E field $E_z=0$
- TM Mode → Longitudinal E field $H_z=0$
The modes are represented as: $"TE"_"mn"$ and $"TM"_"mn"$
Where:
- $m$ = number of half-wave variations along broad wall ($a$) 
- $n$ = number of half-wave variations along narrow wall ($b$) 
The mode with the lowest cut off frequency is 
called the dominant mode. In rectangular waveguide: $"TE"_"10"$ is the dominant mode. For TE and TM modes: Cut-off Frequency is:
$ f_(c"(mn)") = c/2 sqrt((m/a)^2 + (n/b)^2) $
Wave propagation occurs only when $f > f_c$. If $f < f_c$, the wave is attenuated and does not propagate.

For Dominant Mode ($"TE"_10$):
$ f_c &= c/2a \
&= (3 times 10^8 "m/s")/(2 times 0.02286 "m") approx 6.56 "GHz" $

== Specifications

#table(
  columns: 2,
  stroke: none,
  row-gutter: 2pt,
  table.header([*Parameter*], [*Value*]),
  [Broad dimension ($a$)], [22.86 mm],
  [Narrow dimension ($b$)], [10.16 mm],
  [Length ($L$)], [60 mm],
  [Wall thickness ($t h$)], [0.2 mm],
  [Operating Frequency], [17 GHz],
)

== Procedure:
+ #strong[Start HFSS] 
  - Open HFSS
  - Select *Solution Type → Modal*
  - Click OK 
+ #strong[Define inner wall of waveguide]
  - Draw → Box1 
  - Position: $ (−a/2,  −b/2,  0) $
  - Dimensions:
    - $a$=22.86mm (Length - broad side) 
    - $b$=10.16mm (Height - narrow side) 
    - $L$=60mm (Waveguide length)
+ #strong[Define outer wall of waveguide]

  Create another box with small thickness $t h$. 
  - Name: Metal
  - Material: copper 
  - Position:
    $  (-a/2-t h, -b/2-t h, 0) $
  - Dimensions:
    $ (a + 2 t h, b + 2 t h, L) $
  Where: $t h$=0.2mm (wall thickness) 
  - Click OK 
+ #strong[Boolean Operation (Subtract)]
  - Select Outer box -metal 
  - Hold Ctrl → Select Inner box - box1 
  - Go to: *Modeler → Boolean → Subtract*
  - Click OK 
  Now hollow rectangular waveguide is created.
+ #strong[Define inside of waveguide as air. Create Air Box (Inside After Subtract)]
  - Select Box1 and copy and paste it 
  - Rename  as Air 
  - Material → Air 
  - Click OK 
+ #strong[Define outside of waveguide and radiation boundary. Create Radiation Box (Outer Air Region)]
  - Draw New Box 
    - Position: $ (-a/2-5"mm", -b/2-5"mm", 0) $
    - Dimensions: $ (a + 10"mm", b + 10"mm", L) $
    - Click OK
  This gives 5 mm air spacing on all lateral sides.
+ #strong[Assign Radiation Boundary]
  - Select outer air box 
  - Right click → *Assign Boundary $->$ Radiation*
  - Click OK 
+ #strong[Assign Wave Port] 
  - Select one open end face. 
  - Excitations → Wave Port → Next.
  - Click New Line and draw integration line.
  - *Number of modes = 4*
  - Click Next → Finish. 
  - Repeat for the second wave port. 
  Make sure integration line is drawn correctly: *center from bottom wall to top wall*
+ #strong[Add Solution Setup]
  - Go to Project Manager 
  - Right click → *Analysis → Add Solution Setup* 
  - Set: 
    - Frequency = 17 GHz
    - Maximum Delta S = 0.02
    - Maximum Passes = 12
  - Click OK
+ #strong[Add Frequency Sweep]
  - Right click on Setup → Add Frequency Sweep
  - Settings:
    - Sweep Type → *Discrete*
    - Start Frequency = *6.56 GHz*
    - Stop Frequency = *17 GHz*
    - Step Size = *0.01 GHz*
    - Tick Save Fields
  - Click OK
+ #strong[Validation & Analysis]
  - Click *Validate Design*
  - Click *Analyze*
+ #strong[Post Processing – Port Field Display]
  - After simulation, Go to: *Results → Create Field Plot → Port Fields*
  #underline[*Mode Selection*]:
  #table(
    columns: 2,
    stroke: none,
    row-gutter: 2pt,
    table.header([*Mode*], [*Description*]),
    [Mode 1], [$"TE"_10$ (Dominant mode)],
    [Mode 2], [$"TE"_20$],
    [Mode 3], [$"TE"_01$],
    [Mode 4], [$"TE"_11$],
  )
  #table(
    columns: 2,
    stroke: none,
    row-gutter: 2pt,
    table.header([*Mode*], [*Cutoff Frequency*]),
    [$"TE"_10$],[6.56 GHz],
    [$"TE"_20$],[13.12 GHz],
    [$"TE"_01$],[14.75 GHz],
    [$"TE"_11$],[16.15 GHz],
  )

+ #strong[Result analysis]
	#set enum(numbering: n => strong[13.#n])
  + #strong[S-Parameter Plot]
    - Go to Results → Create Modal Solution Data Report → Rectangular Plot
      - Select: $S("2:1","1:1")$
      - Format: dB
      - Click New Report
  + #strong[Electric field distribution]
    - Select Air box
    - *Plot Fields $->$ E $->$ Mag_E*
    - For mode selection:Goto *Excitation $->$ Edit sources* , and change:
      - Port number
      - Mode number
      - Magnitude
      - Phase
    #underline[*Excite Specific Mode:*]
    
    *Dominant Mode ($"TE"_10$):*
    #table(
      columns: 4,
      [*Port*], [*Mode*], [*Magnitude*], [*Phase*],
      [1],[1],[1],[0]
    )
    Characteristics: 
      - One half-wave variation along width 
      - No variation along height
    Electric field pattern: 
      - Maximum at center 
      - Zero at waveguide walls
    *For Higher Mode ( E.g: $"TE"_20$):*
    #table(
      columns: 4,
      [*Port*], [*Mode*], [*Magnitude*], [*Phase*],
      [1],[2],[1],[0]
    )
  Here we observe two half-wave variations across width.
#set enum(numbering: n => strong[13.#(n+2)])
  + #strong[Animate Field ]
    - Select *Mag_E*
    - Click Animate 
    - Adjust phase variation 
    - Observe field reversal

== Result
The WR-90 Rectangular Waveguide Standard was 
designed and simulated using ANSYS HFSS. The cutoff 
frequency of the dominant $"TE"_10$ mode was obtained 
around 6.56 GHz, and the field distributions of 
dominant and higher-order modes were successfully 
observed and verified.