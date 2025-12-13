# Counter2bit Functional Verification (SystemVerilog)

## Overview

This project implements a **functional verification environment** for a **2-bit up/down synchronous counter** using **SystemVerilog** and a **UVM-inspired, lightweight testbench architecture**.  
The goal of this project is not to use full UVM, but to build a strong understanding of **core verification fundamentals**, including:

- Transaction-based stimulus generation
- Driver–Monitor separation
- Scoreboard-based checking
- Cycle-accurate modeling of synchronous logic
- Debugging direction-change corner cases

Simulation is performed using **Cadence Xcelium (`xrun`)**.

---

## Design Under Test (DUT)

### Counter Description
- **Width:** 2-bit  
- **Type:** Synchronous up/down counter  
- **Inputs:**
  - `clk` – clock
  - `reset` – synchronous reset
  - `up_down` – direction control  
    - `0` → count down  
    - `1` → count up
- **Output:**
  - `count` – 2-bit counter value
- **Behavior:**
  - Counter updates on the rising edge of the clock
  - Wrap-around behavior (modulo-4)

---

## Verification Methodology

The testbench follows a **layered verification architecture**, inspired by UVM but implemented manually for clarity and learning purposes.

### Concepts Practiced
- Clock-synchronous stimulus application
- Transaction abstraction
- Passive monitoring
- Golden-model-based scoreboarding
- Handling one-cycle latency during control signal changes

---

## Project Directory Structure

```
COUNTER2BIT-FUNCTIONAL-VERIFICATION/
│
├── RTL/
│   └── Counter2bit.sv
│
├── tb/
│   ├── interface.sv
│   ├── Transaction.sv
│   ├── driver.sv
│   ├── monitor.sv
│   ├── Scoreboard.sv
│   ├── tb_pkg.sv
│   └── tb_counter2bit.sv
│
├── sim/
│   ├── filelist.f
│   ├── run.sh
│   ├── xrun.log
│   ├── xrun.history
│   ├── xrun.key
│   └── xcelium.d/
│
├── xcelium.d/
│   └── worklib/
│
└── README.md
```

---

## Testbench Components

### RTL
- **Counter2bit.sv**  
  Implements the 2-bit synchronous up/down counter.

---

### Testbench (`tb/`)

#### interface.sv
Defines a SystemVerilog interface bundling all DUT signals.  
Improves connectivity and keeps driver and monitor logic clean.

---

#### Transaction.sv
Defines a transaction object representing a single stimulus event.  
Used to pass information between testbench components.

---

#### driver.sv
- Drives stimulus onto the DUT via the interface
- Applies `up_down` changes in a clock-aware manner
- Responsible only for driving signals (no checking)

---

#### monitor.sv
- Passively observes DUT signals
- Captures current count, previous count, and direction
- Sends observed data to the scoreboard

---

#### Scoreboard.sv
- Implements a golden reference model
- Predicts expected counter values based on:
  - Previous count
  - **Previous direction**
- Compares predicted values with DUT output
- Reports PASS/FAIL messages with full context

A key learning point is correctly handling the **direction-change cycle**, where the counter behavior depends on the previous value of `up_down`, not the current one.

---

#### tb_pkg.sv
Central package file containing shared definitions and imports for the testbench.

---

#### tb_counter2bit.sv
Top-level testbench module:
- Instantiates DUT and all testbench components
- Generates clock and reset
- Controls simulation flow

---

## Simulation Flow

1. All files are compiled using `filelist.f`
2. Simulation is launched using `xrun` via `run.sh`
3. Results are logged in `xrun.log`
4. Compiled simulation artifacts are stored in `xcelium.d/`

---

## Key Verification Insight

### Direction Change Corner Case

A common failure observed during development occurred only when the `up_down` signal changed.

**Root Cause:**  
In synchronous designs, outputs update based on **previous-cycle inputs**.  
Using the current value of `up_down` to predict the current output leads to a one-cycle mismatch.

**Resolution:**  
The scoreboard models hardware behavior accurately by tracking and using:
- `prev_count`
- `prev_up_down`

---

## Tools Used

- **Language:** SystemVerilog
- **Simulator:** Cadence Xcelium (`xrun`)
- **Editor:** VS Code
- **Platform:** Linux / macOS

---

## Future Enhancements

- Add SystemVerilog Assertions (SVA)
- Introduce constrained-random stimulus
- Add functional coverage
- Parameterize counter width
- Migrate to full UVM environment

---

## Author

**Aashish Pandey**  
MS in Computer Engineering  
Focus: Digital Design, RTL Verification, Hardware Security
