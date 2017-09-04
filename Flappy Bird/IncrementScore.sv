module IncrementScore(clk, reset,enable, Stop, incrOut);
	input logic clk, reset, enable, Stop;
	output logic incrOut;

	enum {One, Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Eleven, Twelve, Thirteen, Fourteen, Fifteen, Sixteen, Seventeen} ps, ns; 
	always_comb 
		case(ps) 
			One: begin
				incrOut = 0;
				if (enable)
					ns = Two;
				else 
					ns = One;
			end
			Two: begin
				incrOut = 0;
				if (enable)
					ns = Three;
				else 
					ns = Two;
			end
			Three: begin
				incrOut = 0;
				if (enable)
					ns = Four;
				else 
					ns = Three;
			end
			Four: begin
				incrOut = 0;
				if (enable)
					ns = Five;
				else 
					ns = Four;
			end
			Five: begin
				incrOut = 0;
				if (enable)
					ns = Six;
				else 
					ns = Five;
			end
			Six: begin
				incrOut = 0;
				if (enable)
					ns = Seven;
				else 
					ns = Six;
			end
			Seven: begin
				incrOut = 0;
				if (enable)
					ns = Eight;
				else 
					ns = Seven;
			end
			Eight: begin
				incrOut = 0;
				if (enable)
					ns = Nine;
				else 
					ns = Eight;
			end
			Nine: begin
				incrOut = 0;
				if (enable)
					ns = Ten;
				else 
					ns = Nine;
			end
				Ten: begin
				incrOut = 0;
				if (enable)
					ns = Eleven;
				else 
					ns = Ten;
			end
			Eleven: begin
				incrOut = 0;
				if (enable)
					ns = Twelve;
				else 
					ns = Eleven;
			end
			Twelve: begin
				incrOut = 0;
				if (enable)
					ns = Thirteen;
				else 
					ns = Twelve;
			end
			Thirteen: begin
				incrOut = 0;
				if (enable)
					ns = Fourteen;
				else 
					ns = Thirteen;
			end
			Fourteen: begin
				incrOut = 0;
				if (enable)
					ns = Fifteen;
				else 
					ns = Fourteen;
			end
			Fifteen: begin
				incrOut = 0;
				if (enable)
					ns = Sixteen;
				else 
					ns = Fifteen;
			end
			Sixteen: begin
				incrOut = 0;
				if (enable)
					ns = Seventeen;
				else 
					ns = Sixteen;
			end
			Seventeen: begin
				incrOut = 1;
				ns = One;
			end
		endcase
		
	always_ff @(posedge clk)
		if (reset | Stop)
			ps <= One;
		else 
			ps <= ns;
//		if (reset | Stop) 
//			incrOut = 0;
//		else if (enable) 
//			incrOut = 1;
//		else 
//			incrOut = 0;
//	end
endmodule

module IncrementScore_testbench();
	logic incrOut;
	logic enable, Stop;
	logic reset, clk;
		

	IncrementScore dut (.clk, .reset,.enable, .Stop, .incrOut);

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
	enable = 1; 					  repeat(5)@(posedge clk);
	enable = 0;  					repeat(10)@(posedge clk);

	$stop; // End the simulation.
	end
	
endmodule