# Counter2bit Functional & UVM Verification (SystemVerilog)

## Overview

This project implements **two verification environments** for a **2-bit synchronous up/down counter**, developed using **SystemVerilog** and **Cadence Xcelium (`xrun`)**:

1. **A lightweight, UVM-inspired functional testbench**
2. **A full UVM-based verification environment**

The project is intentionally structured to demonstrate a **progressive verification learning path** — moving from manual transaction-based verification to an **industry-standard UVM methodology**.

The focus is on **verification correctness, timing accuracy, and architecture clarity**, rather than DUT complexity.

---

## Design Under Test (DUT)

### Counter Specification
- **Width:** 2-bit
- **Type:** Synchronous up/down counter
- **Inputs:**
  - `clk` – clock
  - `reset` – synchronous reset
  - `up_down` – direction control  
    - `1` → count up  
    - `0` → count down
- **Output:**
  - `count` – 2-bit output
- **Behavior:**
  - Updates on rising clock edge
  - Wrap-around behavior (modulo-4)

---

## Verification Objectives

- Verify correct up/down counting
- Validate wrap-around behavior
- Detect corner cases during **direction changes**
- Model **cycle-accurate synchronous behavior**
- Compare **manual testbench vs UVM-based verification**

---

## Project Directory Structure

```
COUNTER2BIT-FUNCTIONAL-VERIFICATION/
│
├── RTL/
│   └── Counter2bit.sv
│
├── tb/                     # Lightweight functional testbench
│   ├── interface.sv
│   ├── Transaction.sv
│   ├── driver.sv
│   ├── monitor.sv
│   ├── Scoreboard.sv
│   ├── tb_pkg.sv
│   └── tb_counter2bit.sv
│
├── uvm_tb/                 # Full UVM-based testbench
│   ├── my_item.sv
│   ├── my_sequence.sv
│   ├── my_sequencer.sv
│   ├── my_driver.sv
│   ├── my_monitor.sv
│   ├── my_scoreboard.sv
│   ├── my_agent.sv
│   ├── my_env.sv
│   ├── my_test.sv
│   └── top.sv
│
├── sim/
│   ├── filelist.f
│   ├── uvm_filelist.f
│   ├── run.sh
│   ├── uvm_run.sh
│   ├── xrun.log
│   ├── xrun.history
│   ├── xrun.key
│   └── xcelium.d/
│
├── xcelium.d/
│
└── README.md
```

---

## Verification Methodology

### 1. Lightweight Functional Testbench (`tb/`)

This environment is **UVM-inspired but manually implemented** to reinforce verification fundamentals.

#### Concepts Practiced
- Transaction abstraction without UVM
- Driver / Monitor separation
- Passive monitoring
- Golden reference modeling
- Explicit handling of **one-cycle latency**

#### Component Overview

- **interface.sv**  
  Bundles DUT signals for clean connectivity.

- **Transaction.sv**  
  Encapsulates stimulus and expected behavior.

- **driver.sv**  
  Applies synchronous stimulus to the DUT.

- **monitor.sv**  
  Observes DUT behavior and captures:
  - current count
  - previous count
  - previous direction

- **Scoreboard.sv**  
  Implements a cycle-accurate golden model and reports PASS/FAIL results.

This environment intentionally avoids UVM automation to make timing behavior **explicit and transparent**.

---

### 2. UVM Testbench (`uvm_tb/`)

A **complete UVM verification environment** following standard UVM architecture and flow.

#### UVM Architecture

- **my_item.sv** – Sequence item representing counter transactions
- **my_sequence.sv** – Generates directed stimulus
- **my_sequencer.sv** – Arbitrates sequence execution
- **my_driver.sv** – Drives transactions onto the DUT
- **my_monitor.sv** – Passively samples DUT behavior
- **my_scoreboard.sv** – Implements cycle-accurate reference model
- **my_agent.sv** – Encapsulates driver, monitor, and sequencer
- **my_env.sv** – Integrates agent and scoreboard
- **my_test.sv** – Configures and runs the UVM test
- **top.sv** – Top-level module instantiating DUT and launching `run_test()`

---

## Simulation Flow

### Functional Testbench
```bash
cd sim
./run.sh
```

### UVM Testbench
```bash
cd sim
./uvm_run.sh
```

- Compilation controlled via `filelist.f` and `uvm_filelist.f`
- Simulation executed using **Cadence Xcelium (`xrun`)**
- Logs stored in `xrun.log`

---

## Key Verification Insight

### Direction Change Corner Case

A subtle failure was observed **only when the `up_down` signal changed**.

**Root Cause:**  
In synchronous designs, outputs depend on **previous-cycle inputs**.

**Incorrect Modeling:**  
Predicting output using the current value of `up_down`.

**Correct Modeling:**  
The scoreboard tracks and uses:
- `prev_count`
- `prev_up_down`

This fix is implemented consistently in **both** the functional and UVM testbenches.

---

## Tools Used

- **Language:** SystemVerilog
- **Methodology:** Functional Verification + UVM
- **Simulator:** Cadence Xcelium (`xrun`)
- **Editor:** VS Code
- **Platform:** Linux / macOS

---

## Future Enhancements

- SystemVerilog Assertions (SVA)
- Functional coverage
- Constrained-random sequences
- Parameterized counter width
- Regression automation
- Reusable scoreboard infrastructure

---

## Author

**Aashish Pandey**  
MS in Computer Engineering  
Focus: RTL Verification (UVM), Digital Design, Hardware Security
