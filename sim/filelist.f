+incdir+../tb
+incdir+../RTL

// 1. Interface (MUST be defined before the package classes that use it)
../tb/interface.sv

// 2. Package (Defines classes: Driver, Monitor, Scoreboard, Transaction)
../tb/tb_pkg.sv

// 3. DUT
../RTL/Counter2bit.sv

// 4. Top testbench (Imports package and connects Interface/DUT)
../tb/tb_counter2bit.sv