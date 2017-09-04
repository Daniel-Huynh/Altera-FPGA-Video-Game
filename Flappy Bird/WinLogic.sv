module WinLogic (Clock, Reset, L, R, LED9, LED1, Win);  
	output logic [6:0] Win;
	input logic Clock, Reset;
	input logic L, R, LED9, LED1;
 
 	
	enum {Player1, Player2, Nobody} ps, ns;

	always_comb
	case (ps)
	
	Player1: begin
			Win = 7'b0100100;// Player 2
			ns = Player1;
	end
	Player2: begin
			Win = 7'b1111001;// Player 1
			ns = Player2;
	end
	Nobody: begin
		Win = 7'b1111111;
		if (LED1 & R)
			ns = Player2;
		else if (LED9 & L)
			ns = Player1;
		else 
			ns = Nobody;
	end
endcase
		
	always_ff @(posedge Clock)
		if (Reset) begin
			ps <= Nobody;
		end
		else 
			ps<= ns;
			
endmodule

module WinLogic_testbench();
	logic Clock, Reset, L, R, LED9, LED1;
	logic [6:0] Win;
		

	WinLogic dut (Clock, Reset, L, R, LED9, LED1, Win);  

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
 initial begin
	Clock <= 0;
	forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
 end

 // Set up the inputs to the design. Each line is a clock cycle.
 initial begin
  Reset <= 1;  L <= 0; R <= 0; 							@(posedge Clock);
																	@(posedge Clock);
																	@(posedge Clock);
																	@(posedge Clock);
  Reset <= 0;  L <= 0; R <= 0; LED9 = 1; LED1 = 0; @(posedge Clock);
  Reset <= 0;  L <= 1; R <= 0; LED9 = 1; LED1 = 0; @(posedge Clock);
  Reset <= 0;  L <= 0; R <= 0; LED9 = 1; LED1 = 0; @(posedge Clock);
  Reset <= 1;  L <= 0; R <= 0; LED9 = 1; LED1 = 0; @(posedge Clock);
  Reset <= 0;  L <= 0; R <= 0; LED9 = 1; LED1 = 0; @(posedge Clock);
  Reset <= 0;  L <= 0; R <= 0; LED9 = 1; LED1 = 0; @(posedge Clock);
  Reset <= 0;  L <= 0; R <= 1; LED9 = 0; LED1 = 1; @(posedge Clock);
																	@(posedge Clock);
																	@(posedge Clock);
																	@(posedge Clock);



	$stop; // End the simulation.
	end
endmodule 

	
		
