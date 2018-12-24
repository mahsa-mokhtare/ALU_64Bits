module Ex_mem_register(IAlu,IZero,IAdder,IWB,IM,IReadRegister2,IInstruction,OAlu,OZero,OAdder,OWB,OM,OReadRegister2,OInstruction,Clk);
	
	input [63:0]IAlu;
	input IZero;
	input [63:0]IAdder;
	input[1:0] IWB;
	input[2:0] IM;
	input [63:0]IReadRegister2;
	input [4:0]IInstruction;
	input Clk;
	
	output reg [63:0]OAlu;
	output reg OZero;
	output reg [63:0]OAdder;
	output reg[1:0] OWB;
	output reg[2:0] OM;
	output reg [63:0]OReadRegister2;
	output reg [4:0]OInstruction;

	reg [202:0] registers;
	
	always @(posedge Clk)
	begin 
		//get data from registers
		OAlu = registers[63:0]; 
		OZero =registers[64];
		OAdder = registers[128:65];
		OWB = registers[130:129];
		OM = registers[133:131];
		OReadRegister2 = registers[197:134];
		OInstruction = registers[202:198];


		//save data in register
		registers[63:0]=IAlu; 
		registers[64] = IZero;
	        registers[128:65]=IAdder ;
		registers[130:129] =IWB ;
		registers[133:131] =IM;
	        registers[197:134]=IReadRegister2;
	        registers[202:198]=IInstruction;
	end 
endmodule 
	
	
