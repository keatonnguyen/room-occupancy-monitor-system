Room Occupancy Monitoring System - COEN 313 Project
Description:

This project involves designing a room occupancy tracker using VHDL. It monitors the number of individuals in a room through two sensors placed at the entry and exit points. The system features a configurable maximum occupancy setting and activates an alert signal when this limit is exceeded. A reset function is included to reset the count back to zero.

Tools Used:
- ModelSim
- Vivado
- VHDL

Project Files:
                   
- Wave and Schematic files            -> Vivado schematics + wave
- VHDL codes                           -> VHDL code, tesbench
- logs (folders and files named Vivado) -> logs from vivado

Simulation Instructions:
Start by creating a new directory for your project with the mkdir name_of_file command. This will serve as the workspace for your VHDL files and related materials. After setting up your folder and writing your VHDL code, compile each file individually using the vcom command (e.g., vcom file1.vhd, vcom file2.vhd). Before simulation, initialize the working library with the vlib work command.

To begin the simulation, use the command vsim -novopt name_of_the_testbench to launch your testbench without optimizations. Inside ModelSim, load all signals into the waveform viewer using add wave *. Then, run the simulation for 450 nanoseconds with run 1000 ns. Following these steps ensures that your VHDL project is compiled, simulated, and visually analyzed effectively.

Synthesis Instructions:

1. Open Vivado and create a new project.
2. Add room.vhd as the top module.
4. Select the Nexys A7 FPGA board.
5. Run synthesis and implementation.
