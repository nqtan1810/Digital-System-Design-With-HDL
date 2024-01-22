module aluControl(operation,
						aluOp,
						funct3,
						funct7
						);
						
	output [3:0] operation;
		
	input [1:0] aluOp;
	input [6:0] funct7;
	input [2:0] funct3;

	reg [3:0] operation;
	 
	always @(aluOp or funct7 or funct3)
	
		case(aluOp)
		
			2'b00: operation = 4'b0010; //add (for lw/sw)
			
			2'b01: operation = 4'b0110; //sub (for beq, bne)
			
			// R-type instructions
			2'b10: casex(funct7)
							7'b0000000: casex(funct3)
												3'b000: operation = 4'b0010; //add (for add)
												3'b010: operation = 4'b0110; //slt (for slt)
												3'b110: operation = 4'b0001; //or (for or)
												3'b111: operation = 4'b0000; //and (for and)
												default: operation = 4'bxxxx;
											endcase
											
							7'b0100000: operation = 4'b0110; //sub (for sub)
							default: operation = 4'bxxxx;	//illegal operation
					endcase
					
			2'b11: casex(funct3)
						3'b000: operation = 4'b0010; //add (for addi)
						3'b110: operation = 4'b0001; //or (for ori)
						3'b111: operation = 4'b0000; //and (for andi)
						default: operation = 4'bxxxx;
					 endcase
			
			default: operation = 4'bxxxx;
			
		endcase
 
endmodule
