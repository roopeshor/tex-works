#import "@preview/cetz:0.4.2"

#set page(paper: "a4", margin: auto)
#set text(font: "New Computer Modern", size: 11pt)
#show math.equation: set text(font: "New Computer Modern Math")
#set heading(numbering: "1.1")

#align(center)[
  #text(size: 16pt, weight: "bold")[Information Theory & Coding] \
  #v(1em)
  #text(size: 14pt)[Dept of ECE] \
  #v(2em)
]

= CAPACITY OF A BAND-LIMITED GAUSSIAN CHANNEL
For finding the capacity of a band-limited Gaussian channel, we have to know about
Shannon's theorem & Shannon-Hartley theorem.

== SHANNON'S THEOREM
If continuous messages are generating at a rate $R$, then there exists a
coding technique such that we can transmit the message over the channel with minimum probability
of error.

== NEGATIVE STATEMENT
If there exists $R > C$, there does not exist any
coding technique such that we can transmit the message over the channel with probability of error
which is close to one.

== SHANNON-HARTLEY THEOREM
Shannon-Hartley theorem is applicable to the channel affected by Gaussian noise. It
states that, the channel capacity of a white, band limited Gaussian channel is

$ C = B log_2 ( 1 + S/N ) $

Where:
- $B$ is the channel bandwidth
- $S$ is the signal power
- $N$ is the noise power; $N = N_0 B$, where $N_0/2$ is the two-sided power spectral density

=== DERIVATION
For the purpose of transmission over a channel the messages are repeated by fixed
voltage levels. Then the source generates one message after another in sequence. The transmitted
signal $s(t)$ can be shown in figure as:

#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    
    // Axes
    line((0, -3), (0, 3.5), mark: (end: ">"), name: "y_axis")
    line((0, 0), (6, 0), mark: (end: ">"), name: "x_axis")
    content((6, -0.3), [$t$])
    content((0.4, 3.3), [$s(t)$])
    
    // Dashed lines
    let sigma_lambda(y, label) = {
      line((0, y), (4.5, y), stroke: (dash: "dashed", paint: luma(100)))
      if label != none {
        content((-0.6, y), label)
      }
    }
    
    sigma_lambda(2.5, [$5 lambda sigma \/ 2$])
    sigma_lambda(1.5, [$3 lambda sigma \/ 2$])
    sigma_lambda(0.5, [$lambda sigma \/ 2$])
    sigma_lambda(-0.5, [$-lambda sigma \/ 2$])
    sigma_lambda(-1.5, [$-3 lambda sigma \/ 2$])
    sigma_lambda(-2.5, [$-5 lambda sigma \/ 2$])
    
    content((3.5, -0.9), [$sigma lambda$])
    
    // Step waveform
    line((0, 1.5), (0.5, 1.5), (0.5, 0.5), (1.2, 0.5), (1.2, 2.5), (1.8, 2.5), (1.8, -1.5), (2.5, -1.5), (2.5, -0.5), (3.2, -0.5), (3.2, 1.5), (4, 1.5), (4, 0.5))
  })
]

Here $sigma lambda$ is the step size.
The levels are located at voltages $-5\/2 lambda sigma, -3\/2 lambda sigma, -1\/2 lambda sigma, 1\/2 lambda sigma, 3\/2 lambda sigma, 5\/2 lambda sigma$.

The average signal power, if there are $M$ signals or $M$ levels is

$ S = (V_1^2 + V_2^2 + V_3^2 + ... + V_M^2)/M $

Here the voltage levels are $plus.minus 1\/2 lambda sigma, plus.minus 3\/2 lambda sigma, plus.minus 5\/2 lambda sigma, ..., plus.minus (M-1)/2 lambda sigma$, because, if we take 8 levels the last level is $plus.minus 7\/2 lambda sigma = plus.minus (8-1)/2 lambda sigma$.

i.e.
$ S = 2/M [ (1/2 lambda sigma)^2 + (3/2 lambda sigma)^2 + ... + ((M-1)/2 lambda sigma)^2 ] $
$ S = 2/M (lambda sigma)/4 [ 1^2 + 3^2 + 5^2 + ... + (M-1)^2 ] $
$ S = (2 (lambda sigma)^2)/(4M) (M(M^2 - 1))/6 $
$ S = (lambda sigma)^2/12 (M^2 - 1) $

From this,
$ M^2 - 1 = (12 S)/(lambda sigma)^2 $
$ M^2 = 1 + (12 S)/(lambda sigma)^2 $
$ M = sqrt(1 + (12 S)/(lambda sigma)^2) $

Since $N = (lambda sigma)^2 / 12$, we can write:
$ M = sqrt(1 + S/N) = (1 + S/N)^(1/2) $

Each message is equally likely. Then we can write entropy, $H = log_2 M$
$ H = log_2 (1 + S/N)^(1/2) = 1/2 log_2 (1 + S/N) $

We know that the rate of information, $R = r H$. When transmission is at channel capacity,
$ C = r H = r 1/2 log_2 (1 + S/N) $

By Sampling theorem, the Nyquist rate $r$ is given by $r = 2B$, where $B$ is the bandwidth.
$ C = 2B 1/2 log_2 (1 + S/N) $
$ C = B log_2 (1 + S/N) "bits/sec" $

The Shannon-Hartley theorem specifies the rate at which the information may be
transmitted with small probability of error. Thus Shannon-Hartley theorem contemplates that,
with a sufficiently sophisticated transmission technique, transmission at channel capacity is
possible with arbitrarily small probability of error.

== SIGNIFICANCE OF SHANNON-HARTLEY THEOREM
The significance of Shannon-Hartley theorem is that it is possible to transmit symbols
over an AWGN channel of bandwidth $B$ Hz with an arbitrarily small probability of error, if the signal is encoded in such a manner that the samples are all Gaussian
signals. It is achieved by orthogonal codes.
The Shannon-Hartley theorem gives an idea about Bandwidth - SNR tradeoff.

== BANDWIDTH - SNR TRADEOFF
The tradeoff is the exchange of bandwidth with signal to noise power ratio.
Suppose $S/N = 7$ & $B = 4 "kHz"$, then $C = 12,000 "bits/sec"$.
Suppose $S/N = 15$ & $B = 3 "kHz"$, then $C = 12,000 "bits/sec"$.

That is, for a reduction in bandwidth, we require an increment in signal to noise ratio. We
know that
$ C = B log_2 (1 + S/N) $

By plotting Bandwidth vs Signal to Noise Ratio for a constant Capacity $C$, we get:

#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    
    line((0, 0), (0, 4), mark: (end: ">"), name: "y_axis")
    line((0, 0), (6, 0), mark: (end: ">"), name: "x_axis")
    
    content((-0.5, 2), [Band Width], angle: -90deg)
    content((3, -0.5), [Signal To Noise Ratio])
    
    bezier((0.2, 3.8), (5.8, 0.5), (1.5, 0.5), (3, 0.5), stroke: 1.5pt)
  })
]

From the figure we know that when SNR increases the BW decreases. At SNR > 10, the
reduction in bandwidth increasing SNR is poor. The use of larger bandwidth for smaller SNR is
called coding upwards (e.g. FM, PM, PCM) and the use of smaller bandwidth for larger SNR is
called coding downwards (e.g. PAM). This tradeoff can be seen when we take the capacity of a
channel of infinite bandwidth.

== CAPACITY OF A CHANNEL OF INFINITE BANDWIDTH
By Shannon Hartley theorem,
$ C = B log_2 (1 + S/N) $

When bandwidth becomes infinite, the capacity approaches an upper limit with increasing bandwidth.
$ C = B log_2 (1 + S/N) = B log_2 (1 + S/(N_0 B)) $
Muliplying and dividing the power by $S$,
$ C = B log_2 (1 + S/(N_0 B))^(S/S) = S/N_0 log_2 (1 + S/(N_0 B))^((N_0 B)/S) $

We know that $lim_(x->0) (1+x)^(1/x) = e$
When the bandwidth tends to infinity, $S/(N_0 B) -> 0$.

$ lim_(B->oo) C = lim_(B->oo) S/N_0 log_2 (1 + S/(N_0 B))^((N_0 B)/S) = S/N_0 log_2 e $
$ C = 1.44 S/N_0 $

== ORTHOGONAL SIGNAL TRANSMISSION

Suppose that $M$ messages $m_1, m_2, ..., m_M$ are transmitted. In orthogonal signal transmission, signals $S_1(t), S_2(t), ..., S_M(t)$ are used for transmitting $M$ messages. For these signals, the condition for orthogonality is,
$ integral_0^T S_i(t) S_j(t) d t = cases(
  0 "for" i eq.not j,
  E "for" i = j
) $
Where $E$ is the energy of the signal. The time $T$ refers to the symbol duration. We can achieve this orthogonal transmission by using $M$ matched filters.

#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    
    // Source Block
    rect((0, 3), (3, 5), name: "source")
    content((1.5, 4), [Source \ Transmitting \ $M$ Messages])
    
    // Adder
    circle((4.5, 4), radius: 0.3, name: "adder")
    content((4.5, 4), text(size: 16pt)[+])
    line((3, 4), (4.2, 4), mark: (end: ">"))
    
    // Noise Input
    line((4.5, 6), (4.5, 4.3), mark: (end: ">"))
    content((4.5, 6.3), [White Noise, $n(t)$])
    
    // Splitter Line
    line((4.8, 4), (5.5, 4))
    line((5.5, 2.5), (5.5, 5.5))
    
    // Branches 1, 2, and M
    for (i, y, label) in (
      (1, 5.5, "$S_1(t)$"),
      (2, 4.0, "$S_2(t)$"),
      ("M", 2.5, "$S_M(t)$")
    ) {
      // Multiplier
      circle((6.5, y), radius: 0.25, name: "mult_" + str(i))
      content((6.5, y), text(size: 12pt)[$times$])
      line((5.5, y), (6.25, y), mark: (end: ">"))
      
      // Multiplier input
      line((6.5, y + 1), (6.5, y + 0.25), mark: (end: ">"))
      content((6.5, y + 1.2), label)
      
      // Integrator
      rect((7.5, y - 0.5), (9, y + 0.5), name: "int_" + str(i))
      content((8.25, y), text(size: 14pt)[$integral_0^T$])
      line((6.75, y), (7.5, y), mark: (end: ">"))
      
      // Line to Decision Block
      line((9, y), (10, y), mark: (end: ">"))
    }
    
    // Vertical dots for abbreviation
    content((6.5, 3.25), [$dots.v$])
    
    // Decision Circuit
    rect((10, 1.5), (13, 6.5), name: "decision")
    content((11.5, 4), [Decision \ Circuit])
    
    // Outputs
    line((13, 5.5), (14, 5.5), mark: (end: ">")); content((14.5, 5.5), [$s_1(t)$])
    line((13, 4.0), (14, 4.0), mark: (end: ">")); content((14.5, 4.0), [$s_2(t)$])
    line((13, 2.5), (14, 2.5), mark: (end: ">")); content((14.5, 2.5), [$s_M(t)$])
  })
]

Suppose we have to transmit the $1^"st"$ message. The source emits $m_1$, which corresponds to $S_1(t)$. During transmission through the channel, noise will be added to this signal. Since it is white noise, $n_w(t)$ is added to the signal. Now the received signal is
$ x(t) = S_1(t) + n_w(t) $

This will be transmitted to all $M$ correlators. Then the output of the $1^"st"$ correlator is $e_1$.
$ e_1 = integral_0^T x(t) S_1(t) d t $
$ e_1 = integral_0^T (S_1(t) + n_w(t)) S_1(t) d t $
$ e_1 = integral_0^T S_1(t)^2 d t + integral_0^T n_w(t) S_1(t) d t $
$ e_1 = E + n_1 $

Where $n_1$ is the noise signal of the $1^"st"$ correlator. For other correlators,
$ e_j = integral_0^T x(t) S_j(t) d t $
$ e_j = integral_0^T (S_1(t) + n_w(t)) S_j(t) d t $
$ e_j = integral_0^T S_1(t) S_j(t) d t + integral_0^T n_w(t) S_j(t) d t $
Since $integral_0^T S_1(t) S_j(t) d t = 0$ for $1 eq.not j$,
$ e_j = 0 + n_j = n_j $

So only one output $e_1$ has the information content, whereas all others are simply random outputs.

In practical channels, the noise power $N_0$ is generally a constant. If $E_b$ is the transmitted energy per bit, then the average transmitted power is
$ S = E_b R $
Normally $R$ is replaced by Capacity $C$. Thus $S = E_b C$.

The two-sided power spectral density of an AWGN channel is:
$ S_n(f) = N_0 / 2 $

#align(center)[
  #cetz.canvas({
    import cetz.draw: *
    
    // Input text
    content((0, 2), [$W(t)$], name: "w_in")
    content((0, 1), [$R_W(tau) = N_0/2 delta(tau)$])
    
    // Delta symbol plot approx above arrow
    line((1.5, 3), (1.5, 4))
    line((1, 3.5), (2, 3.5))
    content((1.5, 2.5), [$mu_X = 0$])
    
    // Ideal LPF Rect
    rect((2.5, 1.5), (6.5, 4), name: "lpf")
    content((4.5, 2.75), [Ideal LPF \ $h(t), H(f)$])
    
    // Connections
    line((0.8, 2), (2.5, 2), mark: (end: ">"))
    line((6.5, 2), (8.5, 2), mark: (end: ">"))
    
    // Output text
    content((9, 2), [$N(t)$])
    content((8, 1), [$S_N(f) = N_0/2$])
    
    // Rect symbol plot approx above output arrow
    line((7.2, 3), (7.2, 3.5), (8.2, 3.5), (8.2, 3))
    line((7.7, 3), (7.7, 4))
    line((6.8, 3), (8.6, 3))
    content((8.6, 3.5), [$mu_Y = 0$])
  })
]

Here the $S_N(f)$ & $R_N(tau)$ are Fourier transform pairs:
$ R_N(tau) = integral_(-B)^(B) N_0 / 2 e^(j 2 pi f tau) d f $
$ R_N(tau) = N_0 / 2 [ e^(j 2 pi f tau) / (j 2 pi tau) ]_(-B)^(B) $
$ R_N(tau) = N_0 / (2 j 2 pi tau) [ e^(j 2 pi B tau) - e^(-j 2 pi B tau) ] $
$ R_N(tau) = N_0 / (2 pi tau) sin(2 pi B tau) $
$ R_N(tau) = N_0 B sin(2 pi B tau) / (2 pi B tau) = N_0 B "sinc"(2 B tau) $

That is, the total noise power $N = R_N(0) = N_0 B$.
Apply this in the Shannon-Hartley theorem, we get:
$ C = B log_2(1 + S/N) $
$ C = B log_2(1 + (E_b C)/(N_0 B)) $
$ C/B = log_2(1 + E_b/N_0 C/B) $

Here $C/B$ is the bandwidth efficiency.
If $C/B = 1$, then $E_b/N_0 = 1$. That is, the signal energy is equal to the noise energy.

We know that channel capacity must be maximum when we utilize the maximum bandwidth. That is the channel capacity must be equal to the maximum bandwidth, $C = B_0$.
$ C_(max) = B_0 log_2 e = 1.44 B_0 $
$ \lim_(B -> oo) E_b / N_0 = \lim_(B -> oo) (2^(C/B) - 1)/(C/B) = 0.693 = -1.59 "dB" $

= PROBLEMS

*32. A voice grade channel of a telephone network has a bandwidth of 3.4 kHz.*
*a. Calculate the channel capacity of the telephone channel for a signal to noise ratio of 30dB.*
*b. Calculate the minimum signal to noise ratio required to support information transmitted through the telephone channel at a rate of 4800 bits per second.*

*Ans:*
a. $B = 3.4 "kHz"$, $S/N = 30 "dB"$
$10 log_10(S/N) = 30 => S/N = 1000$
$ C = B log_2(1 + S/N) = 3400 log_2(1 + 1000) = 33.8 "kbps" $

b. $B = 3.4 "kHz"$, $C = 4.8 "kbps"$
$ C = B log_2(1 + S/N) $
$ 4800 = 3400 log_2(1 + S/N) $
$ log_2(1 + S/N) = 1.41 $
$ 1 + S/N = 2.65 => S/N = 1.65 $
$ 10 log_10(1.65) = 2.2 "dB" $

*33. A communication system employs a continuous source. The channel noise is white and Gaussian. The bandwidth of the source output is 10MHz and SNR is 100.*
*a. Determine the channel capacity.*
*b. If the SNR drops to 10, how much bandwidth is needed to achieve the same channel capacity?*
*c. If the bandwidth is decreased to 1MHz, how much SNR is required to maintain the same channel capacity?*

*Ans:*
a. $B = 10 "MHz"$, $S/N = 100$
$ C = B log_2(1 + S/N) = 10^7 log_2(1 + 100) = 66.5 "Mbps" $

b. $S/N = 10$, $C = 66.5 "Mbps"$
$ C = B log_2(1 + S/N) $
$ 66.5 times 10^6 = B log_2(1 + 10) $
$ B = 19.22 "MHz" $

c. $B = 1 "MHz"$, $C = 66.5 "Mbps"$
$ C = B log_2(1 + S/N) $
$ 66.5 times 10^6 = 10^6 log_2(1 + S/N) $
$ log_2(1 + S/N) = 66.5 $
$ S/N = 1.04 times 10^20 = 200.2 "dB" $

*34. Alphanumeric data are entered into a computer from a remote terminal through a voice grade telephone channel. The channel has a bandwidth of 3.4 kHz and output signal to noise power ratio of 20dB. The terminal has a total of 128 symbols which may be assumed to occur with equal probability and that the successive transmissions are statistically independent.*
*a. Calculate the channel capacity.*
*b. Calculate the maximum symbol rate for which error free transmission over the channel is possible?*

*Ans:*
a. $B = 3.4 "kHz"$, $S/N = 20 "dB" = 100$
$ C = B log_2(1 + S/N) = 3400 log_2(1 + 100) = 22640 "bps" $

b. $H_(max) = log_2(128) = 7 "bits/symbol"$, $C = 22640 "bps"$
We have $C = r times H$, where $r$ is the maximum symbol rate:
$ r = C / H = 22640 / 7 = 3234 "symbols/sec" $

*35. A black and white television picture may be viewed as consisting of approximately $3 times 10^5$ elements; each one of which may occupy one of 10 distinct brightness levels with equal probability. Assume the rate of transmission to be 30 picture frames per second, and the signal to noise ratio is 30dB. Using channel capacity theorem, calculate the minimum bandwidth required to support the transmission of the resultant video signal?*

*Ans:*
No. of different pictures possible per frame $= 10^(3 times 10^5)$
Entropy per frame, $H = log_2(10^(3 times 10^5)) = 3 times 10^5 log_2(10) = 9.97 times 10^5 "bits/frame"$
Rate of information $R = 30 "frames/sec" times 9.97 times 10^5 "bits/frame" = 29.9 times 10^6 "bps"$
Capacity $C = R = 29.9 times 10^6 "bps"$
We know that $C = B log_2(1 + S/N)$
$ 29.9 times 10^6 = B log_2(1 + 1000) $
$ B = 3 "MHz" $
