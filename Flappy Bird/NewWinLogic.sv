module NewWinLogic(Clock, Reset, Button, LED , Win, ResetGame);  
	output logic [6:0] Win;
	output logic ResetGame;
	input logic Clock, Reset;
	input logic LED, Button;
 
 	
	enum {Zero, One, Two, Three, Four, Five, Six, Seven} ps, ns;

	always_comb
	case (ps)
	Zero: begin
		ResetGame = 0;
		Win = ~(7'b0111111);
		if (Button & LED) begin
			ns = One;
			ResetGame = 1;
		end
		else 
			ns = Zero;
	end
	One: begin
		ResetGame = 0;	
		Win = ~(7'b0000110);
		if (Button & LED) begin
			ns = Two;
			ResetGame = 1;
		end
		else 
			ns = One;
	end
	Two: begin
		ResetGame = 0;	
		Win = ~(7'b1011011);
		if (Button & LED) begin
			ns = Three;
			ResetGame = 1;
		end
		else 
			ns = Two;
	end
	Three: begin
		ResetGame = 0;
		Win = ~(7'b1001111);
		if (LED & Button) begin
			ns = Four;
			ResetGame = 1;
		end
		else 
			ns = Three;
	end
	Four: begin
		ResetGame = 0;
		Win = ~(7'b1100110);
		if (Button & LED) begin
			ns = Five;
			ResetGame = 1;
		end
		else 
			ns = Four;
	end
	Five: begin
		ResetGame = 0;
		Win = ~(7'b1101101);
		if (Button & LED) begin
			ns = Six;
			ResetGame = 1;
		end
		else 
			ns = Five;
	end
	Six: begin
		ResetGame = 0;
		Win = ~(7'b1111101);
		if (Button & LED) begin
			ns = Seven;
		end
		else 
			ns = Six;
	end
	Seven: begin
		ResetGame = 0;
		Win = ~(7'b0000111);
		ns = Seven;
	end
	endcase
		
	always_ff @(posedge Clock)
		if (Reset) 
			ps <= Zero;
		else 
			ps<= ns;
			
endmodule

module NewWinLogic_testbench();
	logic Clock, Reset, Button, LED, ResetGame;
	logic [6:0] Win;
		

	NewWinLogic dut (Clock, Reset, Button, LED , Win, ResetGame); 

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
 initial begin
	Clock <= 0;
	forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
 end

 // Set up the inputs to the design. Each line is a clock cycle.
 initial begin
  Reset <= 1;  LED <= 0; Button <= 0; 							@(posedge Clock);
 																			@(posedge Clock);
																			@(posedge Clock);
  Reset <= 0;  LED <= 0; Button <= 0; 							@(posedge Clock);
  LED <= 1; Button <= 1; 											@(posedge Clock);
																			@(posedge Clock);
  LED <= 1; Button <= 1; 											@(posedge Clock);
 																			@(posedge Clock);
  LED <= 1; Button <= 1; 											@(posedge Clock);
 																			@(posedge Clock);
  LED <= 1; Button <= 1; 											@(posedge Clock);
 																			@(posedge Clock);
  LED <= 1; Button <= 1; 											@(posedge Clock);
  																			@(posedge Clock);
  LED <= 1; Button <= 1; 											@(posedge Clock);
 																			@(posedge Clock);
  LED <= 1; Button <= 1; 											@(posedge Clock);
 																			@(posedge Clock);
  LED <= 1; Button <= 1; 											@(posedge Clock);
  LED <= 1; Button <= 1; 											@(posedge Clock);






	$stop; // End the simulation.
	end
endmodule 

	
		
