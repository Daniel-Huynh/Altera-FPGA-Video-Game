module Score_Hundreds(clk, reset, IncrIn, out);
	input logic clk, reset, IncrIn;
	output logic [6:0] out;
	
		enum {Zero, One, Two, Three, Four, Five, Six, Seven, Eight, Nine} ps, ns;

	always_comb
	case (ps)
	Zero: begin
		out = ~(7'b0111111);
		if (IncrIn) begin
			ns = One;
		end
		else 
			ns = Zero;
	end
	One: begin
		out = ~(7'b0000110);
		if (IncrIn) begin
			ns = Two;
		end
		else 
			ns = One;
	end
	Two: begin
		out = ~(7'b1011011);
		if (IncrIn) begin
			ns = Three;
		end
		else 
			ns = Two;
	end
	Three: begin
		out = ~(7'b1001111);
		if (IncrIn) begin
			ns = Four;
		end
		else 
			ns = Three;
	end
	Four: begin
		out = ~(7'b1100110);
		if (IncrIn) begin
			ns = Five;
		end
		else 
			ns = Four;
	end
	Five: begin
		out = ~(7'b1101101);
		if (IncrIn) begin
			ns = Six;
		end
		else 
			ns = Five;
	end
	Six: begin
		out = ~(7'b1111101);
		if (IncrIn) begin
			ns = Seven;
		end
		else 
			ns = Six;
	end
	Seven: begin
		out = ~(7'b0000111);
		if (IncrIn)
			ns = Eight;
		else 
			ns = Seven;
	end
	Eight: begin
		out = ~(7'b1111111);
		if (IncrIn)
			ns = Nine;
		else 
			ns = Eight;
	end
	Nine: begin
		out = ~(7'b1101111);
	   ns = Nine;
	end
	endcase
		
	always_ff @(posedge clk)
		if (reset) 
			ps <= Zero;
		else 
			ps<= ns;
			
endmodule

module Score_Hundreds_testbench();
	logic clk, reset, IncrIn, enable, incrOut;
	logic [6:0] out;
		

	Score_Hundreds dut (clk, reset, IncrIn, incrOut, out);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
 initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
 end

 // Set up the inputs to the design. Each line is a clock cycle.
 initial begin
  reset <= 1;  														@(posedge clk);
 																			@(posedge clk);
																			@(posedge clk);
  reset <= 0;  IncrIn <= 1; 				   repeat(15)@(posedge clk);
  reset <= 0;  IncrIn <= 0; 				   repeat(10)@(posedge clk);







	$stop; // End the simulation.
	end
endmodule 