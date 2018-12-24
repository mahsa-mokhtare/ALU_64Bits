//Program Counter 64bit Register
module ProgramCounter(PCNext, PCResult, Clk);


input [63:0] PCNext;

input Clk;

output reg [63:0] PCResult;

    always @(posedge Clk)
    begin
    		PCResult <= PCNext;
    end

endmodule

