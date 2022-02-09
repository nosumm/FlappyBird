// this module generates the initial pipes at the start of the game
// with random gap size and position.
module Generate_Pipe(clock, reset, light, gap_top, gap_size, pipe_code);
  
  input clock, reset;
  input logic [2:0] gap_top, gap_size;
  output logic [3:0] pipe_code; // 4 bit pipe code 
  output logic [15:0][15:0] light;

  
   // assign pipe position to numbers generated by 4bit LFSR. 
	
   logic [31:0][15:0] pipe; // 14 pipe positions 
	
	assign pipe[0] [15:0] = 16'b0000000000000010;  
	assign pipe[1] [15:0] = 16'b0000000000000100;
	assign pipe[3] [15:0] = 16'b0000000000001000;
	assign pipe[7] [15:0] = 16'b0000000000010000;
	assign pipe[14] [15:0] = 16'b0000000000100000;
	assign pipe[13] [15:0] = 16'b0000000001000000;
	assign pipe[11] [15:0] = 16'b0000000010000000;
	assign pipe[6] [15:0] = 16'b0000000100000000;
   assign pipe[12] [15:0] = 16'b0000001000000000;
   assign pipe[9] [15:0] = 16'b0000010000000000;
	
	assign pipe[2] [15:0] = 16'b0000100000000000;
	assign pipe[5] [15:0] = 16'b0001000000000000;
	assign pipe[10] [15:0] = 16'b0010000000000000;
	assign pipe[4] [15:0] = 16'b0100000000000000;
	assign pipe[8] [15:0] = 16'b1000000000000000;
	// no pipe
	assign pipe[15] [15:0] = 16'b0000000000000000;

	// generate a number between 0-15
	// cycle through all pipe positions at every posedge of clock
	logic [3:0] num;
	LFSR_4bit random_num(.clock(clock), .reset(reset), .Out(num));
	
  // if reset is on, return to initial state RP7
  
  always_ff @(posedge clock) begin
    if (reset) pipe_code <= 4'b0000;
	 else
	   pipe_code <= num;
  end
	
	// get enable signal from user input TODO?????
	// logic user_input;
	// key user(.Clock(clock), .Reset(reset), .pressed(key_signal), .mode(mode), .set(user_input));
   
	// create pipes with random gap size and height
	genvar i;
	generate
	
	for (i = 0; i < 16; i = i + 1) begin : eachIndex // loop through all row indices 
   
	  always_comb begin //: my_loop
	    
	    if ((i >= gap_top) && i < (gap_top + gap_size)) begin
		   // if this is a gap index:
			// turn the whole row OFF
		   light[i] = 16'b0000000000000000;
		 
		 end else begin
	     // if not in gap assign the row at this index to the current pipe position	 
		  light[i] = pipe[pipe_code][15:0];
	    end // end else	 
	  end // end always_comb
	end // end for loop
	endgenerate 
	
endmodule



module Generate_Pipe_testbench();
  logic clock, reset;
  logic [15:0][15:0] light;
  logic [2:0] gap_top, gap_size;

  
  Generate_Pipe dut(.clock, .reset, .light, .gap_top, .gap_size);

  
  
  parameter CLOCK_PERIOD=100;
	initial begin
		clock <= 0;
		forever #(CLOCK_PERIOD/2) clock <= ~clock;
	end
	

	// Setup the inputs to the design
	initial begin
						  @(posedge clock);
		reset <= 1;	  @(posedge clock);
		reset <= 0;   @(posedge clock);
                    @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
		reset <= 1;	  @(posedge clock);
		              @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
		reset <= 0;   @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
		$stop;
	end

endmodule 
