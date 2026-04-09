#set page(margin: 2cm)
#set text(size: 12pt)

#place(center + top, float: true, scope: "parent")[
  #text(size: 24pt)[Week 11 Assignment]

  // #text(size: 16pt)[Roopesh O R]
]

// = Problem 1
// #figure[
//   #image("assets/image.png", width: 50%)
// ]

// To find the amplitudes of IM3 tones, we model the weakly nonlinear amplifier polynomial expansion up to the third order:

// $ v_"out"(t) = alpha_1 v_"in"(t) + alpha_2 v_"in"^2(t) + alpha_3 v_"in"^3(t) $

// The input signal consists of two tones:
// $ v_"in"(t) = A_1 cos(omega_1 t) + A_2 cos(omega_2 t) $
// where $omega_1 = 2 pi f_1$ and $omega_2 = 2 pi f_2$.

// The intermodulation tones frequencies ($2f_1 - f_2$ and $2f_2 - f_1$) are generated exclusively by the third-order term, $alpha_3 v_"in"^3(t)$. Expand that term gives:

// $
//   v_"in"^3(t) & = ( A_1 cos(omega_1 t) + A_2 cos(omega_2 t) )^3 \
//               & = A_1^3 cos^3(omega_1 t) + 3 A_1^2 A_2 cos^2(omega_1 t) cos(omega_2 t) \
//               & + 3 A_1 A_2^2 cos(omega_1 t) cos^2(omega_2 t) + A_2^3 cos^3(omega_2 t)
// $

// The IM3 products emerge from the cross-terms. We simplify expression by each term:

// *Analyzing the first cross-term ($3 A_1^2 A_2 ...$):*

// $
//   3 A_1^2 A_2 cos^2(omega_1 t) cos(omega_2 t)
//   &= 3 A_1^2 A_2 (1/2 + 1/2 cos(2 omega_1 t)) cos(omega_2 t) \
//   &= 3/2 A_1^2 A_2 cos(omega_2 t) + 3/2 A_1^2 A_2 cos(2 omega_1 t) cos(omega_2 t) \
//   &= 3/2 A_1^2 A_2 cos(omega_2 t) + 3/4 A_1^2 A_2 [cos((2 omega_1 - omega_2)t) + cos((2 omega_1 + omega_2)t)]
// $

// This shows an IM3 tone at $2 omega_1 - omega_2$ with an amplitude of $3/4 A_1^2 A_2$. When multiplied by the nonlinear coefficient, the output amplitude is *$3/4 |alpha_3| A_1^2 A_2$*.

// *For second cross-term ($3 A_1 A_2^2 ...$):*
// $
//   3 A_1 A_2^2 cos(omega_1 t) cos^2(omega_2 t)
//   &= 3 A_1 A_2^2 cos(omega_1 t) (1/2 + 1/2 cos(2 omega_2 t)) \
//   &= 3/2 A_1 A_2^2 cos(omega_1 t) + 3/2 A_1 A_2^2 cos(omega_1 t) cos(2 omega_2 t) \
//   &= 3/2 A_1 A_2^2 cos(omega_1 t) + 3/4 A_1 A_2^2 [cos((2 omega_2 - omega_1)t) + cos((2 omega_2 + omega_1)t)]
// $

// Again showing second IM3 tone at $2 omega_2 - omega_1$ with an amplitude of $3/4 A_1 A_2^2$. Multiplying by the coefficient gives an output amplitude of *$3/4 |alpha_3| A_1 A_2^2$*.

// *Amplitudes*
// Third-order intermodulation tones amplitudes are:

// - At frequency *$2f_1 - f_2$*: *$3/4 |alpha_3| A_1^2 A_2$*
// - At frequency *$2f_2 - f_1$*: *$3/4 |alpha_3| A_1 A_2^2$*

= Problem 2
Created circuit
#figure[
  #image("assets/image-3.png")
]

=== for case (a): $g_3 approx 0 "and" g_2 = 10^(-5)$
#figure[
  Plot of $V_o$ and $V_"o(1)"$
  #image("assets/image-11.png")
  we can see some phase reversal between them
]

Plot of
- $v_"o(t)" - v_"o(1)"(t)$
- $v_"o(t)" - v_"o(1)"(t) - v_"o(2)"(t)$
- $v_"o(t)" - v_"o(1)"(t) - v_"o(2)"(t) - v_"o(3)" (t)$
#figure[
  #image("assets/image-6.png")
	we can see effect of all terms here

]

=== for case (b): $g_2 = 10^(-5) "and" g_3 = 10^(-5)$

#figure[
  Plot of $V_o$ and $V_"o(1)"$
  #image("assets/image-10.png")
  we can see some phase reversal between them
]
#v(1cm)
Plot of
- $v_"o(t)" - v_"o(1)"(t)$
- $v_"o(t)" - v_"o(1)"(t) - v_"o(2)"(t)$
- $v_"o(t)" - v_"o(1)"(t) - v_"o(2)"(t) - v_"o(3)" (t)$
#figure[
  #image("assets/image-5.png")
	we can see effect of all terms
]

From this we can see that effect of non-linarity decreases with increase in order, with third order having minimum effect

=== for case (c): $g_2 approx 0 "and" g_3 = 10^(-4)$
#figure[
  Plot of $V_o$ and $V_"o(1)"$
  #image("assets/image-12.png")
  we see some phase reversal with distortion in final output
]

Plot of
- $v_"o(t)" - v_"o(1)"(t)$
- $v_"o(t)" - v_"o(1)"(t) - v_"o(2)"(t)$
- $v_"o(t)" - v_"o(1)"(t) - v_"o(2)"(t) - v_"o(3)" (t)$
#figure[
  #image("assets/image-14.png")
]
in this we see 3rd order has highest visible effect on output compared as 2nd order effect is zero
