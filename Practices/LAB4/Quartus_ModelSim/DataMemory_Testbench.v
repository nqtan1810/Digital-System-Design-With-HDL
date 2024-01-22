`timescale 1ns/100ps
module DataMemory_Testbench();

	parameter DATA_WIDTH = 8;
	parameter ADDR_WIDTH = 10;

	wire [DATA_WIDTH-1 : 0] ReadData;
	
	reg clk;
	reg WriteEn;
	reg ReadEn;
	reg [DATA_WIDTH-1 : 0] WriteData;
	reg [ADDR_WIDTH-1 : 0] Address;
	
	integer i;
	
	// initial at start time = 0
	initial begin
		
		{clk, WriteEn, ReadEn, WriteData, Address} = 0;
		
	end
	
	// generate clock width T = 10, Duty = 50%
	always #10 clk = ~clk;
	
	// instance module DataMemory
	DataMemory #(
						 .DATA_WIDTH(DATA_WIDTH),
						 .ADDR_WIDTH(ADDR_WIDTH)
					 ) 
					 dmem_dut
					 (
						 .ReadData(ReadData),
						 .clk(clk),
						 .WriteEn(WriteEn),
						 .ReadEn(ReadEn),
						 .WriteData(WriteData),
						 .Address(Address)
					 );
	
	// generate testcase
	initial begin
		
		// write data into memory cells indexed from 1-50;
		for(i = 1; i <= 50; i = i + 1) begin
		
			repeat (1) @(posedge clk) begin
				
				#10	 
				Address = i;
				WriteData = i;
				WriteEn = 1;
					 
			end
				
		end
		
		// read data from memory cells indexed from 1-50;
		for(i = 1; i <= 50; i = i + 1) begin
		
			repeat (1) @(posedge clk) begin
					
				#10 
				Address = i;
				WriteEn = 0;
				ReadEn = 1;
					 
			end
				
		end
		
		// write data into memory cells indexed from 50-100;
		for(i = 50; i <= 100; i = i + 1) begin
		
			repeat (1) @(posedge clk) begin
					
				#10 
				Address = i;
				WriteData = i;
				WriteEn = 1;
				ReadEn = 0;	
					 
			end
				
		end
		
		// read data from memory cells indexed from 50-100;
		for(i = 50; i <= 100; i = i + 1) begin
		
			repeat (1) @(posedge clk) begin
					
				#10 
				Address = i;
				WriteEn = 0;
				ReadEn = 1;
					 
			end
				
		end
		
		#100 $stop;
	
	end

endmodule 