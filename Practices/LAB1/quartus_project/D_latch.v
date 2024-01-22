module D_latch (Qa,
					 Qb,
					 D,
					 Clk
					 );
			
	output Qa;
	output Qb;
	
	input D;
	input Clk;
	
	wire S_g;
	wire R_g;
	
	assign S_g = ~(D & Clk);
	assign R_g = ~((~D) & Clk);
	assign Qa = ~(S_g & Qb);
	assign Qb = ~(R_g & Qa);
					 
endmodule 