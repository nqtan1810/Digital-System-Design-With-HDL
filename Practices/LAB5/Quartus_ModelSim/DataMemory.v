module DataMemory (ReadData,
						 clk,
						 WriteEn,
						 ReadEn,
						 WriteData,
						 Address
						 );

	parameter DATA_WIDTH = 32;
	parameter ADDR_WIDTH = 5;
	
	output [DATA_WIDTH-1 : 0] ReadData;
	
	input clk;
	input WriteEn;
	input ReadEn;
	input [DATA_WIDTH-1 : 0] WriteData;
	input [ADDR_WIDTH-1 : 0] Address;
	
	reg [DATA_WIDTH-1:0] dmem[2**ADDR_WIDTH-1:0];
	
	initial begin: INIT 
		integer i;
		for(i = 0; i < 2**ADDR_WIDTH; i = i + 1)
			dmem[i] = i;
	end
	
	always @(posedge clk) begin
	
		if(WriteEn) 
			dmem[Address] <= WriteData;
		
	end
	
	assign ReadData = (ReadEn) ? dmem[Address] : 32'hz;
	
	always @(*)
		$writememb("D:/University/Thiet_Ke_He_Thong_So_Voi_HDL/TH/LAB5/text/dMem.bin", dmem);

endmodule 
