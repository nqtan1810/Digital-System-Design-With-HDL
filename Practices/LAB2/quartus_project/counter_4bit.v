module T_ff (q,
				 clock,
				 T,
				 clear
				 );

	output q;
	
	input clock;
	input T;
	input clear;
	
	reg q;
	
	always @(posedge clock or negedge clear) begin
	
		if (!clear) 
			q = 0;
			
		else if (T)
			q = ~q;
			
		else
			q = q;
			
	end

endmodule
				 
module counter_4bit (Q,
							Clock,
							Enable,
							Clear
							);
	
	output [3:0] Q;
	
	input Clock;
	input Enable;
	input Clear;
	
	reg T_in1;
	reg T_in2;
	reg T_in3;
	
	T_ff t0 (.q(Q[0]), .clock(Clock), .T(Enable), .clear(Clear));
	T_ff t1 (.q(Q[1]), .clock(Clock), .T(T_in1), .clear(Clear));
	T_ff t2 (.q(Q[2]), .clock(Clock), .T(T_in2), .clear(Clear));
	T_ff t3 (.q(Q[3]), .clock(Clock), .T(T_in3), .clear(Clear));
	
	always @(*) begin
	
		T_in1 = Enable & Q[0];
		T_in2 = T_in1 & Q[1];
		T_in3 = T_in2 & Q[2];
		
	end

endmodule 
