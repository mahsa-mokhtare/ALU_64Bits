module Mips_CPU(Clk);
	input Clk;
	wire[63:0] 	pc_result,//Program Counter Output

			rb_out2_ex_mem_input,rb_out2_ex_mem_output,rb_out1,//Register Bank Outputs

			rb_alu_mux,//Output Of Register Bank To ALU Multiplexer
			alu_result_ex_mem_input,//Output of ALU
			alu_result_ex_mem_output,//output of Alu
			
			dm_out,//Output of Data Memory
			


			dm_rb_mux,//Output Of Data Memory To Register Bank Multiplexer
			se_out,//Sign Extension Output
			ls_out,//Left Shift Output
			pc_adder_res,//Program Counter Next-Instruction Adder Output
			adder_pc_mux_out,//Adder To Program Counter Multiplexer Output
			shift_adder_result_ex_mem_input,//Shift Adder Result
			shift_adder_result_ex_mem_output;

	wire[31:0]	instruction;//Output Of Instruction Memory


	wire[4:0]	im_regbank_mux_out;//Output of Instruction Memory Multiplexer

	wire 	z_result_ex_mem_input, //Zero Bit of ALU
		z_result_ex_mem_output, 

		cu_opcode, cu_alusrc, cu_memtoreg, cu_regwrite, cu_memread, cu_memwrite, cu_branch;//Control Unit Wires
	
	wire[1:0] cu_aluop;//Control Unit ALUOp Wire

	wire[3:0] aluc_op;//ALU Controller Output
	
	//Program Counter Connections
	ProgramCounter PC(adder_pc_mux_out, pc_result, Clk);

	//Instruction Memory Connections
	InstructionMemory IM(pc_result, instruction, Clk);

	//Instruction Memory To Resgister Bank Multiplexer Connections
	Multiplexer_5Bit IMToRegisterBankMux(instruction[20:16], instruction[4:0], instruction[28], im_regbank_mux_out);

	//Register Bank Connections
	RegisterBank RB(instruction[9:5], im_regbank_mux_out, instruction[4:0], dm_rb_mux, cu_regwrite, Clk, rb_out1, rb_out2);

	//Register Bank to ALU Multiplexer Connections
	Multiplexer_64Bit RBToALUMux(rb_out2, se_out, cu_alusrc, rb_alu_mux);

	//ALU Connections
	ALU Alu(rb_out1 , rb_alu_mux, aluc_op, alu_result_ex_mem_input, z_result_ex_mem_input);

	//Ex/MEM Register
	Ex_mem_register emr(alu_result_ex_mem_input,z_result_ex_mem_input,shift_adder_result_ex_mem_input,,,rb_out2_ex_mem_input,,alu_result_ex_mem_output,z_result_ex_mem_output,shift_adder_result_ex_mem_output,,,rb_out2_ex_mem_output,);

	//Data Memory Connection
	DataMemory dm(alu_result_ex_mem_output, rb_out2_ex_mem_input, Clk, cu_memwrite, cu_memread, dm_out);
	
	
	
	//Data Memory To Register Bank Multiplexer
	Multiplexer_64Bit DMToRBMux(alu_result, dm_out, cu_memtoreg ,dm_rb_mux);

	//Sign Extension Connections
	SignExtension SE(instruction, se_out);

	//Shift Left Connections
	LeftShift LS(se_out, ls_out);

	//Program Counter Next-Instruction Adder connections
	ALU PCAdder(pc_result, 4, 4'b0010, x, pc_adder_res);
	
	//Adder To Program Counter Multiplexer Connections
	Multiplexer_64Bit AddToPCMux(pc_adder_res, shift_adder_result_ex_mem_output, cu_branch&z, adder_pc_mux_out);

	//Shift Adder Connections
	ALU ShiftAdder(pc_result, ls_out, 4'b0010, x, shift_adder_result_ex_mem_input);

	//Control Unit Connections
	Control CU(cu_opcode, cu_alusrc, cu_memtoreg, cu_regwrite, cu_memread, cu_memwrite, cu_branch, cu_aluop, Clk);

	//ALU Controller Connections
	ALUControl ALUC(cu_aluop, instruction[31:21], aluc_op);
	
	
endmodule
