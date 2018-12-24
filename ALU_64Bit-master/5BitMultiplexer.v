module Multiplexer_5Bit(A,B,Select,Result);

	input [4:0] A;
	input [4:0] B;
	input Select;
	output reg[4:0] Result;

	always @(A, B, Select)
	begin 
		case (Select)
			0 : assign Result = A; 
		        1 : assign Result = B;
		endcase 
	 end 
endmodule 