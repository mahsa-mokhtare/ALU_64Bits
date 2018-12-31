#Pipeline Processor 
mips-cpu
#Description
An implementation of a MIPS CPU written in Verilog. This project is in very early stages and currently only implements the most basic functionality of a MIPS CPU that shows in the picture.
![alt text](http://s8.picofile.com/file/8347470976/pipeline.png)

PC The PC gives the address for the next instruction. On a rising clock edge (hence the single-cycle CPU), it outputs the next address it has stored.
 
Adder This is meant to increment the address from the PC, so it can fetch the next instruction.

Instruction memory This is meant to simulate the physical memory or cache where instructions are stored.
 
Control unit The control unit takes in an instruction and parses it to output appropriate control signals. It outputs which operation the ALU should do, whether or not the data to the ALU should come from register b or the imm_data (it sends the control signal to the ALU mux), the immediate data (for the branch mux), and if the operation is a branch or not (for the branch-and-gate).
ALU The ALU module acts as the primary arithmetic unit for the CPU.
