module controller (PCsrc,
						 slt,
						 lui,
						 jal,
						 memToReg,
						 memWrite,
						 memRead,
						 operation,
						 aluSrc,
						 regWrite,
						 opcode,
						 funct3,
						 funct7,
						 zero
						 );
						 
	output PCsrc;
	output slt;
	output lui;
	output jal;
	output memToReg;
	output memWrite;
	output memRead;
	output [3:0] operation;
	output aluSrc;
	output regWrite;
	
	input [6:0] opcode;
	input [2:0] funct3;
	input [6:0] funct7;
	input zero;
	
	wire [1:0] branch;
	wire [1:0] aluOp;
	
	control ctl( .branch(branch),
					 .slt(slt),
					 .lui(lui),
					 .jal(jal),
					 .memToReg(memToReg),
					 .memWrite(memWrite),
					 .memRead(memRead),
					 .aluOp(aluOp),
					 .aluSrc(aluSrc),
					 .regWrite(regWrite),
					 .opcode(opcode),
					 .funct3(funct3)
					 );
			 
	aluControl aluCtl(.operation(operation),
							.aluOp(aluOp),
							.funct3(funct3),
							.funct7(funct7)
							);
					
	branchControl brCtl ( .PCsrc(PCsrc),
								 .branch(branch),
								 .jal(jal),
								 .zero(zero)
								 );
endmodule 