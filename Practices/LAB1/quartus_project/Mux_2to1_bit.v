module Mux_2to1_bit( m,
							s,
							x,
							y
							);
							
	output m;
	
	input s;
	input x;
	input y;
	
	wire w1;
	wire w2;
	
	assign w1 = (~s) & x;
	assign w2 = s & y;
	assign m = w1 | w2;
	
endmodule
