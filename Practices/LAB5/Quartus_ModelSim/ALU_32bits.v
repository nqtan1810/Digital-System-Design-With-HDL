module ALU_32bits ( zero,
						  S,
						  A,
						  B,
						  M,
						  S1,
						  S0
);
//--------------------------------------------
	output zero;
	output reg[31:0] S;
	input[31:0] A;
	input[31:0] B;
	input M;
	input S1;
	input S0;
//--------------------------------------------
	always @(A, B, M, S1, S0) begin
		case ({M, S1, S0})
			3'b000: S= ~A;
			3'b001: S= A&B;
			3'b010: S= A^B;
			3'b011: S= A|B;
			3'b100: S= A+1;
			3'b101: S= A+B;
			3'b110: S= A-B;
			3'b111: S= A-1;
			default: S=0;
		endcase
	end
	
	assign zero = (S === 0) ? 1 : 0;
	
endmodule
