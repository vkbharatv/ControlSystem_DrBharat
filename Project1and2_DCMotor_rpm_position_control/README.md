# DC Motor Control — STM32F446RE (Simulink + CubeMX)

## Project Overview

- Purpose: Preconfigured STM32CubeMX + Simulink project for DC motor speed and position control on an STM32F446RE.
- Includes: a CubeMX project file, Simulink models, and a MATLAB helper for encoder decoding.

## Files

- [dcm_pid/dcm_pid.ioc](dcm_pid/dcm_pid.ioc)
- [dsc_pid.slx](dsc_pid.slx) and [dsc_pid_2026a.slx](dsc_pid_2026a.slx)
- [encoder_read.m](encoder_read.m)

## Hardware Connections

- Motor driver outputs: connect the motor between M1-OUT1 and M2-OUT2 on the motor driver.
- Control signals wiring:

  - IN1 -> PA9
  - IN2 -> PC7
  - EN1 (PWM) -> PA8
- Encoder wiring:

  - Encoder A -> A0
  - Encoder B -> A1
  - Encoder VCC -> MCU VCC (3.3V recommended)
  - Encoder GND -> MCU GND

Simple pin mapping (for reference):

- Motor: M1-OUT1 / M2-OUT2 (motor driver)
- Direction IN1: PA9
- Direction IN2: PC7
- PWM (Enable): PA8 (timer PWM)
- Encoder A: A0 (timer CH)
- Encoder B: A1 (timer CH)
- Encoder VCC: 3.3V
- Encoder GND: GND

Notes:

- Ensure the encoder voltage matches STM32 3.3V logic levels.
- If encoder signals are noisy, add shielding, pull-ups, or filtering and consider input capture filtering in firmware.

## STM32CubeMX Setup (step-by-step)

If you want to modify the CubeMX configuration or verify the pin assignments, follow these steps:

1. Open the project file: [dcm_pid/dcm_pid.ioc](dcm_pid/dcm_pid.ioc).
2. In the Pinout view, verify the pins: PA8, PA9, PC7, A0, A1.
3. Peripherals to enable:
   - Configure a timer channel for PWM output on PA8 (set PWM frequency and polarity).
   - Configure PA9 and PC7 as GPIO outputs (push-pull) for direction control.
   - Configure a timer in Encoder Interface Mode for A0/A1 (set correct timer and channels).
4. Please ensure the timer settings (prescaler, period) match your motor and encoder specifications. The shared configuration usses a 32-bit timer for encoder counting and a separate timer for PWM generation.

## Simulink Integration (step-by-step)

1. Open dsc_pid.slx (or dsc_pid_2026a.slx) in MATLAB/Simulink.
2. Install required support packages: Simulink Coder, Embedded Coder, and Simulink Support Package for STMicroelectronics.
3. In the model: Model Settings → Hardware Implementation → select the STM32 target compatible with STM32F446RE.
4. (Optional) Import CubeMX pin configuration by pointing the hardware settings to [dcm_pid/dcm_pid.ioc](dcm_pid/dcm_pid.ioc) if supported by your toolchain.
5. Map encoder and PWM blocks to the same pins/timers used in CubeMX (A0/A1 → encoder timer, PA8 → PWM, PA9/PC7 → GPIO outputs).
6. Build the model (Generate Code) or use Deploy to Hardware to compile and flash via ST-Link.

## Build & Flash

- From STM32CubeIDE: build the generated project and use ST-Link to flash.
- From Simulink: use Deploy to Hardware (requires supported toolchain and ST-Link connection).

## Using the MATLAB helper

The file [encoder_read.m](encoder_read.m) converts raw encoder counts into angle and RPM. Example usage in MATLAB:

```matlab
% count: raw 32-bit encoder counter reading
% Ts: sample time in seconds
% CPR: counts per revolution
[angle_deg, angle_rad, speed_rpm] = encoder_angle(count, Ts, CPR);
```

Please note that the encoder counts may wrap around due to the 32-bit counter, so you may need to handle overflow/underflow in your application. You modify the helper function 2^32 to 2^16 if you are using a 16-bit timer for encoder counting.
