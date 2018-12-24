module InstructionMemory(Address, Instruction, Clock);
	input Clock;
	input[63:0] Address;
	output reg[31:0] Instruction;
	reg[31:0] InstructionMemoryReg [255:0];
	parameter DataFile = "DATAFiles/InstructionMemoryData.txt";
	initial
	begin
		$readmemh(DataFile,InstructionMemoryReg);
	end
	always @(posedge Clock)
	begin
		assign Instruction = InstructionMemoryReg[Address[9:2]];
	end
endmodule
