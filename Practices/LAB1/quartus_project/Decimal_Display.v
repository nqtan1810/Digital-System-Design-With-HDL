
// module so sanh so nhap vao voi 9
module Comparator (z,
						 v
						 );
						 
	output z;
	
	input [3:0] v;
	
	assign z = (v <= 4'b1001) ? 1'b0 : 1'b1;

endmodule 


// module xu ly 3 bit LSB cua so nhap vao
module Circuit_A (m,
						v
						);
						
	output [2:0] m;
	
	input [2:0] v;
	
	assign m = (v == 3'b010) ? 3'b000 :
				  (v == 3'b011) ? 3'b001 :
				  (v == 3'b100) ? 3'b010 :
				  (v == 3'b101) ? 3'b011 :
				  (v == 3'b110) ? 3'b100 :
				  (v == 3'b111) ? 3'b101 : 3'bxxx;


endmodule 



// module xu ly 1 bit MSB cua so nhap vao
module Circuit_B (hex,
						z
						);
						
	output [6:0] hex;
	
	input z;
	
	assign hex = z == 1'b1 ? 7'b0000110 : 7'b0111111;

endmodule 



// module hien thi so Decimal tu 4bits Binary
module Seven_Segment_Decoder (hex,
										bin
										);
										
	output [6:0] hex;
	
	input [3:0] bin;
	
	assign hex = (bin == 4'b0000) ? 7'b0111111 :  
					 (bin == 4'b0001) ? 7'b0000110 :  
					 (bin == 4'b0010) ? 7'b1011011 :  
					 (bin == 4'b0011) ? 7'b1001111 :  
					 (bin == 4'b0100) ? 7'b1100110 :  
					 (bin == 4'b0101) ? 7'b1101101 :  
					 (bin == 4'b0110) ? 7'b1111101 :  
					 (bin == 4'b0111) ? 7'b0000111 :  
					 (bin == 4'b1000) ? 7'b1111111 :  
					 (bin == 4'b1001) ? 7'b1101111 : 7'bxxxxxxx; 

endmodule 



// module top cua toan he thong chuyen doi Binary sang Decimal
module Decimal_Display (d0,
								d1,
								v
								);
								
	output [6:0] d0;
	output [6:0] d1;
	
	input [3:0] v;
	
	wire z;
	wire [2:0] out_A;
	wire [3:0] m;
	
	
	Comparator C(.v(v), .z(z));
	
	Circuit_A C_A(.v(v[2:0]), .m(out_A));
	
	Mux_2to1_bit Mux0(.m(m[0]), .s(z), .x(v[0]), .y(out_A[0]));
	Mux_2to1_bit Mux1(.m(m[1]), .s(z), .x(v[1]), .y(out_A[1]));
	Mux_2to1_bit Mux2(.m(m[2]), .s(z), .x(v[2]), .y(out_A[2]));
	Mux_2to1_bit Mux3(.m(m[3]), .s(z), .x(v[3]), .y(1'b0));
	
	Circuit_B C_B(.hex(d1), .z(z));
	
	Seven_Segment_Decoder Seven_Segment(.hex(d0), .bin(m));
	
endmodule 