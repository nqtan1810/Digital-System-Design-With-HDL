module adder(out,
				 a,
				 b
				 );
				 
	parameter DATA_WIDTH = 32;
	
	output [DATA_WIDTH-1 : 0] out;
	
	input [DATA_WIDTH-1 : 0] a;
	input [DATA_WIDTH-1 : 0] b;
	
   assign out = a + b;

	/*
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