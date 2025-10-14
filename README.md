# ControlSystem_DrBharat

Repository for MATLAB/Simulink examples and teaching material for CSE2025 — Control Systems (Dr. Bharat).

Contents
- `CompensationDesign/` — scripts and live scripts for compensator design.
- `PIDControllerDesign/` — PID design examples and helper scripts (e.g. `GainCalculationWithPP.m`).

Requirements
- MATLAB (R2018b or newer recommended). Some plotting option names changed across releases; the code includes guards for compatibility.
- Control System Toolbox (for `tf`, `pid`, `nyquistplot`, `margin`, etc.).

Quick start
1. Open MATLAB and set the current folder to the repository root (or add the repository to the MATLAB path).
2. Open and run the example scripts, for example:

   - `CompensationDesign/Compensator_Design.mlx`
   - `PIDControllerDesign/GainCalculationWithPP.m`

Notes

- If you encounter any plotting option errors (unrecognized properties in `nyquistoptions`), update your MATLAB release or open an issue describing your MATLAB version and the exact error.

Contributing
- Please open issues or pull requests with small, focused changes. Include MATLAB version and toolbox list when reporting bugs.

License
- For the education and research purpose only.
