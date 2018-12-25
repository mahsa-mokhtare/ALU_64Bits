module TestBench();
	reg Clk = 0;
	Mips_CPU cpu(Clk);
	always #1 Clk = ~Clk;
endmodule
	
