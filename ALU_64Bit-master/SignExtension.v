module SignExtension(Input, Output);
	input[31:0] Input;
	output reg[63:0] Output;

	reg ExtensionBit;
	wire InputOPCodeRecognizer =  Input[31:28];
	always @(Input)
	begin
		case(InputOPCodeRecognizer)
			//B-Type Instructions
			4'b0011:
			begin
				assign ExtensionBit = Input[25];
				assign Output = {{38{ExtensionBit}},Input[25:0]};
			end
			//CB-Type Instructions
			4'b1011:
			begin
				assign ExtensionBit = Input[23];
				assign Output = {{45{ExtensionBit}},Input[23:5]};
			end
			//D-Type Instructions
			4'b1111:
			begin
				assign ExtensionBit = Input[20];
				assign Output = {{55{ExtensionBit}},Input[20:12]};
			end
				
		endcase
	end
	
endmodule
