---
aliases:
title: Homework 2 Part 2
---

| **Course**        | Microprocessor Based Product Design |
| ----------------- | ----------------------------------- |
| **Course Number** | 00340032                            |

| Ido Fang Bentov                | Nir Karl                       |
| ------------------------------ | ------------------------------ |
| 322869140                      | 322437203                      |
| ido.fang@campus.technion.ac.il | nir.karl@campus.technion.ac.il |

Station Number: **8**
Battery Number: **10**
Team Number: **#1**

>[!notes] Notes: 
 >All videos and code are supplied with the `.pdf`.

<div><hr><hr></div>

## 1. SISO Velocity Control

### 1.1 System Identification

We recorded motor step responses by applying a square wave PWM signal ($\pm4400$ PWM, corresponding to approximately $\pm5.3V$) to all four wheels while the cart was suspended on a block. The encoder data was captured at $\pu{100 Hz}$.

![[MCP1_HW002P2/HW002P2_code/MATLAB/p2/record_data.png|bookhue|600]]^figure-record-data
>Recorded data of the four motors response to a square wave PWM signal.

The recorded data shows all four motors responding to the square wave input. We observe:
- Motors 1 and 4 have similar positive responses
- Motors 2 and 3 have inverted responses (due to their mounting orientation)
- All motors reach steady-state within approximately $0.1$ to $0.15$ seconds

### 1.2 Model Fitting

We fitted a first-order transfer function model to each motor:
$$G(s) = \frac{K}{\tau s + 1}$$

where $K$ is the DC gain (rad/s per Volt) and $\tau$ is the time constant.

![[MCP1_HW002P2/HW002P2_code/MATLAB/p2/system_id_results.png|bookhue|600]]^figure-system-identification-results
>System identification results for the four motors.

**Identified Parameters (averaged across motors):**

| Parameter              | Value                         |
| ---------------------- | ----------------------------- |
| $K$ (DC Gain)          | $~\pu{5.7 rad.s^{-1}.V^{-1}}$ |
| $\tau$ (Time Constant) | $~\pu{0.08s^{-1}}$            |


The bottom-left plot shows excellent agreement between the fitted model (dashed red) and measured response (solid blue) for a $\pu{10V}$ step input ($-\pu {5V }$ to $+\pu {5V }$).

### 1.3 PI Controller Design

Based on the identified model, we designed a PI controller to achieve the specified performance:
- **Rise time**: $\pu{\sim0.15 s}$ to $95\%$ of steady-state value
- **Target step command**: $\pu {14 rad.s^{-1} }$

**Design Approach:**
Using pole placement for a desired damping ratio $\zeta = 0.7$ and natural frequency derived from the rise time specification, we calculated:

| Parameter | Calculated Value | Used Value |
| --------- | ---------------- | ---------- |
| $k_p$     | $0.10$           | **3.2**    |
| $k_i$     | $1.478$          | **10.2**   |
> **Note:** In practice, we used higher $k_p$ and $k_i$ values than the calculated ones to achieve better tracking performance and faster disturbance rejection. The simulated closed-loop response (bottom-right plot) shows the expected behavior with the calculated gains.

### 1.4 Simulation vs Measured Comparison

The simulated closed-loop step response demonstrates:
- Rise time: $\sim\pu{0.15s}$ (meets specification)
- Minimal overshoot ($\sim5\%$)
- Zero steady-state error (due to integral action)


---

## 2. Cart Kinematics Control

### 2.1 Kinematics Implementation

We implemented Mecanum wheel inverse kinematics to convert cart velocities $(v_x, v_y, \omega_z)$ to individual wheel angular velocities:

$$\begin{bmatrix} \omega_{RR} \\ \omega_{RL} \\ \omega_{FL} \\ \omega_{FR} \end{bmatrix} = \frac{1}{r} \begin{bmatrix} 1 & -1 & (L+W) \\ 1 & 1 & -(L+W) \\ 1 & -1 & -(L+W) \\ 1 & 1 & (L+W) \end{bmatrix} \begin{bmatrix} v_x \\ v_y \\ \omega_z \end{bmatrix}$$

where:
- $r = 0.03$ m (wheel radius)
- $L = 0.095$ m (half wheelbase)
- $W = 0.08$ m (half track width)

**Coordinate System:**
- $+v_x$ = forward (front of cart)
- $+v_y$ = left
- $+\omega_z$ = counter-clockwise rotation

### 2.2 Real-Time Control via UART

We developed a MATLAB GUI (`kinematics_gui.m`) for real-time control:

```
Commands sent via UART:
  vel <vx> <vy> <wz>    - Set cart velocities
  state 6               - Enable kinematics mode
```

---

## 3. Trajectory Following Control

### 3.1 Implementation Overview

Trajectory following uses **TIM5 Output Compare** for adaptive timing. The trajectory data (generated in MATLAB) consists of:
- `vx_t[]`, `vy_t[]`, `wz_t[]`: Cart velocities at each point
- `tt_clk[]`: Time deltas in timer clock counts (17 MHz)

The Output Compare interrupt fires at each trajectory point, updating the velocity references. This allows non-uniform time spacing - slowing down at high curvature sections and speeding up on straight sections.

### 3.2 Figure-8 Trajectory

We generated a figure-8 (lemniscate) trajectory with curvature-based adaptive speed profile:

$$x(t) = A \sin(t), \quad y(t) = A \sin(t) \cos(t)$$

![[figure_8_trajectory.png|bookhue|600]]^figure-figure-8-trajectory
>Figure-8 trajectory.

**Trajectory Parameters:**
- Size: $\pu {2m } \times \pu {1m }$
- Duration: $30$ seconds
- Speed range: $30$ to $\pu{200mm.s^{-1}}$
- Points: $100$

The speed profile shows the cart slowing down at the center crossing (high curvature, $\kappa \approx 4.5\pu{ m^{-1}}$) and speeding up on the outer loops (low curvature).

### 3.3 Custom Rectangle Trajectory

We implemented interactive point selection in MATLAB, allowing the user to click corner points that are then connected with Catmull-Rom splines for smooth corners.

![[custom_rect_trajectory.png|bookhue|600]]^figure-custom-rect-trajectory
>Custom rectangle trajectory.

**Trajectory Parameters:**
- Size: $\sim \pu {1m }\times\pu {1.5m }$ (user-defined)
- Duration: $30$ seconds
- Control points: 5 (4 corners + return)

The spline interpolation creates smooth velocity transitions at corners, visible in the speed profile spikes where the cart briefly accelerates through the corner curves.

---

## 4. Obstacle Avoidance

### 4.1 Implementation

The proximity sensor on PA7 is polled in the main loop. When an obstacle is detected:

1. The `obstacle_detected` flag is set
2. In the TIM15 control loop interrupt:
   - If in `STATE_TRAJECTORY` or `STATE_KINEMATICS` mode
   - And `obstacle_stop_enabled` is true
   - All wheel references are set to zero (cart stops)
3. When the obstacle is removed, the trajectory **resumes** from where it paused

```c
void check_obstacle(void) {
    pSensor = HAL_GPIO_ReadPin(GPIOA, GPIO_PIN_7);
    obstacle_detected = (pSensor == 0) ^ sensor_sign;
    HAL_GPIO_WritePin(GPIOA, GPIO_PIN_5, obstacle_detected);  // LED feedback
}
```

### 4.2 Demonstration

The cart was tested during trajectory following:
1. Cart follows figure-8 trajectory
2. Hand placed in front of sensor
3. Cart stops immediately
4. Hand removed
5. Cart resumes trajectory


---

## Appendix A: Hardware Configuration

### A.1 Motor Sign Configuration

Due to physical mounting orientation, motors may spin in opposite directions for the same PWM polarity. The `motor_sign[]` array in `main.c` corrects this:

```c
int16_t motor_sign[4] = {1, -1, -1, 1};  // {RR, RL, FL, FR}
```

**To calibrate:**
1. Set all motors to a positive PWM (e.g., `pwm 3000 3000 3000 3000`)
2. Observe which wheels spin backward
3. Flip the sign for those motors (change `1` to `-1` or vice versa)
4. Verify: positive PWM should make all wheels spin forward

### A.2 Sensor Sign Configuration

The proximity sensor may have inverted logic depending on the specific sensor model. The `sensor_sign` variable adjusts this:

```c
int8_t sensor_sign = 1;  // Set to -1 if sensor logic is inverted
```

**To calibrate:**
1. Place hand in front of sensor
2. If LED (PA5) turns **on** when obstacle is present → `sensor_sign = 1`
3. If LED turns **off** when obstacle is present → `sensor_sign = -1`

---

## Appendix B: UART Command Reference

Communication is via UART at $\pu{115200 baud}$. Commands are terminated with CR (`\r`).

### B.1 State Control

| Command | Description |
| ------- | ----------- |
| `state 1` | IDLE - Motors off |
| `state 2` | PWM - Direct PWM control |
| `state 3` | SQUARE - Record square wave response |
| `state 5` | VELOCITY - Closed-loop velocity control |
| `state 6` | KINEMATICS - Cart velocity control $(v_x, v_y, \omega_z)$ |
| `state 7` | TRAJECTORY - Follow pre-loaded trajectory |

### B.2 Motion Commands

| Command | Description |
| ------- | ----------- |
| `pwm <d0> <d1> <d2> <d3>` | Set PWM directly ($-9999$ to $+9999$) |
| `ref <r0> <r1> <r2> <r3>` | Set velocity references (encoder counts/sample) |
| `vel <vx> <vy> <wz>` | Set cart velocities (m/s, m/s, rad/s) - auto-enters `state 6` |

### B.3 Trajectory Control

| Command | Description |
| ------- | ----------- |
| `traj start` | Start trajectory execution (enters `state 7`) |
| `traj stop` | Stop trajectory, return to IDLE |

### B.4 Configuration & Debug

| Command | Description |
| ------- | ----------- |
| `gains <kp> <ki>` | Set PI controller gains |
| `obstacle on` | Enable obstacle stop (default) |
| `obstacle off` | Disable obstacle stop |
| `status` | Show current mode and parameters |
| `enc` | Show encoder values and velocities |
| `send` | Transmit recorded data (binary) |
| `help` | Show command list |

### B.5 Typical Usage Workflow

**For kinematics testing:**
```
vel 0.1 0 0      # Move forward at 0.1 m/s
vel 0 0.1 0      # Move left at 0.1 m/s  
vel 0 0 1.0      # Rotate CCW at 1 rad/s
vel 0 0 0        # Stop
```

**For trajectory execution:**
```
traj start       # Start pre-loaded trajectory
                 # (trajectory runs automatically)
traj stop        # Emergency stop if needed
```


