---
aliases:
---

# Introduction to Hybrid Dynamical Systems

## What is a Hybrid Dynamical System?

>[!def] Definition:
>Hybrid dynamical systems contain heterogeneous dynamics that interact with each other and jointly determine the systems' behaviors over time. These include:
>- **Time-driven continuous-variable dynamics**: governed by physical laws, described by differential equations.
>- **Event-driven discrete-variable dynamics**: depend on "if-then-else" rules.

These two kinds of dynamics interact to generate complex behaviors such as switching when continuous variables pass thresholds and state jumping upon discrete events.

>[!example] Room Temperature Control System:
>A typical winter heating system with a thermostat set to 70°F demonstrates hybrid dynamics:
>- **Continuous dynamics**: furnace and heat flow characteristics of the room
>- **Discrete dynamics**: thermostat with "ON" and "OFF" states
>- **Interaction**: discrete state transitions are triggered by room temperature, while temperature evolution depends on the discrete state

Hybrid systems appear in many applications: manufacturing systems, chemical plants, traffic management, power grids, communication systems, and multi-robot control. They are also found in natural systems like gene regulatory networks where translation/transcription processes are continuous but gene activation is discrete.