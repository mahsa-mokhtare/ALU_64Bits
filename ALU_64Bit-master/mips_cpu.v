module Mips_CPU(Clk);
	input Clk;
	wire[63:0] 	pc_result_if_id_input,//Program Counter Output
			pc_result_if_id_output,
			
			pc_result_if_id_output_id_ex_input,
			pc_result_if_id_output_id_ex_output,

			rb_out1_id_ex_input,
			rb_out2_id_ex_input,//Register Bank Outputs
			rb_out1_id_ex_output,
			rb_out2_id_ex_output,
			rb_out2_id_ex_output_ex_mem_output,

			rb_alu_mux,//Output Of Register Bank To ALU Multiplexer
			alu_result_ex_mem_input,//Output of ALU
			alu_result_ex_mem_output,//output of Alu
			alu_result_ex_mem_output_mem_wb_output,
			
			dm_result_mem_wb_input,//Output of Data Memory
			dm_result_mem_wb_output,
			


			dm_rb_mux,//Output Of Data Memory To Register Bank Multiplexer
			sign_out_id_ex_input,//Sign Extension Output
			sign_out_id_ex_output,
			ls_out,//Left Shift Output
			pc_adder_res,//Program Counter Next-Instruction Adder Output
			adder_pc_mux_out,//Adder To Program Counter Multiplexer Output
			shift_adder_result_ex_mem_input,//Shift Adder Result
			shift_adder_result_ex_mem_output;

	wire[31:0]	instruction_result_if_id_input,//Output Of Instruction Memory
			instruction_result_if_id_output;

	wire[15:0]      instruction_result_if_id_output_id_ex_output;//for instruction of [4:0] and [31:21]
	wire[4:0]       instruction_result_if_id_output_id_ex_output_ex_mem_output,	
			instruction_result_if_id_output_id_ex_output_ex_mem_output_mem_wb_output;

	wire[4:0]	im_regbank_mux_out;//Output of Instruction Memory Multiplexer

	wire 	z_result_ex_mem_input, //Zero Bit of ALU
		z_result_ex_mem_output, 

	       cu_alusrc, cu_memtoreg, cu_regwrite, cu_memread, cu_memwrite, cu_branch;//Control Unit Wires
	
	wire[1:0] cu_aluop,
		wb_idex_input,wb_idex_out,wb_exmem_out;//Control Unit ALUOp Wire
	wire[2:0] m_idex_input,ex_idex_input,m_idex_out,ex_idex_out,m_exmem_out;
	wire[3:0] aluc_op;//ALU Controller Output
	
	//Program Counter Connections
	ProgramCounter PC(adder_pc_mux_out, pc_result_if_id_input, Clk);

	//Instruction Memory Connections
	InstructionMemory IM(pc_result, instruction_result_if_id_input, Clk);

	//IF/ID Register
	 IF_ID_register ifidr(pc_result_if_id_input,instruction_result_if_id_input,instruction_result_if_id_output,pc_result_if_id_output);

	//Instruction Memory To Resgister Bank Multiplexer Connections
	Multiplexer_5Bit IMToRegisterBankMux(instruction_result_if_id_output[20:16], instruction_result_if_id_output[4:0], instruction_result_if_id_output[28], im_regbank_mux_out);

	

	//Register Bank Connections
	RegisterBank RB(instruction_result_if_id_output[9:5], im_regbank_mux_out, instruction_result_if_id_output[4:0], instruction_result_if_id_output_id_ex_output_ex_mem_output_mem_wb_output, dm_result_mem_wb_output[0], Clk, rb_out1_id_ex_input, rb_out2_id_ex_input);

	//ID/EX Register
	ID_EX_register idexreg(rb_out1_id_ex_input,rb_out2_id_ex_input,pc_result_if_id_output,wb_idex_input,m_idex_input,ex_idex_input,sign_out_id_ex_input,instruction_result_if_id_output[31:21],instruction_result_if_id_output[4:0],
,rb_out2_id_ex_output,pc_result_if_id_output_id_ex_output,wb_idex_out,m_idex_out,ex_idex_out,sign_out_id_ex_output,instruction_result_if_id_output_id_ex_output[10:0],instruction_result_if_id_output_id_ex_output[15:11]);

	//Register Bank to ALU Multiplexer Connections
	Multiplexer_64Bit RBToALUMux(rb_out2_id_ex_output, se_out, ex_idex_out[2], rb_alu_mux);

	//ALU Connections
	ALU Alu(rb_out1_id_ex_output, rb_alu_mux, aluc_op, alu_result_ex_mem_input, z_result_ex_mem_input);

	//Ex/MEM Register
	Ex_mem_register emr(alu_result_ex_mem_input,z_result_ex_mem_input,shift_adder_result_ex_mem_input,wb_idex_out,m_idex_out,rb_out2_id_ex_output,instruction_result_if_id_output_id_ex_output[15:11],alu_result_ex_mem_output,z_result_ex_mem_output,shift_adder_result_ex_mem_output,wb_exmem_out,m_exmem_out,rb_out2_id_ex_output_ex_mem_output,instruction_result_if_id_output_id_ex_output_ex_mem_output);

	//Data Memory Connection
	DataMemory dm(alu_result_ex_mem_output, rb_out2_ex_mem_input, Clk, m_exmem_out[2], m_exmem_out[1], dm_result_mem_wb_input);
	
	//Mem/WB register
	Mem_wb_register mwr(wb_exmem_out,dm_result_mem_wb_input,alu_result_ex_mem_output, instruction_result_if_id_output_id_ex_output_ex_mem_output,dm_result_mem_wb_output,alu_result_ex_mem_output_mem_wb_output,instruction_result_if_id_output_id_ex_output_ex_mem_output_mem_wb_output);
	
	//Data Memory To Register Bank Multiplexer
	Multiplexer_64Bit DMToRBMux(alu_result_ex_mem_output_mem_wb_output, dm_result_mem_wb_output, dm_result_mem_wb_output[1] ,dm_rb_mux);

	//Sign Extension Connections
	SignExtension SE(instruction_result_if_id_output, sign_out_id_ex_input);

	//Shift Left Connections
	LeftShift LS(sign_out_id_ex_output, ls_out);

	//Program Counter Next-Instruction Adder connections
	ALU PCAdder(pc_result, 4, 4'b0010, x, pc_adder_res);
	
	//Adder To Program Counter Multiplexer Connections
	Multiplexer_64Bit AddToPCMux(pc_adder_res, shift_adder_result_ex_mem_output, m_exmem_out[0]&z, adder_pc_mux_out);

	//Shift Adder Connections
	ALU ShiftAdder(pc_result_if_id_output_id_ex_output, ls_out, 4'b0010, x, shift_adder_result_ex_mem_input);

	//Control Unit Connections
	Control CU(instruction_result_if_id_output, ex_idex_input[2], wb_idex_input[0], wb_idex_input[1], m_idex_input[1], m_idex_input[2], m_idex_input[0], ex_idex_input[1:0], Clk);

	//ALU Controller Connections
	ALUControl ALUC(ex_idex_out[1:0], instruction_result_if_id_output_id_ex_output[10:0], aluc_op);
	
	
endmodule
