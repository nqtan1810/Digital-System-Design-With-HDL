module Mux_5to1_1_bit ( m,
								sel,
								u,
								v,
								w,
								x,
								y
								);
		
	output m;
	
	input [2:0] sel;
	input u;
	input v;
	input w;
	input x;
	input y;
	
	wire uv;
	wire wx;
	wire uvwx;
	
	Mux_2to1_bit m1(.m(uv), .s(sel[0]), .x(u), .y(v));
	Mux_2to1_bit m2(.m(wx), .s(sel[0]), .x(w), .y(x));
	Mux_2to1_bit m3(.m(uvwx), .s(sel[1]), .x(uv), .y(wx));
	Mux_2to1_bit m4(.m(m), .s(sel[2]), .x(uvwx), .y(y));
								
endmodule 