// this module checks if a pipe is cleared or if there was a collision
module game_status(clock, reset, bird_pos, pipe1, pipe2, height1, height2, size1, size2, increment, game_over, OFB);
  input logic [3:0] pipe1, pipe2;
  input logic clock, reset;
  input logic [3:0] bird_pos; // 4 bit bird height (0-15)
  input logic [2:0] height1, height2, size1, size2;
  input logic OFB;
  
  output logic increment, game_over;
	
	
	always_ff @(posedge clock) begin
	
	if((pipe1 == 8) && ~OFB) begin
	  // if pipe has reached far left check bird index
	  //if ((bird_pos <= height1) && (bird_pos > (height1 - size1))) begin
	  if ((bird_pos >= height1) && (bird_pos < (height1 + size1))) begin
	    // clears pipe
	    increment <= 1; // increment TRUE
		 game_over <= 0; // game_over FALSE 
	  end else begin
	    // hits a pipe
	    increment <= 0; // increment FALSE
		 game_over <= 1; // game over TRUE
	  end
	  
	  
	end else if((pipe2 == 12) && ~OFB) begin
	    //if ((bird_pos <= height2) && (bird_pos > (height2 - size2))) begin
		  if ((bird_pos >= height1) && (bird_pos < (height1 + size1))) begin
		   // clears both pipes
	      increment <= 1; // increment TRUE
		   game_over <= 0; // game_over FALSE 
	    end else begin
	      // hits a pipe
	      increment <= 0; // increment FALSE
		   game_over <= 1; // game over TRUE
	    end
	end else if(OFB) begin
	    // OFB
	    game_over <= 1;
		 increment <= 0; 
	  end else begin
	    game_over <= 0;
		 increment <= 0;
	  end
  end
 
endmodule



module game_status_testbench();
  logic [3:0] pipe1, pipe2;
  logic clock, reset;
  logic [3:0] bird_pos; // 4 bit bird height (0-15)
  logic [2:0] height1, height2, size1, size2;
  logic OFB, increment, game_over;


  game_status dut(.clock, .reset, .bird_pos, .pipe1, .pipe2, .height1, .height2, .size1, .size2, .increment, .game_over, .OFB);

  parameter CLOCK_PERIOD=100;

	initial clock = 1;
	always begin
			#(CLOCK_PERIOD/2);
		clock = ~clock;
	end


  // Setup the inputs to the design
	initial begin
	bird_pos <= 0;				  
	height1 <= 0;
   size1 <= 4;	
	pipe1 <= 8;  
		bird_pos <=1; @(posedge clock);
						  @(posedge clock);
		OFB <= 0;				  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
		bird_pos <=3;
		              @(posedge clock);
		 OFB <= 1;     @(posedge clock);
		              @(posedge clock);
	    bird_pos <= 2;   @(posedge clock);
                    @(posedge clock);
		 OFB <= 0; 				  @(posedge clock);				 
						@(posedge clock);
		bird_pos <= 1;	@(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
		bird_pos <= 8;				  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock)
		bird_pos <= 4;				  @(posedge clock);
						  @(posedge clock);
		bird_pos <= 3;	@(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  
						 
		bird_pos <= 9;@(posedge clock);
						  @(posedge clock);
						  @(posedge clock);@(posedge clock);
						  @(posedge clock);
						  
		pipe1 <= 2;                @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
					     @(posedge clock);
		 				  @(posedge clock);
		bird_pos <= 8;	            @(posedge clock);
		              @(posedge clock);
		bird_pos <= 9;				  @(posedge clock);
						  @(posedge clock);
		bird_pos <= 0;				  @(posedge clock);
		              @(posedge clock);
						  @(posedge clock);
		OFB <= 1;		@(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
						  @(posedge clock);
		$stop;
	end	


endmodule

