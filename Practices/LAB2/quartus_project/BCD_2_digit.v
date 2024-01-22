module counter_20 (out0,
						 out1,
						 Clock,
						 Reset_n
						 );
	
	output [3:0] out0;
	output [3:0] out1;
	
	input Clock;
	input Reset_n;
	
	reg [3:0] out0;
	reg [3:0] out1;
	
	always @(posedge Clock or negedge Reset_n) begin
	
		out0 <= (!Reset_n) ? 0 : (out0 < 9) ? (out0 + 1) : 0; 
		out1 <= (!Reset_n) ? 0 : (out0 < 9) ? (out1) : (out1 < 2) ? (out1 + 1) : 0;

	end
						 
endmodule 

module BCD_2_digit (Hex0,
						  Hex1,
						  Clock,
						  Reset_n
						  );
						  
	output [6:0] Hex0;
	output [6:0] Hex1;
	
	input Clock;
	input Reset_n;
	
	wire clk_1Hz;
	wire [3:0] digit0;
	wire [3:0] digit1;
	
	div_50MHz_clock div_clock(.clk_1Hz(clk_1Hz), .clk_50MHz(Clock), .reset_n(Reset_n));
	
	counter_20 counter(.out0(digit0), .out1(digit1), .Clock(clk_1Hz), .Reset_n(Reset_n));

	Seven_Segment_Decoder hex_0(.hex(Hex0), .bin(digit0));
	Seven_Segment_Decoder hex_1(.hex(Hex1), .bin(digit1));

endmodule 