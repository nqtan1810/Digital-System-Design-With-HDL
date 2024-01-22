module D_Flipflop (Q,
						 Qn,
						 D,
						 Clk
						 );
						 
	output Q;
	output Qn;
	
	input D;
	input Clk;
	
	wire Qm;
	
	D_latch Master(.Qa(Qm), .D(D), .Clk(~Clk));
	D_latch Slave(.Qa(Q), .Qb(Qn), .D(Qm), .Clk(Clk));

endmodule 