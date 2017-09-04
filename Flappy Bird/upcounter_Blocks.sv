module upcounter_Blocks #(parameter WIDTH=10)
	(reset, clk, out);
	
	output logic out;
	input logic reset, clk;
	logic [WIDTH-1:0] cycle;
	assign out = (cycle == 1023);
	
	always_ff @(posedge clk) begin
		if (reset) begin
			cycle <= 10'b0000000000;
		end
		else 
			cycle <= cycle + 10'b0000000001;
	end
	
endmodule		

module upcounter_Blocks_testbench();
	logic out;
	logic [9:0] cycle;
	logic reset, clk;
		

	upcounter_Blocks #(10) dut (.reset, .clk, .out);

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