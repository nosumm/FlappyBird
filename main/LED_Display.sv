module LED_Display(RST, light, light2, bird_index, RedPixels, GrnPixels, clock);
    input logic RST;
	 input logic [15:0][15:0] light;
	 input logic [15:0][15:0] light2;
	 input clock;
	 
	 input logic [3:0] bird_index; // 4bit bird height 0 - 15
	 
    output logic [15:0][15:0] RedPixels; // 16x16 array of red LEDs
    output logic [15:0][15:0] GrnPixels; // 16x16 array of green LEDs
    
	 
	 genvar j;
	 generate
	 
	 // place the bird at bird index TODO: no reset needed????? or do we need it? 
	 for (j = 0; j < 16; j = j + 1) begin: myloop
	   always_comb begin
		  if(j == bird_index) begin: place_bird
		    RedPixels[j] <= 16'b1000000000000000;	
		  end else begin: no_bird
	       RedPixels[j] <= 16'b0000000000000000;  
		  end // end no_bird
	   end // always_bomb
	 end // myloop
	 endgenerate

   
	// Display pipes by turning on green LEDS in current pipe position. 
	
	genvar i;
	generate
	
	for (i = 0; i < 16; i = i + 1) begin : eachIndex // loop through entire column
	  always_comb begin: my_loop
	    
		 GrnPixels[i] <= (light[i][15:0] | light2[i][15:0]);
	  
	  end // end clk
		
	end // end for loop
	endgenerate		


endmodule
module LED_Display_testbench();

	reg RST;
	logic [15:0][15:0] RedPixels, GrnPixels, light, light2;
	reg clock;
	logic [3:0] bird_index;
	
	LED_Display dut (.RST, .light, .light2, .bird_index, .RedPixels, .GrnPixels, .clock);
	parameter CLOCK_PERIOD=100;

	initial clock = 1;
	always begin
			#(CLOCK_PERIOD/2);
		clock = ~clock;
	end

	initial begin
	for(integer i = 0; i < 16; i = i + 1) begin
	  light[i] <= 16'b0000000000000001;
	end
	RST <= 1'b1; 
	
						@(posedge clock);
						@(posedge clock);
						
	RST <= 1'b0;
	for(integer i = 0; i < 16; i = i + 1) begin
	  light[i] <= 16'b0000000000000010;
	end
	for(integer i = 0; i < 16; i = i + 1) begin
	  light2[i] <= 16'b1000000000000000;
	end
	               @(posedge clock);
						@(posedge clock);
	bird_index <= 4'b0111;
	
	               @(posedge clock);
						@(posedge clock);
	bird_index <= 4'b1000;					@(posedge clock);
						                     @(posedge clock);
	bird_index <= 4'b1001;					@(posedge clock);
						                     @(posedge clock);
	bird_index <= 4'b1010;					@(posedge clock);
						@(posedge clock);
						@(posedge clock);
	bird_index <= 4'b1011;	
for(integer i = 0; i < 16; i = i + 1) begin
	  light[i] <= 16'b0000000000000010;
	end
	for(integer i = 0; i < 16; i = i + 1) begin
	  light2[i] <= 16'b0000100000000000;
	end
		            @(posedge clock);
						@(posedge clock);
						@(posedge clock);
	bird_index <= 4'b1100;					@(posedge clock);
													@(posedge clock);
													@(posedge clock);
	bird_index <= 4'b1101;					@(posedge clock);
													@(posedge clock);
													@(posedge clock);
	bird_index <= 4'b1110;					@(posedge clock);
													@(posedge clock);
													@(posedge clock);
	bird_index <= 4'b1111;					@(posedge clock);
									@(posedge clock);
	RST <= 1'b1;				@(posedge clock);
									@(posedge clock);
									@(posedge clock);
	RST <= 1'b0;				@(posedge clock);
									@(posedge clock);
	end
	
endmodule

  
 
