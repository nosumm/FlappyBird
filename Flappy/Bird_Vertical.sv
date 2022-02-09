// calculates bird location, updates y coord on key press
module Bird_Vertical(out, bird_pos, clock, reset, fly, mode, gravity, game_over);
  input logic clock, reset, game_over;
  input mode;
  input fly; // key pressed signal
  output logic out;
  output reg [3:0] bird_pos; // 4 bit bird height index (0-15)
  
  input logic gravity; 
  
  reg [4:0] PS, NS;
  
  parameter [4:0] RP0 = 5'b00000, RP1 = 5'b00001, RP2 = 5'b00010, RP3 = 5'b00011, RP4 = 5'b00100, RP5 = 5'b00101, RP6 = 5'b00110, RP7 = 5'b00111, RP8 = 5'b01000, RP9 = 5'b01001, RP10 = 5'b01010, RP11 = 5'b01011, RP12 = 5'b01100, RP13 = 5'b01101, RP14 = 5'b01110, RP15 = 5'b01111, OFB = 5'b10000;

 
 	// user input
 //key user_input(.Clock(clock), .Reset(reset), .pressed(key), .mode(mode), .set(fly));
  
  //always @(*) begin
  always_comb
  // if (user)
    case(PS)
	   RP0: if((fly & ~gravity)) NS = OFB;
		     else if (~fly & gravity) NS = RP1;
			  else NS = PS; // ~fly & ~gravity or fly & gravity
			  
	   RP1: if (fly & ~gravity) NS = RP0;
		      else if (~fly & gravity) NS = RP2;
				else NS = PS;
				
		RP2: if (fly & ~gravity) NS = RP1;
		     else if (~fly & gravity)   NS = RP3;
			  else NS = PS;
			
		RP3: if (fly & ~gravity) NS = RP2;
		     else if (~fly & gravity)   NS = RP4;
			  else NS = PS;
				
		RP4: if (fly & ~gravity) NS = RP3;
		     else if (~fly & gravity)   NS = RP5;
			  else NS = PS;
			
		RP5: if (fly & ~gravity) NS = RP4;
		     else if (~fly & gravity)   NS = RP6;
			  else NS = PS;
				
		RP6: if (fly & ~gravity) NS = RP5;
		     else if (~fly & gravity)  NS = RP7;
			  else NS = PS;
		
		RP7: if (fly & ~gravity) NS = RP6;
		     else if (~fly & gravity)   NS = RP8;
			  else NS = PS;
				
		RP8: if (fly & ~gravity) NS = RP7;
		     else if (~fly & gravity)   NS = RP9;
			  else NS = PS;
			
		RP9: if (fly & ~gravity)NS = RP8;
		     else if (~fly & gravity)  NS = RP10;
			  else NS = PS;
		
		RP10: if (fly & ~gravity) NS = RP9;
		      else if (~fly & gravity)  NS = RP11;
				else NS = PS;
				
		RP11: if (fly & ~gravity)NS = RP10;
		      else if (~fly & gravity)  NS = RP12;
				else NS = PS;
			
		RP12: if (fly & ~gravity) NS = RP11;
		      else if (~fly & gravity)   NS = RP13;
				else NS = PS;
				
		RP13: if (fly & ~gravity) NS = RP12;
		      else if (~fly & gravity)   NS = RP14;
				else NS = PS;
				
		RP14: if (fly & ~gravity) NS = RP13;
		      else if (~fly & gravity)   NS = RP15;
				else NS = PS;
			
		RP15: if (fly & ~gravity) NS = RP14;
		      else if (~fly & gravity)   NS = OFB;
				else NS = PS;
		
		OFB: NS = RP7;
		
		default: NS = 5'bxxxxx;
    endcase			

		always_comb begin
    case(PS) 
     RP0: begin out = 1'b0; bird_pos = 4'b0000; end

	  RP1: begin out = 1'b0; bird_pos = 4'b0001; end

	  RP2: begin out = 1'b0; bird_pos = 4'b0010; end
	  
	  RP3: begin out = 1'b0; bird_pos = 4'b0011; end
			 
	  RP4: begin out = 1'b0; bird_pos = 4'b0100; end
	  
	  RP5: begin out = 1'b0; bird_pos = 4'b0101; end
	  	 
	  RP6: begin out = 1'b0; bird_pos = 4'b0110; end
	  
	  RP7: begin out = 1'b0; bird_pos = 4'b0111; end
	  
	  RP8: begin out = 1'b0; bird_pos = 4'b1000; end
	
	  RP9: begin out = 1'b0; bird_pos = 4'b1001; end
	 
	  RP10: begin out = 1'b0; bird_pos = 4'b1010; end
	  
	  RP11: begin out = 1'b0; bird_pos = 4'b1011;end 
    	
	  RP12: begin out = 1'b0; bird_pos = 4'b1100; end
	  
	  RP13: begin out = 1'b0; bird_pos = 4'b1101; end
	  
	  RP14: begin out = 1'b0; bird_pos = 4'b1110; end
	 		  
	  RP15: begin out = 1'b0; bird_pos = 4'b1111; end
	        
	  OFB: begin out = 1'b1; bird_pos = 4'b0111; end
 
	  default: begin out = 1'bx; bird_pos = 4'bxxxx; end
	         
	 
   endcase 
end
  
  // if reset is on, return to initial state RP7
  always_ff @(posedge clock) begin
    if (reset | game_over) PS <= RP7;
	 else PS <= NS;
  end

endmodule

module Bird_Vertical_testbench();
  logic out, clock, reset, fly;
  logic [3:0] bird_pos;
  logic mode;
  logic gravity;
  
  Bird_Vertical dut(.out, .bird_pos, .clock, .reset, .fly, .mode, .gravity);
  
  parameter CLOCK_PERIOD=100;
	initial begin
		clock <= 0;
		forever #(CLOCK_PERIOD/2) clock <= ~clock;
	end
	

	// Setup the inputs to the design
	initial begin
		mode <= 1; // hold = sink
                                		
		reset <= 1;					    		  @(posedge clock);
		reset <= 0; fly <= 0;  gravity <= 1;  // sink       @(posedge clock);
		                          @(posedge clock);
										  @(posedge clock);
										  @(posedge clock);
						fly <= 1;  gravity <= 0; // fly 
						            @(posedge clock);
                                @(posedge clock);
										  @(posedge clock);
										  @(posedge clock);
										  @(posedge clock);
										  @(posedge clock);
						fly <= 0; gravity <= 1; @(posedge clock);
						              @(posedge clock);@(posedge clock);
						              @(posedge clock);@(posedge clock);
						fly <= 1; gravity <= 0; @(posedge clock);
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
						fly <= 0; gravity <= 1;  @(posedge clock);
						              @(posedge clock);
						              @(posedge clock);
						fly <= 0; gravity <= 0; // nothing
						           @(posedge clock);
						              @(posedge clock);
						fly <= 1; gravity <= 1; // nothing               @(posedge clock);
						 
                   gravity <= 1;  						 @(posedge clock);
						fly <= 0;  @(posedge clock);
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
					    @(posedge clock);
                                @(posedge clock);
										  @(posedge clock);
						  
						@(posedge clock); repeat(15);
						              @(posedge clock); 
						          
						  
						@(posedge clock); repeat (15);
						              @(posedge clock);
						              @(posedge clock);
		reset <= 1;				  @(posedge clock);
		reset <= 0;            @(posedge clock);
		fly <= 0;              @(posedge clock); 
		                       @(posedge clock);
                             @(posedge clock);
		fly <= 1;				  @(posedge clock);
		                       @(posedge clock);
		$stop;
	end
  
endmodule

  