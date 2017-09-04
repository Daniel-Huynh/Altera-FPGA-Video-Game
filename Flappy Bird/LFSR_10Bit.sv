module LFSR_10Bit(Clock, Reset, out);
	output logic [9:0] out;
	input logic Clock, Reset;
	logic [9:0] ps;
	logic Xnor;
	
	always_comb begin
		Xnor = (ps[0] ^~ ps[3]);
		out = ps;
	end
	
	always_ff @(posedge Clock)
		if (Reset) 
			ps <= 10'b0000000000;
		else 
			ps <= {Xnor, ps[9:1]};
			
endmodule


module LFSR_10Bit_testbench();
	logic Clock, Reset;
	logic [9:0] out;
		

	LFSR_10Bit dut (Clock, Reset, out); 

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