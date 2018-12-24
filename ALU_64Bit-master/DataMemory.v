
module DataMemory(Address,DataInput,Clk,WriteMem,ReadMem,DataOutput);

	input[63:0] Address;
	input[63:0] DataInput;
        input WriteMem;
	input Clk;
	input ReadMem;
	output reg[63:0] DataOutput;

	reg[63:0] DataMemoryReg [0:31];
	parameter DATA = "DATAFiles/DataMemoryData.txt";
	initial
	begin
		$readmemh(DATA,DataMemoryReg);
	end
	
	always@(posedge Clk)
	begin 
		if(WriteMem == 1)
		begin
			DataMemoryReg[Address] <= DataInput;
		end
		else
		begin
			assign DataOutput = DataMemoryReg[Address];
		end	
	end
endmodule

