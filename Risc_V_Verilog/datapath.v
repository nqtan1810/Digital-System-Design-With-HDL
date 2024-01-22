module datapath (opcode,
					  funct3,
					  funct7,
					  zero,
					  clock,
					  rstn,
					  PCsrc,
					  slt,
					  lui,
					  jal,
					  memToReg,
					  memWrite,
					  memRead,
					  operation,
					  aluSrc,
					  regWrite
					  );
					 
	parameter ADDR_WIDTH = 32;
	parameter DATA_WIDTH = 32;
	parameter PATH_IMEM = "D:/University/Thiet_Ke_He_Thong_So_Voi_HDL/Final_Project/Risc_V_Verilog/testcase/iMem.bin";
	parameter PATH_REGFILE = "D:/University/Thiet_Ke_He_Thong_So_Voi_HDL/Final_Project/Risc_V_Verilog/testcase/regFile.bin";
	parameter PATH_DMEM = "D:/University/Thiet_Ke_He_Thong_So_Voi_HDL/Final_Project/Risc_V_Verilog/testcase/dMem.bin";

	output [6:0] opcode;
	output [2:0] funct3;
	output [6:0] funct7;
	output zero;
	
	input clock;
	input rstn;
	input PCsrc;
	input slt;
	input lui;
	input jal;
	input memToReg;
	input memWrite;
	input memRead;
	input [3:0] operation;
	input aluSrc;
	input regWrite;
	
	wire [ADDR_WIDTH-1 : 0] pc;
	wire [ADDR_WIDTH-1 : 0] pcNext;
	wire [ADDR_WIDTH-1 : 0] pc4;
	wire [ADDR_WIDTH-1 : 0] pcImm;
	
	wire [DATA_WIDTH-1 : 0] instruction;
	wire [DATA_WIDTH-1 : 0] readData1;
	wire [DATA_WIDTH-1 : 0] readData2;
	wire [DATA_WIDTH-1 : 0] writeData;
	wire [DATA_WIDTH-1 : 0] aluOut;
	wire [DATA_WIDTH-1 : 0] aluSrcB;
	wire [DATA_WIDTH-1 : 0] readDataDmem;
	wire [DATA_WIDTH-1 : 0] out_memToReg;
	wire [DATA_WIDTH-1 : 0] out_jal;
	wire [DATA_WIDTH-1 : 0] out_lui;
	wire [DATA_WIDTH-1 : 0] out_shiftLeft12;
	wire [DATA_WIDTH-1 : 0] out_signBit;
	wire [DATA_WIDTH-1 : 0] out_immGenerator;
	wire [DATA_WIDTH-1 : 0] out_shiftLeft1;
	
	wire signBit;
	
	
	FFD_resettable pcreg( .q(pc),
								 .clock(clock),
								 .rstn(rstn),
								 .d(pcNext)	// pc_next
								 );
	
	instructionMemory #(.PATH(PATH_IMEM))imem(.readData(instruction),
															.clock(clock),
															.readAddress(pc[11:2])
															);
							  
	regFile #(.PATH(PATH_REGFILE)) regfile(.readData1(readData1),
														.readData2(readData2),
														.clock(clock),
														.readReg1(instruction[19:15]),
														.readReg2(instruction[24:20]),
														.regWrite(regWrite),
														.writeData(writeData),
														.writeReg(instruction[11:7])
														);
							
	alu alu (.zero(zero),
				.signBit(signBit),
				.result(aluOut),
				.operation(operation),
				.a(readData1),
				.b(aluSrcB)						// alu source B
				);
				
	dataMemory #(.PATH(PATH_DMEM)) dmem (.readData(readDataDmem),
													 .clock(clock),
													 .memRead(memRead),
													 .memWrite(memWrite),
													 .writeData(readData2),
													 .address(aluOut[11:2])
													);
						
	immGenerator immGen (.immOut(out_immGenerator),
								.instruction(instruction)
								);
								
	shiftLeft shiftLeft_12(.out(out_shiftLeft12),
								  .a(out_immGenerator),
								  .b(32'd12)
								  );
								  
	shiftLeft shiftLeft_1 (.out(out_shiftLeft1),
								  .a(out_immGenerator),
								  .b(32'd1)
								  );
						
	mux mux_memToReg (.out(out_memToReg),
							.sel(memToReg),
							.a(aluOut),
							.b(readDataDmem)
							);
							
	mux mux_jal(.out(out_jal),
					.sel(jal),
					.a(out_memToReg),
					.b(pc4)
					);
					
	mux mux_lui(.out(out_lui),
					.sel(lui),
					.a(out_jal),
					.b(out_shiftLeft12)
					);
					
	mux mux_slt(.out(writeData),
					.sel(slt),
					.a(out_lui),
					.b(out_signBit)
					);
					
	mux mux_signBit(.out(out_signBit),
						 .sel(signBit),
						 .a(32'd0),
						 .b(32'd1)
						 );
						 
	mux mux_aluSrcB(.out(aluSrcB),
						 .sel(aluSrc),
						 .a(readData2),
						 .b(out_immGenerator)
						 );
						 
	mux mux_pcNext (.out(pcNext),
						 .sel(PCsrc),
						 .a(pc4),
						 .b(pcImm)
						 );
						 
	adder adder4(.out(pc4),
					 .a(pc),
					 .b(32'd4)
					 );
					 
	adder adderShiftLeft1(.out(pcImm),
								 .a(out_shiftLeft1),
								 .b(pc)
								 );
								 
	assign opcode = instruction[6:0];
	assign funct3 = instruction[14:12];	
	assign funct7 = instruction[31:25];	
				
endmodule 