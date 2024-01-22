module tb1();

	wire zero;
	
	reg clock;
	reg [31:0] instruction;
	reg regDst;
	reg regWrite;
	reg aluSrc;
	reg [2:0]aluControl;
	reg memWrite;
	reg memRead;
	reg memToRead;

	initial begin
	
		
		$monitor("[%0t], %d, %d, %d", $time, dut.writeData, dut.readData1, dut.readData2);
		// add $1, $2, $3
		clock = 0;
		instruction = 32'b00000000010000110000100000100000;
		regDst = 1;
		regWrite = 1;
		aluSrc = 0;
		aluControl = 3'b101;
		memWrite = 0;
		memRead = 0;
		memToRead = 1;
		#20
		//clock = ~clock;
		
		// lw $1, 0($2)
		//clock = 0;
		instruction = 32'b10001100010000010000000000000000;
		regDst = 0;
		regWrite = 1;
		aluSrc = 1;
		aluControl = 3'b101;
		memWrite = 0;
		memRead = 1;
		memToRead = 0;
		#20
		//clock = ~clock;

		// sw $5, 0($2)
		//clock = 0;
		instruction = 32'b10101100010001010000000000000000;
		regDst = 0;
		regWrite = 0;
		aluSrc = 1;
		aluControl = 3'b101;
		memWrite = 1;
		memRead = 0;
		memToRead = 1;
		#20
		//clock = ~clock;

		#100 $stop;
	
	end
	
	always #10 clock = ~clock;
	
	datapath dut ( .zero(zero),
						.clock(clock),
						.instruction(instruction),
						.regDst(regDst),
						.regWrite(regWrite),
						.aluSrc(aluSrc),
						.aluControl(aluControl),
						.memWrite(memWrite),
						.memRead(memRead),
						.memToRead(memToRead)
						);
	
endmodule 