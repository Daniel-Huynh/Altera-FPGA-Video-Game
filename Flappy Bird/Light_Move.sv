module Light_Move(Clock, Reset, Right, Turn_Off, LightOn);
	input logic Clock, Reset;
	input logic Right, Turn_Off;
	output logic LightOn;
	
	enum {ON, OFF} ps, ns;
	
	
	 always_comb
		case (ps)
			ON: begin
				LightOn = 1;
				if (Turn_Off) 
					ns = OFF;
				else 
					ns = ON;
			end
			OFF: begin
				LightOn = 0;
				if(Turn_Off) begin
					if (Right)
						ns = ON;
					else 
						ns = OFF;
				end
				else 
					ns = OFF;
			end
		endcase

		
	always_ff @(posedge Clock)
		if (Reset)
			ps <= OFF;
		else
			ps <= ns;

endmodule 

module Light_Move_testbench();
	logic Clock, Reset, Right, Turn_Off, LightOn;
		

	Light_Move dut (Clock, Reset, Right, Turn_Off, LightOn);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
 initial begin
	Clock <= 0;
	forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
 end

 // Set up the inputs to the design. Each line is a clock cycle.
 initial begin
  Reset <= 1;  														@(posedge Clock);
 																			@(posedge Clock);
																			@(posedge Clock);
  Reset <= 0;  Turn_Off <= 1; 				   repeat(15)@(posedge Clock);
  Right <= 1;  	 				   repeat(10)@(posedge Clock);

	$stop; // End the simulation.
	end
endmodule 	