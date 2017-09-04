module Bird_Logic2 (clk, reset, Press, fall, Dead, Bird_dead, out);
	input logic clk;
	input logic Press, reset, fall, Dead; 
	output logic Bird_dead;
	output logic [7:0] out;
   enum {Bottom, LED2, LED3, Start, LED5, LED6, LED7, Top, Lose} ps, ns;
	
	 always_comb
		case (ps)
			Lose: begin
				Bird_dead = 1;
				out = 8'b00000000;
				ns = Lose;
			end
			Bottom: begin
				Bird_dead = 0;
				out = 8'b00000001;
				if (Dead)
					ns = Lose;
				else if (Press & fall) 
					ns = Bottom;
				else if (Press & ~fall)
					ns = LED2;
				else if (fall & ~Press)
					ns = Lose;
				else 
					ns = Bottom;
			end

			LED2: begin
				Bird_dead = 0;
				out = 8'b00000010;
				if (Dead)
					ns = Lose;
				else if (Press & fall)  
					ns = LED2;
				else if (Press & ~fall)
					ns = LED3;
				else if (fall & ~Press)
					ns = Bottom;
				else 
					ns = LED2;
			end

			LED3: begin
				Bird_dead = 0;
				out = 8'b00000100;
				if (Dead)
					ns = Lose;
				else if (Press & fall) 
					ns = LED3;
				else if (Press & ~fall)
					ns = Start;
				else if (fall & ~Press)
					ns = LED2;
				else 
					ns = LED3;
			end
					
			Start: begin
				Bird_dead = 0;
				out = 8'b00001000;
				if (Dead)
					ns = Lose;
				else if (Press & fall)  
					ns = Start;
				else if (Press & ~fall)
					ns = LED5;
				else if (fall & ~Press)
					ns = LED3;
				else 
					ns = Start;
			end
			
			LED5: begin
				Bird_dead = 0;
				out = 8'b00010000;
				if (Dead)
					ns = Lose;
				else if (Press & fall)  
					ns = LED5;
				else if (Press & ~fall)
					ns = LED6;
				else if (fall & ~Press)
					ns = Start;
				else 
					ns = LED5;
			end
					
			LED6: begin
				Bird_dead = 0;
				out = 8'b00100000;
				if (Dead)
					ns = Lose;
				else if (Press & fall) 
					ns = LED6;
				else if (Press & ~fall)
					ns = LED7;
				else if (fall & ~Press)
					ns = LED5;
				else 
					ns = LED6;
			end
			
		   LED7: begin
				Bird_dead = 0;
				out = 8'b01000000;
				if (Dead)
					ns = Lose;
				else if (Press & fall) 
					ns = LED7;
				else if (Press & ~fall)
					ns = Top;
				else if (fall & ~Press)
					ns = LED6;
				else 
					ns = LED7;
			end
					
			Top: begin
				Bird_dead = 0;
				out = 8'b10000000;
				if (Dead)
					ns = Lose;
				else if (Press & fall) 
					ns = Top;
				else if (Press & ~fall)
					ns = Top;
				else if (fall & ~Press)
					ns = LED7;
				else 
					ns = Top;
			end
	endcase

	always_ff @(posedge clk)
		if (reset)
			ps <= Start;
		else 
			ps <= ns;
endmodule 
	
	
module Bird_Logic2_testbench();
	logic clk, reset, Press, fall, Dead;
	logic [7:0] out;
		

	Bird_Logic2 dut (clk, reset, Press, fall, Dead, out);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
 initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk <= ~clk;
 end

 // Set up the inputs to the design. Each line is a clock cycle.
 initial begin
	reset = 1;						  @(posedge clk);
										  @(posedge clk);
	reset = 0;						  @(posedge clk);
										  @(posedge clk);
										  @(posedge clk);
	Press = 1; fall = 0;						  @(posedge clk);
	Press = 1; fall = 0;						  @(posedge clk);
	Press = 1; fall = 0;						  @(posedge clk);

	Press = 0; fall = 0;						  repeat(6)@(posedge clk);
	Press = 1; fall = 0;						  @(posedge clk);
	Press = 1; fall = 0;						  @(posedge clk);
	Press = 0; fall = 1;						  repeat(15)@(posedge clk);
	Press = 1; fall = 0;						  @(posedge clk);
	Press = 1; fall = 0;						  @(posedge clk);
	Press = 1; fall = 0;						  @(posedge clk);
	Press = 1; fall = 0;						  @(posedge clk);

	$stop; // End the simulation.
	end
endmodule