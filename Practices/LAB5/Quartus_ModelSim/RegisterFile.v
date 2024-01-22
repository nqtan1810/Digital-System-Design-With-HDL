module RegisterFile(
	output [31:0] ReadData1,
	output [31:0] ReadData2,
	input CLK,
	input [4:0] ReadAddress1,
	input [4:0] ReadAddress2,
	input [4:0] WriteAddress,
	input [31:0] WriteData,
	input ReadWriteEn
);
	// Khai báo mảng thanh ghi
	reg [31:0] registers [31:0];
	
	initial begin: INIT 
		integer i;
		for(i = 0; i < 2**5; i = i + 1)
			registers[i] = i;
	end
	
	always @(posedge CLK) begin
		if (ReadWriteEn) begin
			registers[WriteAddress] <= WriteData;
		end 
	end
	
	assign ReadData1 = registers[ReadAddress1];
	assign ReadData2 = registers[ReadAddress2];
	
	always @(*)
		$writememb("D:/University/Thiet_Ke_He_Thong_So_Voi_HDL/TH/LAB5/text/regFile.bin", registers);
	
endmodule