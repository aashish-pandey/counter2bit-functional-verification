A complete non-UVM SystemVerilog verification environment for a 2-bit up/down counter.

This project includes:

RTL implementation of a 2-bit synchronous up/down counter

SystemVerilog interface for clean connectivity

Driver generating synchronous stimulus

Monitor with internal reference model

Transaction object for signal capture

Scoreboard for automated checking

Fully timed testbench with clock generation

The environment uses synchronized stimulus and sampling (@(posedge clk)), modular testbench components, and a self-checking scoreboard — making it similar to real-world DV testbench structure without using UVM.