module FFD_resettable(q,
							 clock,
							 rstn,
							 d
							 );

   parameter WIDTH = 32;
	
	output [WIDTH-1:0] q;
	
   input  [WIDTH-1:0] d;
   input clock, rstn;

   reg [WIDTH-1:0] register;
	
   always @(posedge clock) begin

		if (!rstn) 
			register <= 0;
			
      else 
			register <= d;
			
	end	
	
	assign q = register;
	
endmodule 