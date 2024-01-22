module RISC_V (clock,
					rstn);
					
	parameter PATH_IMEM = "D:/University/Thiet_Ke_He_Thong_So_Voi_HDL/Final_Project/Risc_V_Verilog/testcase/iMem.bin";
	parameter PATH_REGFILE = "D:/University/Thiet_Ke_He_Thong_So_Voi_HDL/Final_Project/Risc_V_Verilog/testcase/regFile.bin";
	parameter PATH_DMEM = "D:/University/Thiet_Ke_He_Thong_So_Voi_HDL/Final_Project/Risc_V_Verilog/testcase/dMem.bin";
					
	input clock;
	input rstn;
	
	wire [6:0] opcode;
	wire [2:0] funct3;
	wire [6:0] funct7;
	wire zero;
	
	wire clock;
	wire rstn;
	wire PCsrc;
	wire slt;
	wire lui;
	wire jal;
	wire memToReg;
	wire memWrite;
	wire memRead;
	wire [3:0] operation;
	wire aluSrc;
	wire regWrite;

	controller risc_v_controller ( .PCsrc(PCsrc),
											 .slt(slt),
											 .lui(lui),
											 .jal(jal),
											 .memToReg(memToReg),
											 .memWrite(memWrite),
											 .memRead(memRead),
											 .operation(operation),
											 .aluSrc(aluSrc),
											 .regWrite(regWrite),
											 .opcode(opcode),
											 .funct3(funct3),
											 .funct7(funct7),
											 .zero(zero)
											 );
											 
	datapath #( .PATH_IMEM(PATH_IMEM), 
					.PATH_REGFILE(PATH_REGFILE), 
					.PATH_DMEM(PATH_DMEM)
					) risc_v_datapath ( .opcode(opcode),
											  .funct3(funct3),
											  .funct7(funct7),
											  .zero(zero),
											  .clock(clock),
											  .rstn(rstn),
											  .PCsrc(PCsrc),
											  .slt(slt),
											  .lui(lui),
											  .jal(jal),
											  .memToReg(memToReg),
											  .memWrite(memWrite),
											  .memRead(memRead),
											  .operation(operation),
											  .aluSrc(aluSrc),
											  .regWrite(regWrite)
											  );										 
	
endmodule 