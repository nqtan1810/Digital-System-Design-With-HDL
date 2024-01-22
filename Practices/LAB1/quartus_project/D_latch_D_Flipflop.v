module D_latch_D_Flipflop (Qa,
									Qan,
									Qb,
									Qbn,
									Qc,
									Qcn,
									D,
									Clk
									);
									
	output Qa;
	output Qan;
	output Qb;
	output Qbn;
	output Qc;
	output Qcn;
	
	input D;
	input Clk;
	
	D_latch Da(.Qa(Qa), .Qb(Qan), .D(D), .Clk(Clk));
	D_Flipflop Db(.Q(Qb), .Qn(Qbn), .D(D), .Clk(Clk));
	D_Flipflop Dc(.Q(Qc), .Qn(Qcn), .D(D), .Clk(~Clk));

endmodule 