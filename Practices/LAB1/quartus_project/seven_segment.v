module seven_segment ( Y,
							  C
							  );
							  
	output [6:0] Y;
	
	input [2:0] C;
	
	assign Y = (C == 3'b000) ? 7'b1110110 :
				  (C == 3'b001) ? 7'b1111001 :
				  (C == 3'b010) ? 7'b0111000 :
				  (C == 3'b011) ? 7'b0111000 :
				  (C == 3'b100) ? 7'b0111111 : 7'bxxxxxxx;
							  
endmodule 