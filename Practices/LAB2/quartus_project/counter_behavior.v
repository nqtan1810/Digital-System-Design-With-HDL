module counter_behavior (Q,
								 Clock,
								 Enable,
								 Clear
								 );
								 
	output [3:0] Q;
	
	input Clock;
	input Enable;
	input Clear;
	
	reg [3:0] Q;
	
	always @(posedge Clock or negedge Clear) begin
		
		if(!Clear)
			Q <= 0;
			
		else if(Enable)
			Q <= Q + 1;
	
	end

endmodule 