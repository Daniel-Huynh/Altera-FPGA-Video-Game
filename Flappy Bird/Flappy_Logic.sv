module Flappy_Logic(Clock, Reset, out);
	output logic [7:0] out;
	input logic Clock, Reset;
	logic [7:0] ps;
	logic Xnor;

	
	
	always_ff @(posedge Clock)
		if (Reset) 
			ps <= 8'b00000000;
		else 
			ps <= {ps[6:0], Xnor};
			
endmodule
