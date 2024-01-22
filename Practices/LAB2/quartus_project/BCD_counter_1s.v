module div_50MHz_clock (clk_1Hz,
								clk_50MHz,
								reset_n
								);
								
	output clk_1Hz;
	
	input clk_50MHz;
	input reset_n;
	
	reg clk_1Hz;
			
	reg [24:0] count;
	
	always @(posedge clk_50MHz or negedge reset_n) begin
	
		if(!reset_n) begin
			count <= 0;
			clk_1Hz <= 0;
			
		end
			
		else if(count < 25000000) begin
		
			count <= count + 1;
			
			end
		
		else begin
		
			count <= 0;
			clk_1Hz <= ~clk_1Hz;
			
		end
			
	end
			
endmodule 


module BCD_counter_1s (Hex,
							  Clock,
						     Reset_n
							  );

	output [6:0] Hex;
	
	input Clock;
	input Reset_n;
	
	wire clk_1Hz;
	
	div_50MHz_clock div_clock(.clk_1Hz(clk_1Hz), .clk_50MHz(Clock), .reset_n(Reset_n));
	
	BCD_counter BCD_counter(.Hex(Hex), .Clock(clk_1Hz), .Reset_n(Reset_n));

endmodule 