module div_50MHz_clock (clk_1Hz, clk_50MHz, reset_n);				
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
module traffic_light (north_south,
							 east_west,
							 rstn,
							 clk_50MHz
							 );
	parameter S0 = 0;
	parameter S1 = 1;
	parameter S2 = 2;
	parameter S3 = 3;
	parameter S4 = 4;
	parameter S5 = 5;
	output [2:0] north_south;
	output [2:0] east_west;
	input rstn;
	input clk_50MHz;
	reg [2:0] present_state;
	reg [2:0] next_state;
	reg [2:0] time_sec;
	reg change;
	wire clk_1Hz;
	div_50MHz_clock clock_1Hz(.clk_1Hz(clk_1Hz),
									  .clk_50MHz(clk_50MHz),
									  .reset_n(rstn)
									  );
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
	always @(posedge clk_1Hz or negedge rstn) begin
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