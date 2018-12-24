module ALUControl(ALUOp, OPCode, Operation);
	input[1:0] ALUOp;
	input[10:0] OPCode;
	output reg[3:0] Operation;
	always @(ALUOp, OPCode)
	begin
		case(ALUOp)
			2'b1x:
			begin
				case(OPCode)
					11'b10001011000: assign Operation = 4'b0010;
					11'b11001011000: assign Operation = 4'b0110;
					11'b10001010000: assign Operation = 4'b0000;
					11'b10101010000: assign Operation = 4'b0001;
				endcase
			end
			2'b00: assign Operation = 4'b0010;
			2'bx1: assign Operation = 4'b0111;
		endcase				
	end
endmodule
