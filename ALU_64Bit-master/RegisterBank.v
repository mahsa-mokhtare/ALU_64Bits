module RegisterBank(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2);
	
	input[0:4] ReadRegister1,ReadRegister2,WriteRegister;
	input[63:0] WriteData;
	input RegWrite,Clk;
	
	output reg[63:0] ReadData1,ReadData2;
	reg[63:0] RegisterData [31:0];
	parameter DATA = "DATAFiles/RegisterBankData.txt";
	initial
	begin
		$readmemh(DATA,RegisterData);
	end
	
	always @(posedge Clk)
		begin
	
			if(RegWrite == 1)
			begin 
				RegisterData[WriteRegister] <= WriteData;
			end 
			else 
			begin 
				 ReadData1 = RegisterData[ReadRegister1];
	                         ReadData2 = RegisterData[ReadRegister2];
			end 
		end  

		
endmodule 