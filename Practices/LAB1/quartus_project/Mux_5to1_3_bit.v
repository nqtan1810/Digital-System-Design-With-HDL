module Mux_5to1_3_bit ( M,
								sel,
								U,
								V,
								W,
								X,
								Y
								);
		
	output [2:0] M;
	
	input [2:0] sel;
	input [2:0] U;
	input [2:0] V;
	input [2:0] W;
	input [2:0] X;
	input [2:0] Y;
	
	Mux_5to1_1_bit m0(.m(M[0]), .sel(sel), .u(U[0]), .v(V[0]), .w(W[0]), .x(X[0]), .y(Y[0]));
	Mux_5to1_1_bit m1(.m(M[1]), .sel(sel), .u(U[1]), .v(V[1]), .w(W[1]), .x(X[1]), .y(Y[1]));
	Mux_5to1_1_bit m2(.m(M[2]), .sel(sel), .u(U[2]), .v(V[2]), .w(W[2]), .x(X[2]), .y(Y[2]));
								
endmodule 