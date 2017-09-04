module Comparator(Reset, A, B, out);
	input logic Reset;
	input logic [9:0] A, B;
	output logic out;
	
		always_comb begin
		if (Reset)
			out = 0;
		else if (A[9] > B[9])
			out = 1;
		else if (A[9] < B[9])
			out = 0;
		else if (A[8] > B[8])
			out = 1;
		else if (A[8] < B[8])
			out = 0;
		else if (A[7] > B[7])
			out = 1;
		else if (A[7] < B[7])
			out = 0;
		else if (A[6] > B[6])
			out = 1;
		else if (A[6] < B[6])
			out = 0;
		else if (A[5] > B[5])
			out = 1;
		else if (A[5] < B[5])
			out = 0;
		else if (A[4] > B[4])
			out = 1;
		else if (A[4] < B[4])
			out = 0;
		else if (A[3] > B[3])
			out = 1;
		else if (A[3] < B[3])
			out = 0;
		else if (A[2] > B[2])
			out = 1;
		else if (A[2] < B[2])
			out = 0;
		else if (A[1] > B[1])
			out = 1;
		else if (A[1] < B[1])
			out = 0;
		else if (A[0] > B[0])
			out = 1;
		else  
			out = 0;
	end
	
endmodule

module Comparator_testbench();
	logic Reset;
	logic [9:0] A, B;
	logic out;
	Comparator dut (Reset, A, B, out);
	// Try all combinations of inputs.
	initial begin
		 A = 10'b0101100101;
	end
		integer i;
		
	initial begin
		for(i = 0; i < 1024; i++) begin
		B[9:0] = i; #10;
		end
	end
endmodule
	