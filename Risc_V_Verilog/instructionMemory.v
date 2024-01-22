module instructionMemory(readData,
								 clock,
								 readAddress
								 );
	
	parameter DATA_WIDTH = 32;
	parameter ADDR_WIDTH = 6;
	parameter PATH = "D:/University/Thiet_Ke_He_Thong_So_Voi_HDL/Final_Project/Risc_V_Verilog/testcase/iMem.bin";
	
	output [DATA_WIDTH-1 : 0] readData;
	
	input clock;
	input [ADDR_WIDTH-1 : 0] readAddress;
	
	reg [DATA_WIDTH-1 : 0] readData;
	reg [DATA_WIDTH-1 : 0] imem[2**ADDR_WIDTH-1 : 0];
	
	//always @(posedge clock) begin
	
		//readData <= imem[readAddress];
	
	//end 
	
	always @(*) begin
	
		readData = imem[readAddress];
	
	end 
	
	initial $readmemb(PATH, imem);

endmodule 