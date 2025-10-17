## State-space pole placement — equations and worked example

This folder demonstrates state-space pole placement for a SISO LTI system and shows a worked solution using a **Observable canonical realization**.

### Notation and basic equations

We use the standard state-space form

$$
\dot{x} = A x + B u,\qquad y = C x + D u
$$

With full-state feedback of the form

$$
u = -K_1 x + K_2\,r
$$

the closed-loop state matrix becomes

$$
A_{cl} = A - B K.
$$

We choose $K$ so that the eigenvalues of $A_{cl}$ equal the desired pole locations $\{p_i\}$. In MATLAB this is commonly computed with

$$
K_1 = \text{place}(A, B, [p_1\; p_2\; \dots])
$$

To get unity steady-state gain from a step reference $r(t)=1$ one useful precompensator is

$$
K_2 = -\frac{1}{C (A - B K)^{-1} B},
$$

provided $(A - B K)$ is invertible and the closed-loop configuration is appropriate for this formula.

### Controllability requirement

State-feedback pole placement requires the (A,B) pair to be controllable. For an n=2 system form the controllability matrix

$$
\mathcal{C} = \begin{bmatrix} B & A B \end{bmatrix}
$$

and require $\mathrm{rank}(\mathcal{C}) = 2$. If $\mathrm{rank}(\mathcal{C})<2$ you cannot arbitrarily assign both closed‑loop poles from that realization — only the poles in the controllable subspace can be moved. In that case either change the actuator/sensor layout, work with a reduced-order controller for the controllable subspace, or convert the model to a controllable realization before designing full-state feedback.

In MATLAB you typically compute the state-feedback gain with

```
K_1 = place(A, B, [p1 p2]);
```

and always check controllability first to avoid surprises.



### Worked example (matching `PPwithStateSpace.m`)

1) Example of state space matrice definition in Matlab:

$$
A = \begin{bmatrix}1 & 0;\\ -1 & -1\end{bmatrix},\qquad
B = \begin{bmatrix}0;\\ 1\end{bmatrix},\qquad
C = \begin{bmatrix}0 & 1\end{bmatrix},\qquad D = 0.
$$

With the desired poles $p_1=-1$ and $p_2=-5$ you might try to compute $K=\text{place}(A,B,[p_1\;p_2])$. However, this particular $(A,B)$ pair is not full-rank controllable (check $[B\;AB]$) so both poles cannot be placed from this realization.

2) Observale-canonical realization (using `compreal`)

The script uses MATLAB's `compreal(sys, 'o')` function to convert the transfer function

$$
G(s) = \frac{0.5}{s^2 + 2s + 1}
$$

to a **Observable** canononical realization. (Note: Despite the 'o' parameter, `compreal` produces a Observable canonical form.) The Observable canononical form for this second-order system is:

$$
A = \begin{bmatrix}0 & 1 ;\\ -1 & -2\end{bmatrix},\qquad
B = \begin{bmatrix}0 ;\\ 0.5\end{bmatrix},\qquad
C = \begin{bmatrix}1 & 0\end{bmatrix},\qquad D=0.
$$

This realization is **Observable** by construction (by the definition of the Observable canononical form). The script also verifies:
- **Controllability**: checks rank of $\mathcal{C} = [B\; AB]$
- **Observability**: checks rank of $\mathcal{O} = \begin{bmatrix}C \\ CA\end{bmatrix}$

Both conditions are satisfied for this realization, so full-state feedback pole placement is possible.

3) Pole placement with state feedback

With state-feedback control law $u = -K_1 x + K_2 r$, where $K_1 = [k_1\; k_2]$ is a row vector, the closed-loop state matrix is

$$
A_m = A - B K_1.
$$

For the controllable canononical form matrices above:

$$
A_m = \begin{bmatrix}0 & 1; -1 & -2\end{bmatrix} - \begin{bmatrix}0 \;, 0.5\end{bmatrix}^T[k_1\; k_2]
= \begin{bmatrix}0 & 1; -1-0.5k_1 & -2-0.5k_2\end{bmatrix}.
$$

The characteristic polynomial of $A_m$ is

$$
\det(sI - A_m) = s^2 + (2+0.5k_2)s + (1+0.5k_1).
$$

To place the closed-loop poles at $p_1=-1$ and $p_2=-5$, match this to the desired characteristic polynomial:

$$
(s+1)(s+5) = s^2 + 6s + 5.
$$

Equating coefficients:

$$
2 + 0.5k_2 = 6,\qquad 1 + 0.5k_1 = 5,
$$

which gives

$$
k_2 = 8,\qquad k_1 = 8.
$$

So the state-feedback gain computed by `place(A, B, [p1 p2])` will be:

$$
K_1 = [8\; 8].
$$

4) Reference precompensator for unit-step tracking

To achieve unity DC gain from reference $r$ to output $y$, compute

$$
K_2 = -\frac{1}{C A_m^{-1} B}.
$$

With $K_1=[8\;8]$, the closed-loop matrix is

$$
A_m = \begin{bmatrix}0 & 1\\ -5 & -6\end{bmatrix}.
$$

Solve $A_m z = B$ to get $A_m^{-1}B$:

$$
A_m^{-1}B = \begin{bmatrix}-0.1\\ 0\end{bmatrix},
$$

so

$$
C A_m^{-1} B = [1\; 0]\begin{bmatrix}-0.1\\ 0\end{bmatrix} = -0.1.
$$

Hence

$$
K_2 = -\frac{1}{-0.1} = 10.
$$

**Summary (Controllable canonical solution):**

$$
K_1 = [8\; 8],\qquad K_2 = 10.
$$

The closed-loop system with these gains will have poles at $-1$ and $-5$, and unit steady-state gain for step reference inputs.


### How to reproduce in MATLAB

- Open MATLAB
- Change directory to this folder
- Run `PPwithStateSpace.m` — the script:
  1. Defines an initial state-space system
  2. Converts the transfer function $G(s) = 0.5/(s^2+2s+1)$ to controllable canononical form using `compreal(sys, 'o')`
  3. Checks controllability and observability using `ctrb()` and `obsv()`
  4. Computes state-feedback gain `K_1 = place(A,B,[p1 p2])` to place poles at desired locations.
  5. Computes reference precompensator `K_2` for unit steady-state gain
  6. Plots the step response of the closed-loop system and the pole-zero map
  7. Displays the numeric values of `K_1` and `K_2`

### Controllability and observability requirements

For state-feedback and observer design both the controllability and observability properties must be checked (for n=2 the checks are):

- Controllability: form the controllability matrix
    $$
    \mathcal{C} = \begin{bmatrix} B & A B \end{bmatrix},
    $$
    and require rank(𝒞) = 2. If rank(𝒞) < 2 some states cannot be moved by the input and you cannot arbitrarily place all closed‑loop poles from that realization.

- Observability: form the observability matrix
    $$
    \mathcal{O} = \begin{bmatrix} C \\ C A \end{bmatrix},
    $$
    and require rank(𝒪) = 2. If rank(𝒪) < 2 some states cannot be reconstructed from the outputs and you cannot design a full‑state observer.

Typical actions if a property fails:
- Change actuator or sensor placement.
- Work with reduced‑order controllers/observers for the controllable/observable subspace.
- Convert the model to a controllable or observable canonical realization (e.g. using MATLAB’s compreal) and design there.

Quick MATLAB checks:
```
rank(ctrb(A,B))
rank(obsv(A,C))
```
Design notes:
- Use place(A,B,poles) for state‑feedback (after verifying controllability).
- For an observer use place(A',C',observer_poles)' (after verifying observability).

Always verify these ranks before attempting pole placement or observer synthesis to avoid unexpected failure or ill‑conditioned designs.



### Notes

- The Observable canononical realization used in `PPwithStateSpace.m` (via `compreal(sys,'o')`) is the standard Observable canonical form with the characteristic polynomial coefficients in the last row of $A$ and the numerator coefficients distributed in $B$ and $C$.
- Always check controllability before attempting arbitrary pole placement. The script demonstrates this with `ctrb()` and `obsv()` checks.
- If the original realization is not Observable, convert to a controllable/observable realization (for example using `compreal(sys,'o')` in MATLAB) before designing full-state feedback.
