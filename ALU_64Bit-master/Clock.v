
module Clock(clk);
    output reg clk = 1'b0;
    always
        begin
	    #100; assign clk = ~ clk;
        end
endmodule 