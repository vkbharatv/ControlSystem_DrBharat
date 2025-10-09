# Control System — Dr. Bharat Verma

This repository contains MATLAB code, live scripts and notes for control system design and compensator synthesis created by Dr. Bharat Verma. The materials are intended for teaching, research and engineering experimentation in classical control (frequency-domain design, root-locus, phase/gain margin calculations, compensator design) and serve as reproducible examples for students and practitioners.

## Contents

- `gmpm_calc.m` — MATLAB script for computing gain margin, phase margin and plotting frequency-response based analyses. Primary utility for quick Bode-based design checks.
- `Compensator_Design.mlx` — MATLAB Live Script (interactive) that demonstrates step-by-step compensator design workflows, plots and annotated results.
- `Compensation_Design.pdf` — Printable notes / report describing the design theory, examples and derivations used alongside the code.
- `README.md` — This file.

## Goals

- Provide compact, reproducible MATLAB examples for classical compensator design.
- Offer interactive live-script material for students to follow and modify.
- Keep analysis and plotting scripts simple so they can be adapted to various plant models.

## Requirements

- MATLAB (recommended R2019b or later). The code uses basic Control System Toolbox functions; verify the following toolboxes are available in your MATLAB installation:
  - Control System Toolbox (for bode, margin, tf, etc.)
  - (Optional) Signal Processing Toolbox for extra utilities

If you do not have MATLAB, you can inspect the code for algorithms (educational purposes), but running the scripts requires MATLAB.

## Quick start

Open the repository folder in MATLAB, or from your system shell you can run scripts using MATLAB's batch or -r option.

Examples (PowerShell / Windows):

```powershell
# Start MATLAB desktop from the current folder (if MATLAB is on PATH)
matlab

# Run the gmpm_calc script non-interactively and exit MATLAB afterwards
matlab -r "try, run('gmpm_calc.m'), catch e, disp(getReport(e)), end, exit"

# Alternatively, use -batch (R2019a+) which suppresses desktop and returns when done
matlab -batch "run('gmpm_calc.m')"
```

Notes:
- When running from MATLAB desktop, open `Compensator_Design.mlx` to step through the live script. Live scripts show figures inline and include explanatory text and formulas.
- Ensure the current working folder in MATLAB is the repository root (where `gmpm_calc.m` resides) or provide full paths to files in the run commands.

## How to use `gmpm_calc.m`

`gmpm_calc.m` is a compact script that:

- Loads or defines a plant transfer function (edit the script to set your plant model).
- Plots Bode magnitude and phase.
- Computes and prints gain margin (GM), phase margin (PM), and the corresponding frequencies.

Typical workflow:

1. Edit the plant definition block at the top of `gmpm_calc.m` to match your system.
2. Run the script in MATLAB (use the examples above for command-line execution).
3. Inspect the printed margins and the Bode plot to guide compensator selection.

If you want the script to return values to the workspace, modify it to wrap calculations into a function (e.g., `function [GM,PM,wg,wp] = gmpm_calc(sys)`), which makes it easier to call programmatically.

## Notes on `Compensator_Design.mlx` and `Compensation_Design.pdf`

- `Compensator_Design.mlx` is an interactive live script with annotated steps. Use it for instructional demonstrations — modify plant parameters and re-run cells to see updated plots.
- `Compensation_Design.pdf` is a static document intended to accompany the live script and provide theory and worked examples.

## Example: turning the script into a reusable function

If you plan to call margin calculations from other scripts, refactor `gmpm_calc.m` into a function with a clear contract. Example contract:

- Inputs: a SISO LTI system (`tf` or `ss`), optional plot flag.
- Outputs: gain margin (GM, dB), phase margin (PM, deg), and crossover frequencies.

Edge cases to handle:

- Unstable plants (inform the user and optionally compute margins of the open-loop transfer function).
- Systems without clear crossovers (report NaN and show plot annotations).
- Very high-order systems (use sufficiently dense frequency grid for Bode computations).

## Contribution

Contributions are welcome. Suggested small improvements:

- Add a function-style API version of `gmpm_calc.m` with unit tests.
- Provide sample plant files and expected results (regression tests).
- Add a simple script to automatically generate figures used in `Compensator_Design.mlx`.

Please open an issue or submit a pull request. When opening PRs, include a short description and, if appropriate, a small test or example demonstrating the change.

## License & attribution

No license file is included in this repository. If you want others to reuse this code permissively, consider adding an OSI-approved license such as MIT or BSD. Contact the repository owner to confirm licensing intentions before reuse.

## Contact

For questions about the content or to request permission for reuse, contact Dr. Bharat Verma (check the repository host profile or the project owner for contact details).
