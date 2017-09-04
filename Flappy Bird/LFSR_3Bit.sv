module LFSR_3Bit(Clock, Reset, out);
	output logic [2:0] out;
	input logic Clock, Reset;
	logic [2:0] ps;
	logic Xnor;
	//assign out = 5;
	always_comb begin
		Xnor = (ps[2] ^~ ps[1]);
		out = ps;
	end
	
	always_ff @(posedge Clock)
		if (Reset) 
			ps <= 3'b000;
		else 
			ps <= {ps[1:0], Xnor};
			
endmodule


module LFSR_3Bit_testbench();
	logic Clock, Reset;
	logic [2:0] out;
		

	LFSR_3Bit dut (Clock, Reset, out); 

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
 initial begin
	Clock <= 0;
	forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
 end

 // Set up the inputs to the design. Each line is a clock cycle.
 initial begin
		Reset <= 1;												@(posedge Clock);
																	@(posedge Clock);
		Reset <= 0;												@(posedge Clock);
																	@(posedge Clock);
																	@(posedge Clock);
																	@(posedge Clock);
																	@(posedge Clock);
																	@(posedge Clock);
																	@(posedge Clock);
																	@(posedge Clock);
																	@(posedge Clock);
																	@(posedge Clock);
																	@(posedge Clock);
																	@(posedge Clock);
																	@(posedge Clock);
																	@(posedge Clock);
																	@(posedge Clock);
																	@(posedge Clock);



	$stop; // End the simulation.
	end
endmodule 