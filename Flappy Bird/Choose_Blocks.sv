module Choose_Blocks(Clock, Reset,in, enable, out);
	input logic Clock, Reset;
	input logic [2:0] in;
	input logic enable;
	output logic [7:0] out;
	
	
	always_comb begin
		if (Reset) 
			out = 8'b00000000;
		else
			if (enable)
				case(in)
				3'b000: out = 8'b10011111;
				3'b001: out = 8'b11001111;
				3'b010: out = 8'b11100111;
				3'b011: out = 8'b11110011;
				3'b100: out = 8'b11111001;
				3'b101: out = 8'b11000011;
				default: out = 8'b11100111;
				endcase
			else 
				out = 8'b00000000;
	end
endmodule

module Choose_Blocks_testbench();
	logic Clock, Reset;
   logic [2:0] in;
	logic [7:0] out;
		

	Choose_Blocks dut (.Clock, .Reset,.in, .out);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
 initial begin
	Clock <= 0;
	forever #(CLOCK_PERIOD/2) Clock <= ~Clock;
 end

 // Set up the inputs to the design. Each line is a clock cycle.
 initial begin
	Reset = 1;						  @(posedge Clock);
										  @(posedge Clock);
	Reset = 0;						  @(posedge Clock);
	in = 3'b000;					  @(posedge Clock);
	in = 3'b001;					  @(posedge Clock);

	$stop; // End the simulation.
	end
	
endmodule