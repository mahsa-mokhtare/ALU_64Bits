//64Bits ALU Module
module ALU(
           input[63:0] A,
	   input[63:0] B,  // ALU 64-bit Inputs                 
           input[3:0] OPERATION,// ALU Selection
           output[63:0] Out, // ALU 64-bit Output
	   output reg Z = 0 //  Zero bit
    );
    reg [63:0] Result;
    assign Out = Result; // ALU out
    always @(A or B or OPERATION)
    begin
        case(OPERATION)
        	4'b0000: // Locig AND
           		Result = A & B ; 
        	4'b0001: // Logic OR
          		Result = A | B ;
        	4'b0010: // Addition
           		Result = A + B;
        	4'b0110: // Subtraction
           		Result = A-B;
        	4'b0111: //Pass B
           		Result = B;
         	4'b1100: // Logic NOR
			Result = ~(A | B);
		4'b0101 ://new
			Result = -A-B;
	
           		
          	default: Result = A + B ; 
        endcase
    end
endmodule 