module LeftShift(InputData, OutputData);
	input[63:0] InputData;
	output reg[63:0] OutputData;
	always @(InputData)
	begin
		assign OutputData = {InputData[63:2], 2'b00};
	end
endmodule
