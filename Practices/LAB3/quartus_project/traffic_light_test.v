module traffic_light_test (north_south,
							 east_west,
							 rstn,
							 clk,
							 time_sec
							 );
	
	parameter S0 = 0;
	parameter S1 = 1;
	parameter S2 = 2;
	parameter S3 = 3;
	parameter S4 = 4;
	parameter S5 = 5;
	
	output [2:0] north_south;
	output [2:0] east_west;
	output [2:0] time_sec;
	
	input rstn;
	input clk;
	
	reg [2:0] present_state;
	reg [2:0] next_state;
	reg [2:0] time_sec;
	reg change;
	
	always @(*) begin
	
		case (present_state)
		
			S0: begin
					change = (time_sec == 4) ? 1 : 0;
					next_state = (time_sec == 4) ? S1 : S0;
				end
			
			S1: begin
					change = 1;
					next_state = S2;
				end
			
			S2: begin
					change = 1;
					next_state = S3;
				end
			
			S3: begin
					change = (time_sec == 4) ? 1 : 0;
					next_state = (time_sec == 4) ? S4 : S3;
				end
			
			S4: begin
					change = 1;
					next_state = S5;
				end
			
			S5: begin
					change = 1;
					next_state = S0;
				end
		
		endcase
	
	end
	
	always @(posedge clk or negedge rstn) begin
	
		if(!rstn) begin
			present_state <= S0;
			time_sec <= 0;
		end
		
		else begin
		
			present_state <= next_state;
			
			if(change) 
				time_sec <= 0;
				
			else
				time_sec <= time_sec + 1;
			
		end
		
	end
	
	assign north_south = (present_state == S0) ? 3'b010 :
								(present_state == S1) ? 3'b001 : 3'b100;
								
	assign east_west = (present_state == S3) ? 3'b010 :
							 (present_state == S4) ? 3'b001 : 3'b100;
					 
endmodule 