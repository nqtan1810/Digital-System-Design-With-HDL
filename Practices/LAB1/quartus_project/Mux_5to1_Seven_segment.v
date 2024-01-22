module Mux_5to1_Seven_segment ( OUT,
										  sel,
										  U,
										  V,
										  W,
										  X,
										  Y
										  );
			
	output [6:0] OUT;
	
	input [2:0] sel;
	input [2:0] U;
	input [2:0] V;
	input [2:0] W;
	input [2:0] X;
	input [2:0] Y;
	
	wire [2:0] OUT_MUX;
	
	Mux_5to1_3_bit M(.M(OUT_MUX), .sel(sel), .U(U), .V(V), .W(W), .X(X), .Y(Y));
	
	seven_segment S(.Y(OUT), .C(OUT_MUX));
										  
endmodule 