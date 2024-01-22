module dataMemory(readData,
						clock,
						memRead,
						memWrite,
						writeData,
						address
						);
						
	parameter DATA_WIDTH = 32;
	parameter ADDR_WIDTH = 6;
	parameter PATH = "D:/University/Thiet_Ke_He_Thong_So_Voi_HDL/Final_Project/Risc_V_Verilog/testcase/dMem.bin";
	
	output [DATA_WIDTH-1 : 0] readData;
	
	input clock;
	input memRead;
	input memWrite;
	input [DATA_WIDTH-1 : 0] writeData;
	input [ADDR_WIDTH-1 : 0] address;

	reg [DATA_WIDTH-1 : 0] readData;
	reg [DATA_WIDTH-1 : 0] dmem[2**ADDR_WIDTH-1 : 0];
	
	initial begin: INIT 
		integer i;
		for(i = 0; i < 2**ADDR_WIDTH; i = i + 1)
			dmem[i] <= 32'h00000000;
	end
	
	always @(posedge clock) begin
	
		if(memWrite) begin
		
			dmem[address] <= writeData;
			
		end
		//if(memRead) begin
		
			//readData <= dmem[address];
		
		//end
		
		$writememb(PATH, dmem);
	
	end 
	
	always @(*)
		if(memRead)
			readData <= dmem[address];

endmodule 