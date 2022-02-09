// this module checks if a pipe is cleared or if there was a collision
module Collision(clock, reset, bird_pos, pipe1, pipe2, height1, height2, size1, size2, increment);
  input logic [15:0][15:0] pipe1, pipe2;
  input logic clock, reset;
  input logic [3:0] bird_pos; // 4 bit bird height (0-15)
  input logic [2:0] height1, height2, size1, size2;
  
  output logic increment;
  
  	assign pipe[0] [15:0] = 16'b0000000001000000;
	assign pipe[1] [15:0] = 16'b0000000010000000;
	assign pipe[3] [15:0] = 16'b0000000100000000;
	assign pipe[7] [15:0] = 16'b0000001000000000;
	assign pipe[14] [15:0] = 16'b0000100000000000;
	assign pipe[13] [15:0] = 16'b0001000000000000;
	assign pipe[11] [15:0] = 16'b0010000000000000;
	assign pipe[6] [15:0] = 16'b0100000000000000;
   assign pipe[12] [15:0] = 16'b1000000000000000;
   assign pipe[9] [15:0] = 16'b0000000000000001;
	
	assign pipe[2] [15:0] = 16'b0000000000000010;
	assign pipe[5] [15:0] = 16'b0000000000000100;
	assign pipe[10] [15:0] = 16'b0000000000001000;
	assign pipe[4] [15:0] = 16'b0000000000001000;
	assign pipe[8] [15:0] = 16'b0000000000010000;
	// no pipe
	assign pipe[15] [15:0] = 16'b0000000000000000;
	
	
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
	
	
	
	if(pipe1[0] == 16'b1000000000000000 | pipe2[0] == 16'b1000000000000000) begin
	  // if pipe has reached far left check bird index
	  if (((bird_pos >= height1) && bird_pos < (height1 + size1)) && ((bird_pos >= height2) && bird_pos < (height2 + size2))) begin
	    // clears both pipes
	    increment = 1'b1; // increment TRUE
		 game_over = 1'b0; // game_over FALSE 
	  end else begin
	    increment = 1'b0; // increment FALSE
		 game_over = 1'b1; // game over TRUE
	  end
	
	
	end



endmodule



module Collision_Testbench();


endmodule

