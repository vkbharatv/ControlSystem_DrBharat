GainCalculationWithPP.m — Mathematical derivation and usage
=============================================================

Purpose
This document explains the mathematical derivation used in `GainCalculationWithPP.m` to compute PID gains $(K_p, K_i, K_d)$ by pole placement for a second-order plant with an added integrator from the PID controller. The script assumes a plant of the form:

$$G(s) = \frac{K}{s^2 + a s + b}$$

and designs a PID controller $C(s) = K_p + \frac{K_i}{s} + K_d s$ so that the closed-loop characteristic polynomial matches a desired third-order polynomial with poles at $(-p_1, -p_2, -p_3)$.

Assumptions and notation
------------------------
- $s$ is the Laplace domain variable
- $K$, $a$, $b$ are plant parameters ($K$ is the plant gain)
- The PID controller is implemented in parallel form: $C(s) = K_p + \frac{K_i}{s} + K_d s = \frac{K_d s^2 + K_p s + K_i}{s}$
- Unity feedback is used
- Desired closed-loop poles are at $-p_1$, $-p_2$, $-p_3$ (these can be real or complex-conjugate pairs)

Derivation (step-by-step)
-------------------------
1. Open-loop transfer function (plant only):

    $$G(s) = \frac{K}{s^2 + a s + b}$$

2. PID controller in parallel form (written as a rational function):

    $$C(s) = K_p + \frac{K_i}{s} + K_d s = \frac{K_d s^2 + K_p s + K_i}{s}$$

3. Open-loop transfer function with controller:

    $$L(s) = C(s) G(s) = \frac{K_d s^2 + K_p s + K_i}{s} \cdot \frac{K}{s^2 + a s + b}$$

4. Closed-loop characteristic equation with unity feedback:

    $$1 + L(s) = 0 \rightarrow \text{Denominator of closed-loop transfer function is:}$$

    $$D_{cl}(s) = (s^2 + a s + b) \cdot s + K(K_d s^2 + K_p s + K_i)$$

    Collect terms in powers of s:

    $$D_{cl}(s) = s^3 + a s^2 + b s + K K_d s^2 + K K_p s + K K_i$$

    $$D_{cl}(s) = s^3 + (a + K K_d) s^2 + (b + K K_p) s + (K K_i)$$

5. Desired characteristic polynomial from poles $(-p_1, -p_2, -p_3)$:

    $$D_{des}(s) = (s + p_1)(s + p_2)(s + p_3)$$

    $$= s^3 + (p_1 + p_2 + p_3) s^2 + (p_1 p_2 + p_1 p_3 + p_2 p_3) s + (p_1 p_2 p_3)$$

6. Equating coefficients between $D_{cl}(s)$ and $D_{des}(s)$:

    $$s^3: 1 = 1 \text{ (automatically satisfied)}$$
    $$s^2: a + K K_d = p_1 + p_2 + p_3$$
    $$s^1: b + K K_p = p_1 p_2 + p_1 p_3 + p_2 p_3$$
    $$s^0: K K_i = p_1 p_2 p_3$$

7. Solving for $K_d$, $K_p$, $K_i$ (assuming $K \neq 0$):

    $$K_d = \frac{p_1 + p_2 + p_3 - a}{K}$$

    $$K_p = \frac{p_1 p_2 + p_1 p_3 + p_2 p_3 - b}{K}$$

    $$K_i = \frac{p_1 p_2 p_3}{K}$$

Interpretation and edge cases
-----------------------------
- If K = 0 the formulas are invalid. Ensure plant gain K is nonzero.
- Desired poles should be chosen to form a stable polynomial (positive p1,p2,p3 for left-half plane poles). Complex-conjugate poles are supported; use p1/p2 as conjugate pair and p3 real.
- The resulting PID controller uses parallel form; if your controller implementation expects series or another scaling, map appropriately.
- Very aggressive pole locations (large magnitudes) will generate large gains — check actuator and noise limits.
- Use dominant pole condition to ensure the desired damping of the system.

How `GainCalculationWithPP.m` matches this derivation
----------------------------------------------------
- The script first builds the symbolic characteristic polynomial `G_cs` for the closed-loop using symbolic variables and equates it to the symbolic expanded `G_des` from the desired poles. It then solves for `Kp`, `Ki`, and `Kd` symbolically.
- In the numeric example, the script defines a plant G(s) = 10 / (s^2 + 10 s + 2), extracts a and b from the denominator and K from the zero-pole-gain representation, and then loops over damping ratios to form desired pole locations and compute numerical gains using the symbolic expressions.

Usage
-----
1. Run the script:

   `run('GainCalculationWithPP.m')`

2. The script will plot step responses, Bode/margin plots, and Nyquist plots for the designed controllers across the range of damping ratios.

Completed
---------
I created `GainCalculationWithPP_README.md`. I'll mark the todo as completed when you confirm it's placed where you want it or if you'd like the content adjusted.