# ControlSystem_DrBharat

Teaching repository for Control Systems by Dr. Bharat

This repository contains MATLAB and Simulink examples, live scripts, and helper functions used in lectures and assignments.

## Repository layout

- `CompensationDesign/` — Compensator design examples and a live script:
   - `Compensator_Design.mlx` (live script walkthrough)
   - `gmpm_calc.m` (helper calculations)
   - `README.md` (folder-specific notes)
- `PIDControllerDesign/` — PID design examples and utilities:
   - `GainCalculationWithPP.m` (script demonstrating gain calculation)
   - `PID_poleplacement.mlx` (live script)
   - `README.md`
- `StateSpace Pole Placement/` — State-space pole placement examples:
   - `PPwithStateSpace.m` (script)
   - `StateSpacePP.mlx` (live script)
   - `README.md`
- `FeedbackControlwith Observer/` — Feedback control with observer design:
   - `GainCalculate.mlx` (live script for gain calculations)
- `Python Implementation/` — Python implementations of control system examples:
   - `Compensation_Design.ipynb` (Jupyter notebook)
   - `PID_ControllerDesign.ipynb` (Jupyter notebook)
   - `stateFeddback_withObserver.ipynb` (Jupyter notebook)
   - `statespacePolePlacement.ipynb` (Jupyter notebook)

## Quick start

1. Open MATLAB and set the current folder to the repository root, or add the repository to your MATLAB path.
2. Open one of the live scripts (`*.mlx`) for an interactive walkthrough, or run the example scripts (`*.m`) from the MATLAB command window. Examples:

    - Open `CompensationDesign/Compensator_Design.mlx` and run sections interactively.
    - From the command window: run `run('PIDControllerDesign/GainCalculationWithPP.m')` to execute the PID gain script.

3. If you use Simulink models (not included here), ensure Simulink is installed and licensed.

### Python Implementation

The `Python Implementation/` folder contains Jupyter notebooks that replicate the MATLAB examples using Python with control system libraries (such as `control`). To use these:

1. Ensure you have Python installed with Jupyter Notebook/Lab.
2. Install required packages: `pip install numpy scipy matplotlib control jupyter`
3. Navigate to the `Python Implementation/` folder and launch Jupyter: `jupyter notebook`
4. Open any of the `.ipynb` notebooks and run the cells interactively.


## License / Usage

This material is provided for education and research use only. If you need different licensing terms, contact the repository owner.
