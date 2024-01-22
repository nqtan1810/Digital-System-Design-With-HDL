module morse_encoder (morse,
							 clk_50MHz,
							 SW,
							 KEY,
							 present_state
							 );
							 
	parameter S0 = 0;
	parameter S1 = 1;
	parameter S2 = 2;
	parameter S3 = 3;
	parameter S4 = 4;
	parameter S5 = 5;
	parameter S6 = 6;
	parameter S7 = 7;
	parameter A = 0;
	parameter B = 1;
	parameter C = 2;
	parameter D = 3;
	parameter E = 4;
	parameter F = 5;
	parameter G = 6;
	parameter H = 7;
	parameter LONG = 3;
	parameter SHORT = 1;
	parameter SNAP = 1;
							 
	output morse;
	output [2:0] present_state;
	
	input clk_50MHz;
	input [2:0] SW;
	input [1:0] KEY;
	
	reg [2:0] present_state;
	reg [2:0] next_state;
	reg [2:0] char;
	reg [1:0] time_sec;
	reg change;
	
	wire clk;
	
	div_50MHz_clock clock_1Hz(.clk_1Hz(clk),
									  .clk_50MHz(clk_50MHz),
									  .reset_n(KEY[0])
									  );
	
	always @(*) begin 
	
		case(present_state)
		
			S0: begin
					next_state = ((char == A || char == E || char == F || char == H) || (time_sec == 2)) ? S1 : S0;
					change = ((char == A || char == E || char == F || char == H) || (time_sec == 2)) ? 1 : 0;
				end
				
			S1: begin
					next_state = S2;
					change = 1;
				end
			
			S2: begin
					next_state = ((char == B || char == C || char == D || char == F || char == H) 
									 || ((char == A  || char == G) && time_sec == 2) 
									 || (char == E)) ? S3 : S2;
					change = ((char == B || char == C || char == D || char == F || char == H) 
								|| ((char == A || char == G) && time_sec == 2) 
								|| (char == E)) ? 1 : 0;
				end
			
			S3: begin
					next_state = S4;
					change = 1;
				end
			
			S4: begin
					next_state = ((char == B || char == D || char == H) 
									 || ((char == C || char == F) && time_sec == 2) 
									 || (char == E || char == A || char == G)) ? S5 : S4;
					change = ((char == B || char == D || char == H) 
								|| ((char == C || char == F) && time_sec == 2) 
								|| (char == E || char == A || char == G)) ? 1 : 0;
				end
			
			S5: begin
					next_state = S6;
					change = 1;
				end
			
			S6: begin
					next_state = ((char == B || char == C || char == F || char == H) || (char == A || char == D || char == E || char == G)) ? S7 : S6;
					change = ((char == B || char == D || char == H) 
								|| ((char == C || char == F) && time_sec == 2) 
								|| (char == E || char == A)) ? 1 : 0;
				end
				
			S7: begin
					next_state = S0;
					change = 1;
				end
		
		endcase
	
	end
	
	always @(posedge clk or negedge KEY[0] or negedge KEY[1]) begin
	
		if(!KEY[0]) begin
		
			time_sec <= 0;
			present_state <= S0;
			char <= SW;
		
		end
		else if(!KEY[1]) begin
		
			char <= SW;
			time_sec <= 0;
			present_state <= S0;
		
		end
		else begin
		
			present_state <= next_state;
			
			if (change)
				time_sec <= 0;
			
			else
				time_sec <= time_sec + 1;
		
		end
	
	end
	
	assign morse = (present_state == S0 || present_state == S2 && char != E || present_state == S4 && char != A && char != E || present_state == S6 && char != A && char != D && char != E && char != G) ? 1 : 0;
							 
endmodule 