module datapath ( zero,
						clock,
						instruction,
						regDst,
						regWrite,
						aluSrc,
						aluControl,
						memWrite,
						memRead,
						memToRead
						);
						
	output zero;
	
	input clock;
	input [31:0] instruction;
	input regDst;
	input regWrite;
	input aluSrc;
	input [2:0]aluControl;
	input memWrite;
	input memRead;
	input memToRead;
	
	wire [4:0] writeReg;  // out mux_regDst
	wire [31:0] readData1;	// from registerFile
	wire [31:0] readData2;	// from registerFile
	wire [31:0] writeData;  // out mux memToReg
	wire [31:0] imm;			// out signExtend
	wire [31:0] aluSrcB;		// out mux aluSrc
	wire [31:0] aluOut;		// from ALU
	wire [31:0] readData;	// readData from data memory	
	
	mux #(
			.DATA_WIDTH(5)
			)
			mux_regDst (.out(writeReg),
							.sel(regDst),
							.a(instruction[20:16]),
							.b(instruction[15:11])
							);
						
	RegisterFile regFile(
								.ReadData1(readData1),
								.ReadData2(readData2),
								.CLK(clock),
								.ReadAddress1(instruction[25:21]),
								.ReadAddress2(instruction[20:16]),
								.WriteAddress(writeReg),
								.WriteData(writeData),
								.ReadWriteEn(regWrite)
								);
								
	signExtend signEtx ( .out(imm),
								.in(instruction[15:0])
								);
								
	mux mux_aluSrc(.out(aluSrcB),
						.sel(aluSrc),
						.a(readData2),
						.b(imm)
						);
						
	ALU_32bits alu ( .zero(zero),
						  .S(aluOut),
						  .A(readData1),
						  .B(aluSrcB),
						  .M(aluControl[2]),
						  .S1(aluControl[1]),
						  .S0(aluControl[0])
						);
						
	DataMemory dmem(.ReadData(readData),
						 .clk(clock),
						 .WriteEn(memWrite),
						 .ReadEn(memRead),
						 .WriteData(readData2),
						 .Address(aluOut[9:0])
						 );
						 
	mux mux_memToReg (.out(writeData),
							.sel(memToRead),
							.a(readData),
							.b(aluOut)
							);
	
endmodule 