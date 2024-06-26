module DataMemory(ReadData,
						 clk,
						 WriteEn,
						 ReadEn,
						 WriteData,
						 Address
						 );

	parameter DATA_WIDTH = 8;
	parameter ADDR_WIDTH = 10;
	
	output [DATA_WIDTH-1 : 0] ReadData;
	
	input clk;
	input WriteEn;
	input ReadEn;
	input [DATA_WIDTH-1 : 0] WriteData;
	input [ADDR_WIDTH-1 : 0] Address;
	
	reg [DATA_WIDTH-1:0] DataMemory[2**ADDR_WIDTH-1:0];
	
	always @(posedge clk) begin
	
		if(WriteEn) 
			DataMemory[Address] <= WriteData;
	
	end
	
	assign ReadData = (ReadEn) ? DataMemory[Address] : {(DATA_WIDTH){1'bz}};

endmodule 