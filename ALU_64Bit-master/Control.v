
module Control(OPCode, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp, Clk);
	input[10:0] OPCode;
	input Clk;
	output reg  ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch;
	output reg[1:0] ALUOp;

	always @(posedge Clk)
	begin

		case(OPCode)
			//R-Format Instructions
			11'b1xx0101x000: 
			begin 
			  	assign ALUSrc = 1'b0;
			  	assign MemToReg = 1'b0;
			  	assign RegWrite = 1'b1;
				assign MemRead = 1'b0;
			  	assign MemWrite = 1'b0;
				assign Branch = 1'b0;
				assign ALUOp = 2'b10;
			end
			//LDUR Instruction
			11'b11111000010:
			begin

			  	assign ALUSrc = 1'b1;
			  	assign MemToReg = 1'b1;
			  	assign RegWrite = 1'b1;
				assign MemRead = 1'b1;
			  	assign MemWrite = 1'b0;
				assign Branch = 1'b0;
				assign ALUOp = 2'b00;
			end
			//STUR Instruction
			11'b11111000000:
			begin
			  	assign ALUSrc = 1'b1;
			  	assign MemToReg = 1'bx;
			  	assign RegWrite = 1'b0;
				assign MemRead = 1'b0;
			  	assign MemWrite = 1'b1;
				assign Branch = 1'b0;
				assign ALUOp = 2'b10;
			end
			11'b10110100xxx: begin // CBZ
			  	assign ALUSrc = 1'b0;
			  	assign MemToReg = 1'bx;
			  	assign RegWrite = 1'b0;
				assign MemRead = 1'b0;
			  	assign MemWrite = 1'b0;
				assign Branch = 1'b1;
				assign ALUOp = 2'b01;
			end
		endcase
	end
endmodule 