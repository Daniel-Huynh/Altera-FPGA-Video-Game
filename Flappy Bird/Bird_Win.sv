module Bird_Win(Clock, Reset, out);
	output logic [2:0] out;
	input logic Clock, Reset;
	logic [2:0] ps;
	logic Xnor;
	
	always_comb begin
		Xnor = (ps[2] ^~ ps[1]);
		out = ps;
	end
	
	always_ff @(posedge Clock)
		if (Reset) 
			ps <= 3'b000;
		else 
			ps <= {ps[2:1], Xnor};
			
endmodule