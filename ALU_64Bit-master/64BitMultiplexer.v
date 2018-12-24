module Multiplexer_64Bit(A,B,Select,Result);

	input [63:0] A;
	input [63:0] B;
	input Select;
	output reg[63:0] Result;

	always @(A, B, Select)
	begin 
		case (Select)
			0 : assign Result = A; 
		        1 : assign Result = B;
		endcase 
	 end 
endmodule 
