module Bird_Pipe_Interaction (clk, reset, LED_Green,LED_Red, Dead_out);
	input logic clk;
	input logic reset;
	input logic LED_Green,LED_Red;
	output logic Dead_out;
   enum {Alive, Dead} ps, ns;
	
	 always_comb
		case (ps)
			Alive: begin
				Dead_out = 0;
				if (LED_Green & LED_Red)
					ns = Dead;
				else
					ns = Alive;
			end
			Dead: begin
				Dead_out = 1;
				ns = Dead;
			end
	 endcase

			
	always_ff @(posedge clk)
		if (reset)
			ps <= Alive;
		else 
			ps <= ns;
endmodule 

module Bird_Pipe_Interaction_testbench();
	logic clk, reset, LED_Green,LED_Red, Dead_out;
		

	Bird_Pipe_Interaction dut (clk, reset, LED_Green,LED_Red, Dead_out);
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
 initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
 end

 // Set up the inputs to the design. Each line is a clock cycle.
 initial begin
	reset = 1;						  @(posedge clk);
										  repeat(5)@(posedge clk);
	reset = 0;						  @(posedge clk);
											@(posedge clk);
									repeat(10)@(posedge clk);

	$stop; // End the simulation.
	end
	
endmodule
				