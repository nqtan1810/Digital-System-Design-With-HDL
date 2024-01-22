module mux (out,
				sel,
				a,
				b
				);

	parameter DATA_WIDTH = 32;
	
	output [DATA_WIDTH-1 : 0] out;
	  
	input sel;
	input [DATA_WIDTH-1 : 0] a;
	input [DATA_WIDTH-1 : 0] b;

	assign out = (sel) ? b : a;
  
endmodule
