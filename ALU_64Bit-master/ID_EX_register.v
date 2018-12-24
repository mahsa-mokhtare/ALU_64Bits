module ID_EX_register(IReadDate1,IReadData2,IRegisterPC,IWB,IM,IEX,ISignExtend,IInstrcution3121,IInstrcution40,OReadDate1,OReadData2,ORegisterPC,OWB,OM,OEX,OSignExtend,OInstrcution3121,OInstrcution40,Clk);
	
	input[63:0] IReadDate1;
	input[63:0] IReadData2;
	input[63:0] IRegisterPC;
	input[1:0] IWB;
	input[2:0] IM;
	input[2:0] IEX;
	input[63:0] ISignExtend;
	input[10:0] IInstrcution3121;
	input[4:0] IInstrcution40;
	output reg[63:0] OReadDate1;
	output reg[63:0] OReadData2;
	output reg[63:0] ORegisterPC;
	output reg[1:0] OWB;
	output reg[2:0] OM;
	output reg[2:0] OEX;
	output reg[63:0] OSignExtend;
	output reg[10:0] OInstrcution3121;
	output reg[4:0] OInstrcution40;
	input Clk;

	reg[279:0] register;
	always @(posedge Clk)
	begin
		OReadDate1=register[63:0];
		OReadData2=register[127:64];
		ORegisterPC = register[191:128];
		OSignExtend = register[255:192];
		OWB = register[257:256];
		OM = register[260:258];
		OEX = register[263:261];
		OInstrcution3121=register[274:264];
		OInstrcution40=register[279:275];


		register[63:0]=IReadDate1;
		register[127:64]=IReadData2;
		register[191:128]= IRegisterPC;
		register[255:192]=ISignExtend;
		register[257:256]=IWB;
		register[260:258]=IM;
		register[263:261]=OEX;
		register[274:264]= IInstrcution3121;
		register[279:275]=IInstrcution40;
		
		
	end
endmodule
