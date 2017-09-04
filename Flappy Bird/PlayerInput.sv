module PlayerInput (clk, w1, out);
	input logic clk;
	input logic w1;
	output logic out;
	logic in_d1, in_d2, out_q1, out_q2;
	assign in_d1 = w1;
	assign in_d2 = out_q1;
	assign out = out_q2;
	

	always_ff @(posedge clk)
		begin
			out_q1 <= in_d1;
			out_q2 <= in_d2;
		end
endmodule 
	
	
module PlayerInput_testbench();
	logic clk, reset, w1;
	logic out;
		

	PlayerInput dut (clk, w1, out);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
 initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
 end

 // Set up the inputs to the design. Each line is a clock cycle.
 initial begin
							           @(posedge clk);
										  @(posedge clk);
   w1 <= 0;                     @(posedge clk);
										  @(posedge clk);
										  @(posedge clk);
										  @(posedge clk);
   w1 <= 1;                     @(posedge clk);
										  @(posedge clk);
										  @(posedge clk);	
						              @(posedge clk);
										  @(posedge clk);
   w1 <= 0;                     @(posedge clk);
										  @(posedge clk);
										  @(posedge clk);
										  @(posedge clk);
   w1 <= 1;                     @(posedge clk);
										  @(posedge clk);
										  @(posedge clk);	
	$stop; // End the simulation.
	end
endmodule 