module moore_detector(z, 
							 w,
							 rstn,
							 clk
							 );
							 
	parameter [3:0] RESET = 0;
	parameter [3:0] S0 = 1;
	parameter [3:0] S00 = 2;
	parameter [3:0] S000 = 3;
	parameter [3:0] S0000 = 4;
	parameter [3:0] S1 = 5;
	parameter [3:0] S11 = 6;
	parameter [3:0] S111 = 7;
	parameter [3:0] S1111 = 8;
	
	output z;
	
	input w;
	input rstn;
	input clk;
	
	reg [3:0] present_state;
	reg [3:0] next_state;
	
	always @(*) begin
	
		case (present_state)
		
			RESET: next_state = w ? S1 : S0;
			
			S0: next_state = w ? S1 : S00;
			
			S00: next_state = w ? S1 : S000;
			
			S000: next_state = w ? S1 : S0000;
			
			S0000: next_state = w ? S1 : S0000;
			
			S1: next_state = w ? S11 : S0;
			
			S11: next_state = w ? S111 : S0;
			
			S111: next_state = w ? S1111 : S0;
			
			S1111: next_state = w ? S1111 : S0;
			
		endcase
			
	end
	
	always @(posedge clk or negedge rstn) begin
		
		if(!rstn)
			present_state <= RESET;
		
		else
			present_state <= next_state;
		
	end
	
	assign z = ((present_state == S0000) || (present_state == S1111)) ? 1'b1 : 1'b0;
	
endmodule 