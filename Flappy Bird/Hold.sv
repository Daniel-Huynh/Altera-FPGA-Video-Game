module Hold (Clock, Reset, IN, out);
input logic Clock, IN, Reset;
output logic out;
	
	enum {HOLD , UNHOLD} ps, ns;

	always_comb
	case (ps)
		HOLD: begin 
				out = 0;
				if (IN) begin
					ns = HOLD;
				end
				else begin
					ns = UNHOLD;
					out = 1;
				end
		end
		 UNHOLD: begin
				out = 0;
				if (IN) begin
					ns = HOLD;
				end
				else begin
					ns = UNHOLD;
				end
		end
	endcase
		
	always_ff @(posedge Clock)
		if (Reset)
			ps <= UNHOLD;
		else 
			ps<= ns;
endmodule

module Hold_testbench();
	logic Clock, Reset, IN, out;
		

	Hold dut (Clock, Reset, IN, out);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
 initial begin
	Clock <= 0;
	forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
 end

 // Set up the inputs to the design. Each line is a clock cycle.
 initial begin
Reset <= 1;													@(posedge Clock);
																@(posedge Clock);
Reset <= 0;	IN	<= 1;										@(posedge Clock);
																@(posedge Clock);																
																@(posedge Clock);																
				IN <= 1;                            @(posedge Clock);																
				IN <= 1;                            @(posedge Clock);																
				IN <= 1;                            @(posedge Clock);																
				IN <= 0;                            @(posedge Clock);																
				IN <= 1;                            @(posedge Clock);																
				IN <= 0;                            @(posedge Clock);																
			
					
	$stop; // End the simulation.
	end
endmodule 
