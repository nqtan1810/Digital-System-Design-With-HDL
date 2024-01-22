module immGenerator (immOut,
							instruction
							);
	
	output[31:0] immOut;
	
   input [31:0] instruction;
   
	reg[31:0] immOut;
	
   always @(instruction) begin //#0.1
	
		case(instruction[6:0])
		
			  7'b0010011: immOut = { {20{instruction[31]}}, instruction[31:20] };   // ADDI, ANDI, ORI     -> I-Type
			  7'b0000011: immOut = { {20{instruction[31]}}, instruction[31:20] };   // LW       -> I-Type
			  7'b0100011: immOut = { {20{instruction[31]}}, instruction[31:25], instruction[11:7] };     // SW       -> S-Type
			  7'b1100011: immOut = { {20{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8] };  // BEQ, BNE -> B-Type
			  7'b0110111: immOut = { {12{instruction[31]}}, instruction[31:12] };		// LUI		-> U-Type
			  7'b1101111: immOut = { {12{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21] };  // JAL -> J-Type
			  
			  default: immOut <= 32'd0;
			  
		 endcase
		 
	end
	
endmodule 