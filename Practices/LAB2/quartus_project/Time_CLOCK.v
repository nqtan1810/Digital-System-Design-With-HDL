module split_digit(out0,
						 out1,
						 num
						 );
			
	output [3:0] out0;
	output [3:0] out1;
	
	input [5:0] num;
	
	reg [3:0] out0;
	reg [3:0] out1;
	
	always @(*) begin
		
		out0 = (num >= 50) ? (num - 50) :
				 (num >= 40) ? (num - 40) :
				 (num >= 30) ? (num - 30) :
				 (num >= 20) ? (num - 20) :
				 (num >= 10) ? (num - 10) : num;
				 
		out1 = (num >= 50) ? 5 :
				 (num >= 40) ? 4 :
				 (num >= 30) ? 3 :
				 (num >= 20) ? 2 :
				 (num >= 10) ? 1 : 0;
		
	end
			
endmodule 

module checker(error,
					hour,
					minute,
					second
					);
					
	output error;
	
	input [5:0] hour;
	input [5:0] minute;
	input [5:0] second;
	
	reg error;
	
	always @(*) begin
		
		error = (hour > 23) ? 1 :
				  (minute > 59) ? 1 :
				  (second > 59) ? 1 : 0;
		
	end
					
endmodule 

module Time_Counter(hour,
						  minute,
						  second,
						  clock,
						  reset_n,
						  config_en,
						  hour_config,
						  minute_config,
						  second_config
						  );
		
	output [5:0] hour;	
	output [5:0] minute;
	output [5:0] second;
	
	input clock;
	input reset_n;
	input config_en;
	input [5:0] hour_config;
	input [5:0] minute_config;
	input [5:0] second_config;
	
	reg [5:0] hour;	
	reg [5:0] minute;
	reg [5:0] second;
	
	always @(posedge clock or negedge reset_n or posedge config_en) begin
	
		second <= (!reset_n) ? 0 : 				// neu khong can reset second thi sua lai ngay cho nay
				  (config_en) ? second_config :
				  (second < 59) ? (second + 1) : 0;
				  
		minute <= (!reset_n) ? 0 : 
				  (config_en) ? minute_config :
				  (second < 59) ? minute :
				  (minute < 59) ? (minute + 1) : 0;
	
		hour <= (!reset_n) ? 0 : 
				  (config_en) ? hour_config :
				  (minute < 59) ? hour :
				  (second < 59) ? hour : 
				  (hour < 23) ? (hour + 1) : 0;
	
	end
						
endmodule


module Time_CLOCK (hex0,
						 hex1,
						 hex2,
						 hex3,
						 hex4,
						 hex5,
						 error,
						 clock,
						 reset_n,
						 config_en,
						 hour_config,
						 minute_config,
						 second_config);

	output [6:0] hex5;
	output [6:0] hex4;
	output [6:0] hex3;
	output [6:0] hex2;
	output [6:0] hex1;
	output [6:0] hex0;
	output error;
	
	input clock;
	input reset_n;
	input config_en;
	input [5:0] hour_config;
	input [5:0] minute_config;
	input [5:0] second_config;
	
	reg error;
	
	wire clk_1Hz;
	wire [5:0] hour;
	wire [5:0] minute;
	wire [5:0] second;
	wire error_checker;
	wire [3:0] hex_digit5;
	wire [3:0] hex_digit4;
	wire [3:0] hex_digit3;
	wire [3:0] hex_digit2;
	wire [3:0] hex_digit1;
	wire [3:0] hex_digit0;
	
	reg config_en_error;
	
	
	div_50MHz_clock div_clock(.clk_1Hz(clk_1Hz), .clk_50MHz(clock), .reset_n(reset_n));
	
	checker(.error(error_checker), .hour(hour_config), .minute(minute_config), .second(second_config));
	
	always @(*) begin 
	
		config_en_error = (~error_checker) & config_en;
		error = error_checker & config_en;
	
	end
	
	Time_Counter Time(.hour(hour),
						  .minute(minute),
						  .second(second),
						  .clock(clk_1Hz),
						  .reset_n(reset_n),
						  .config_en(config_en_error),
						  .hour_config(hour_config),
						  .minute_config(minute_config),
						  .second_config(second_config));
						  
	split_digit split_hour(.out0(hex_digit4), .out1(hex_digit5), .num(hour));
	split_digit split_minute(.out0(hex_digit2), .out1(hex_digit3), .num(minute));
	split_digit split_second(.out0(hex_digit0), .out1(hex_digit1), .num(second));
	
	Seven_Segment_Decoder encoder0(.hex(hex0), .bin(hex_digit0));
	Seven_Segment_Decoder encoder1(.hex(hex1), .bin(hex_digit1));
	Seven_Segment_Decoder encoder2(.hex(hex2), .bin(hex_digit2));
	Seven_Segment_Decoder encoder3(.hex(hex3), .bin(hex_digit3));
	Seven_Segment_Decoder encoder4(.hex(hex4), .bin(hex_digit4));
	Seven_Segment_Decoder encoder5(.hex(hex5), .bin(hex_digit5));
						 
endmodule
						 
						 
						 
						 
						 
						 
						 
						 
						 