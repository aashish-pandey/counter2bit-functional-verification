// ../tb/tb_pkg.sv

// 1. Data Structures (Must come first, as they are used as types everywhere)
`include "Transaction.sv" 

// 2. High-Level Components that need to be defined early (e.g., Scoreboard)
// Since 'Monitor' uses 'Scoreboard', 'scoreboard.sv' must come before 'monitor.sv'.
`include "Scoreboard.sv" 

// 3. Remaining components
`include "driver.sv"
`include "monitor.sv" 

package tb_pkg;
  // No content needed here if only includes are used
endpackage : tb_pkg