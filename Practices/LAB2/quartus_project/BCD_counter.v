module Seven_Segment_Decoder (hex,
										bin
										);
										
	output [6:0] hex;
	
	input [3:0] bin;
	
	reg [6:0] hex;
	
	always @(*) begin
		
		case (bin)
			
			4'b0000: hex = 7'b0111111;
			4'b0001: hex = 7'b0000110;
			4'b0010: hex = 7'b1011011;
			4'b0011: hex = 7'b1001111;
			4'b0100: hex = 7'b1100110;
			4'b0101: hex = 7'b1101101;
			4'b0110: hex = 7'b1111101;
			4'b0111: hex = 7'b0000111;
			4'b1000: hex = 7'b1111111;
			4'b1001: hex = 7'b1101111;
			
			default: hex = 7'bxxxxxxx;
		
		endcase
	
	end
	
endmodule 


module counter (Q,
				    clock,
				    reset_n
					 );
			
	output [3:0] Q;
	
	input clock;
	input reset_n;
	
	reg [3:0] Q;
	
	always @(posedge clock or negedge reset_n) begin
		
		if(!reset_n)
			Q <= 0;
			
		else if (Q >= 9)
			Q <= 0;
			
		else
			Q <= Q + 1;
	
	end
					 
endmodule 

module BCD_counter (Hex,
						  Clock,
						  Reset_n
						  );
						  
	output [6:0] Hex;
	
	input Clock;
	input Reset_n;
	
	wire [3:0] bcd;
			
	counter counter(.Q(bcd), .clock(Clock), .reset_n(Reset_n));
	
	Seven_Segment_Decoder encoder(.hex(Hex), .bin(bcd));
					 
endmodule 

