module TestBench();
	wire clk;
	Clock clock(clk);
	Mips_CPU cpu(clk);
endmodule 