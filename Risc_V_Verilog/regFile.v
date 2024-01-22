module regFile(readData1,
					readData2,
					clock,
					readReg1,
					readReg2,
					regWrite,
					writeData,
					writeReg
					);

	parameter DATA_WIDTH = 32;
	parameter ADDR_WIDTH = 5;
	parameter PATH = "D:/University/Thiet_Ke_He_Thong_So_Voi_HDL/Final_Project/Risc_V_Verilog/testcase/regFile.bin";
	
	output [DATA_WIDTH-1 : 0] readData1;
	output [DATA_WIDTH-1 : 0] readData2;
	
	input clock;
	input [ADDR_WIDTH-1 : 0] readReg1;
	input [ADDR_WIDTH-1 : 0] readReg2;
	input regWrite;
	input [DATA_WIDTH-1 : 0] writeData;
	input [ADDR_WIDTH-1 : 0] writeReg;
	
	reg [DATA_WIDTH-1 : 0] readData1;
	reg [DATA_WIDTH-1 : 0] readData2;
	reg [DATA_WIDTH-1 : 0] regfile[2**ADDR_WIDTH-1 : 0];
	
	initial begin: INIT 
		integer i;
		for(i = 0; i < 2**ADDR_WIDTH; i = i + 1)
			regfile[i] <= 32'h00000000;
	end
	
	always @(posedge clock) begin

		if(regWrite && writeReg != 0) begin
		
			regfile[writeReg] <= writeData;
			
		end
		
		$writememb(PATH, regfile);
	
	end
	
	always @(readReg1 or readReg2) begin
	
		readData1 = (readReg1 != 0) ? regfile[readReg1] : 0;
		readData2 = (readReg2 != 0) ? regfile[readReg2] : 0;
	
	end

endmodule 