module DE1_SoC (CLOCK_50, GPIO_0, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR,
SW);
	 input logic CLOCK_50; // 50MHz clock.
	 output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	 output logic [9:0] LEDR;
	 output logic [35:0] GPIO_0;
	 input logic [3:0] KEY; // True when not pressed, False when pressed
	 input logic [9:0] SW;
	 
	assign HEX3 = 7'b1111111;
	assign HEX4 = 7'b1111111;
   assign HEX5 = 7'b1111111;

	// Generate clk off of CLOCK_50, whichClock picks rate.
	 logic [31:0] clk;
	 parameter whichClock = 12;
	 clock_divider cdiv (CLOCK_50, clk); 


	 // Hook up FSM inputs and outputs.
	 logic Player1In, PlayerOutF, Player1Out, resetWin, Reset;
	 logic [7:0] ColumnArray, Pipe_Pattern, Pipes;
	 logic [7:0][7:0] red_array, green_array;
	 logic Dead_Signal0,Dead_Signal1,Dead_Signal2,Dead_Signal3,Dead_Signal4,Dead_Signal5,Dead_Signal6,Dead_Signal7;
	 logic Dead_Signal, Bird_dead;
	 logic incrOut1, incrOut2, incrOut3;
	 assign Dead_Signal = Bird_dead | Dead_Signal0 | Dead_Signal1 | Dead_Signal2 | Dead_Signal3 | Dead_Signal4 | Dead_Signal5 | Dead_Signal6 | Dead_Signal7;
	 logic counter_out, counter_out1, counter_out2, counter_out3;
	 assign Reset = SW[9];
	 assign Player1In = ~KEY[0];
	 assign red_array [1][7:0] = ColumnArray;
	 assign green_array [7][7:0] = Pipes;
	 //PlayerInput resetDFF(.clk(clk[whichClock]),.w1(Reset), .out(resetWin));
	 LFSR_3Bit guess(.Clock(clk[whichClock]), .Reset, .out(Pipe_Pattern));
	 Choose_Blocks choose(.Clock(clk[whichClock]), .Reset, .in(Pipe_Pattern) , .enable(counter_out2), .out(Pipes));
	 
	 PlayerInput Play1(.clk(clk[whichClock]),.w1(Player1In), .out(PlayerOutF));
	 Hold Player1(.Clock(clk[whichClock]), .Reset(Reset), .IN(PlayerOutF), .out(Player1Out));
	 
	 IncrementScore beh(.clk(clk[whichClock]), .reset(Reset),.enable(counter_out1), .Stop(Dead_Signal),.incrOut(incrOut1));
	 Score_Ones buh(.clk(clk[whichClock]), .reset(Reset), .IncrIn(incrOut1), .incrOut(incrOut2), .out(HEX0));
	 Score_Tens why(.clk(clk[whichClock]), .reset(Reset), .IncrIn(incrOut2), .incrOut(incrOut3), .out(HEX1));
	 Score_Hundreds god(.clk(clk[whichClock]), .reset(Reset), .IncrIn(incrOut3), .out(HEX2));

	 upcounter_fall 	#(12) 	stuff(.reset(Reset), .clk(clk[whichClock]), .out(counter_out));
	 upcounter_Blocks 	#(10) 	stuff1(.reset(Reset), .clk(clk[whichClock]), .out(counter_out1));
	 upcounter_generate 	#(14) 	stuff2(.reset(Reset), .clk(clk[whichClock]), .out(counter_out2));
	 upcounter_Score 	#(15) 	stuff3(.reset(Reset), .clk(clk[whichClock]), .out(counter_out3));

	 //genvar k;
	 //genvar l;
	 //generate
		//for(k=1; k<=1; k++) begin : Row
			//for(l=0; l<8; l++) begin : Column
			Bird_Pipe_Interaction UHH0(.clk(clk[whichClock]), .reset(Reset), .LED_Green(green_array[1][0]),.LED_Red(red_array[1][0]), .Dead_out(Dead_Signal0));
			Bird_Pipe_Interaction UHH1(.clk(clk[whichClock]), .reset(Reset), .LED_Green(green_array[1][1]),.LED_Red(red_array[1][1]), .Dead_out(Dead_Signal1));
			Bird_Pipe_Interaction UHH2(.clk(clk[whichClock]), .reset(Reset), .LED_Green(green_array[1][2]),.LED_Red(red_array[1][2]), .Dead_out(Dead_Signal2));
			Bird_Pipe_Interaction UHH3(.clk(clk[whichClock]), .reset(Reset), .LED_Green(green_array[1][3]),.LED_Red(red_array[1][3]), .Dead_out(Dead_Signal3));
			Bird_Pipe_Interaction UHH4(.clk(clk[whichClock]), .reset(Reset), .LED_Green(green_array[1][4]),.LED_Red(red_array[1][4]), .Dead_out(Dead_Signal4));
			Bird_Pipe_Interaction UHH5(.clk(clk[whichClock]), .reset(Reset), .LED_Green(green_array[1][5]),.LED_Red(red_array[1][5]), .Dead_out(Dead_Signal5));
			Bird_Pipe_Interaction UHH6(.clk(clk[whichClock]), .reset(Reset), .LED_Green(green_array[1][6]),.LED_Red(red_array[1][6]), .Dead_out(Dead_Signal6));
			Bird_Pipe_Interaction UHH7(.clk(clk[whichClock]), .reset(Reset), .LED_Green(green_array[1][7]),.LED_Red(red_array[1][7]), .Dead_out(Dead_Signal7));

			//end
		//end
	 //endgenerate
	 Bird_Logic2 Chicken(.clk(clk[whichClock]), .reset(Reset), .Press(Player1Out), .fall(counter_out), .Dead(Dead_Signal),.Bird_dead,.out(ColumnArray));
	 //Bird_Logic Chicken(.clk(clk[whichClock]), .reset(Reset), .Press(Player1Out), .fall(counter_out), .out(ColumnArray));
	 genvar i;
	 genvar j;
	 generate
		 for(i=0; i<7; i++) begin : eachRow
			for(j=0; j<8; j++) begin : eachLED
				Light_Move move(.Clock(clk[whichClock]), .Reset, .Right(green_array[i+1][j]), .Turn_Off(counter_out1), .LightOn(green_array[i][j]));
		 end
		 end
	 endgenerate 
	 led_matrix_driver  test(.clock(clk[whichClock]), .red_array(red_array), .green_array(green_array), .red_driver(GPIO_0[27:20]), .green_driver(GPIO_0[35:28]), .row_sink(GPIO_0[19:12]));
endmodule


// divided_clocks[0] = 25MHz, [1] = 12.5Mhz, ... [23] = 3Hz, [24] = 1.5Hz,
//[25] = 0.75Hz, ...
module clock_divider (clock, divided_clocks);
 input logic clock;
 output logic [31:0] divided_clocks;

 initial
 divided_clocks <= 0;

 always_ff @(posedge clock)
 divided_clocks <= divided_clocks + 1;
endmodule 

module DE1_SoC_testbench();
	logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
	logic [9:0] LEDR;
	logic [3:0] KEY;
	logic [9:0] SW;
	logic clk;
	logic [35:0] GPIO_0;
	logic [7:0] RowArray;
	logic Player1In, PlayerOutF, Player1Out, resetWin, Reset;
	logic [7:0][7:0] red_array, green_array;

	DE1_SoC dut (.CLOCK_50(clk), .GPIO_0, .HEX0, .HEX1, .HEX2, .HEX3, .HEX4, .HEX5, .KEY, .LEDR,
	.SW);
	// Try all combinations of inputs.
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
 initial begin
	clk <= 0;
	forever #(CLOCK_PERIOD/2) clk<= ~clk;
 end

 // Set up the inputs to the design. Each line is a clock cycle.
 initial begin
 
       SW[9] <= 1; KEY[0] <= 0; @(posedge clk); 
																			@(posedge clk); 
																		  repeat(10)@(posedge clk); 
		 SW[9] <= 0; KEY[0] <= 1;									repeat(2)@(posedge clk); 
						 KEY[0] <= 0;                          repeat(2)@(posedge clk); 
						 KEY[0] <= 1;                          repeat(2)@(posedge clk); 
						 KEY[0] <= 0;                          repeat(2)@(posedge clk); 
						 KEY[0] <= 1;                          repeat(2)@(posedge clk); 
						 KEY[0] <= 0;                          repeat(2)@(posedge clk); 
						 KEY[0] <= 1;                          repeat(2)@(posedge clk); 
						 KEY[0] <= 0;                          repeat(2)@(posedge clk); 
						 KEY[0] <= 1;                          repeat(2)@(posedge clk);
	$stop; // End the simulation.
	end 
endmodule
