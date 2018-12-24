module IF_ID_register(IPC,IInstruction,OPC,OInstruction,Clk);

	input [63:0]IPC;
	input [31:0]IInstruction;
	input Clk;

	output reg [63:0]OPC;
	output reg [31:0]OInstruction;


	reg [95:0]register;


	always @(posedge Clk)
	  begin
		
		OPC=register[63:0];
		OInstruction=register[95:64];

		register[63:0]=IPC;
		register[95:64]=IInstruction;

	  end
endmodule
		
		
		

