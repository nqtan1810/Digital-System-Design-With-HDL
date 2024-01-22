module branchControl (PCsrc,
							 branch,
							 jal,
							 zero
							 );
							 
	output PCsrc;
	
	input [1:0] branch;
	input jal;
	input zero;

	assign PCsrc = ((branch[1] && zero) | (branch[0] && (!zero)) | (jal)) === 1 ? 1'b1 : 1'b0;

endmodule 