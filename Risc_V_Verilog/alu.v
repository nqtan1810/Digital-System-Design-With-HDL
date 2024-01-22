module alu (zero,
				signBit,
				result,
				operation,
				a,
				b
				);

	parameter DATA_WIDTH = 32;
	
	output zero;
	output signBit;
	output [DATA_WIDTH-1 : 0] result;
	
	input [3:0] operation;
	input [DATA_WIDTH-1 : 0] a;
	input [DATA_WIDTH-1 : 0] b;
	
	reg [DATA_WIDTH-1 : 0] result;
	
	assign zero = (result == 32'd0) ? 1'b1 : 1'b0;
	assign signBit = result[DATA_WIDTH-1];
	
   always @(operation or a or b) begin
	
      casex (operation)
		
         4'b0000: result = a & b;
         4'b0001: result = a | b;
         4'b0010: result = a + b;
         4'b0110: result = a - b;
         default: result = 0;
			
      endcase
		
	end 
		
		/*
      // Function to signed operation
      function [31:0] OUT;
          input [31:0] a, b;
          begin
				 casex(b[31])
					  1'b1:   begin
								 b = ~b;
								 b = b + 1'b1;
								 OUT = a - b;
								 end
					  default: OUT = a + b;
				 endcase
          end
      endfunction
		*/

endmodule 