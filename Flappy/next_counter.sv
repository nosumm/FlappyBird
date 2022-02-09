// counter uses increment signal to increment score for hexdisplay
module next_counter(S, next_in, Reset, game_over, Clock, next_out);
  input logic Clock, Reset, game_over;
  output logic [3:0] S;
  input next_in;
  output reg next_out;
  
  
  always_ff @(posedge Clock) begin
    if(Reset | game_over) begin
	   S <= 4'b0000;
		next_out <= 0;
	end else if(next_in) begin
     if (S == 4'b1001) begin
	    S <= 4'b0000; // if S = 9 and increment is HIGH reset this digit
	    next_out <= 1; // output next as HIGH
	  end else begin
	   S <= S + 4'b0001; // S = S + 1 
		next_out <= 0;
     end
  end
  end
  
endmodule


module next_counter_testbench();
	reg clk, Reset, test, increment;
	wire [3:0] S;

	next_counter dut(S, test, Reset, clk);
	
	parameter CLOCK_PERIOD = 100;
	
	initial clk = 1; 
	always begin 
		#(CLOCK_PERIOD/2); 
		clk = ~clk; 
	end 
	
	initial begin 
						@(posedge clk);
		Reset <= 1; @(posedge clk); 
						@(posedge clk); 
						@(posedge clk); 
						@(posedge clk); 
						@(posedge clk);	
		Reset <= 0; @(posedge clk); 
						@(posedge clk); 
						@(posedge clk);
						@(posedge clk);
						@(posedge clk);
		test <= 1;
						@(posedge clk);

						
		test <= 0;
						@(posedge clk);
		test <= 1;
						@(posedge clk);

						
		test <= 0;
						@(posedge clk);
		test <= 1;
						@(posedge clk);

						
		test <= 0;
						@(posedge clk);
		test <= 1;
						@(posedge clk);
		test <= 1;
						@(posedge clk);

						
		test <= 0;
						@(posedge clk);
		test <= 1;
						@(posedge clk);
		test <= 0;
						@(posedge clk);

						
		test <= 1;
						@(posedge clk);
		test <= 0;
						@(posedge clk);

		Reset <= 1; @(posedge clk); 
						@(posedge clk); 
						@(posedge clk); 
						@(posedge clk); 
						@(posedge clk);
		Reset <= 0; @(posedge clk);
						@(posedge clk); 
						@(posedge clk); 
						@(posedge clk); 
						@(posedge clk); 
						@(posedge clk);
						
						
		$stop; 
	end
endmodule
