// Top-level module that defines the I/Os for the DE-1 SoC board
module DE1_SoC (HEX0, HEX1, HEX2, KEY, SW, LEDR, GPIO_1, CLOCK_50);
    output logic [6:0]  HEX0, HEX1, HEX2;
	 output logic [9:0]  LEDR;
    input  logic [3:0]  KEY;
    input  logic [9:0]  SW; // SW9 = reset SW8 = mode SW0 = pause SW[3] = fast clock
    output logic [35:0] GPIO_1;
    input logic CLOCK_50;
	 
	 
	 /* Set up system base clock to 1526 Hz (50 MHz / 2**(14+1))
	    ===========================================================*/
	 logic [31:0] clk;
	 logic SYSTEM_CLOCK;
	 
	 clock_divider divider (.clock(CLOCK_50), .divided_clocks(clk));
	 
	 assign SYSTEM_CLOCK = clk[14]; // 1526 Hz clock signal	 
	 
	 /* If you notice flickering, set SYSTEM_CLOCK faster.
	    However, this may reduce the brightness of the LED board. */
	
	 
	 /* Set up LED board driver
	    ================================================================== */
	 logic [15:0][15:0]RedPixels; // 16 x 16 array representing red LEDs
    logic [15:0][15:0]GrnPixels; // 16 x 16 array representing green LEDs
	 logic RST;                   // reset - toggle this on startup
	 
	 assign RST = ~KEY[0];
	 
	 /* Standard LED Driver instantiation - set once and 'forget it'. 
	    See LEDDriver.sv for more info. Do not modify unless you know what you are doing! */
	 LEDDriver Driver (.CLK(SYSTEM_CLOCK), .RST, .EnableCount(1'b1), .RedPixels, .GrnPixels, .GPIO_1);
	 
	
	
	 // ----------------- flappy -----------------------
	 
	  // reset signal
	 logic reset;
	 assign reset = SW[9];
	 
	 
	 logic key0, key0_1, sw0, sw0_0, pause, pause_0;
	// Put the user inputs through 2 flip flops -- SW0 is pause, SW5 is fast mode
	always_ff @(posedge CLOCK_50) begin
		if (reset) begin
			key0 <= 1'b1;
			sw0  <= 1'b0;
			pause <= 1'b0;
		end
		else begin
			key0_1 <= KEY[0];
			key0   <= key0_1;
			sw0_0  <= SW[5];
			sw0    <= sw0_0;
			pause_0 <= SW[0];
			pause  <= pause_0;
		end
	end
	 
	 // user input module- used for first user input
	 logic input1;
	 key user_input(.Clock(SYSTEM_CLOCK), .Reset(SW[9]), .pressed(~key0), .mode(SW[8]), .set(input1)); 
	 
	 // Slow down circuit clock
	 logic input2, enable2, enable3;
	 clock_1 clock1   (.clk(SYSTEM_CLOCK), .reset, .pause, .enable(input2)); // fast
	 clock_2 clock2   (.clk(SYSTEM_CLOCK), .reset, .pause, .enable(enable2)); // slower - gravity clock
	 clock_3 clock3 (.clk(SYSTEM_CLOCK), .reset, .pause, .enable(enable3)); // slow
	 
	 //logic whichClock;
	 //always_ff begin
	 //if (SW[5]) begin // when sw5 ON, set fast clock
	   //whichClock <= input2;
	 //end else begin
	   //whichClock <= enable2;
	 //end	
	 //end
	  
    // generate random gap height and size
	 logic [2:0] height1, size1, size2;
	 logic [2:0] height2, height3, size3;
	 
	 // for testing: 
	 assign height1 = 7; assign size1 = 4;
	 assign height2 = 5; assign size2 = 3;
	 
	 // outputs height and size to Generate pipe1
	 //gap random_gap(.clock(whichClock), .reset(SW[9]), .height(height1), .size(size1)); 
	 // outputs height and size to Generate pipe2
	 //gap random_gap2(.clock(whichClock), .reset(SW[9]), .height(height2), .size(size2)); 
	 // outputs height and size to Generate pipe3
	 //gap random_gap3(.clock(whichClock), .reset(SW[9]), .height(height3), .size(size3)); 
	 
	 // create pipe
	 logic [15:0][15:0] init1, init2, inti3;
   
	 
	 logic [3:0] pipe1_code, pipe2_code, pipe3_code;
	 
	 //always_comb begin
	 
	 //if(SW[1]) begin
	   Generate_Pipe random_pipe(.clock(enable2), .reset(SW[9]), .light(init1), .gap_top(height1), .gap_size(size1), .pipe_code(pipe1_code)); 
	 //end else if (SW[2]) begin
	   //Generate_Pipe random_pipe(.clock(whichClock), .reset(SW[9]), .light(init1), .gap_top(height1), .gap_size(size1), .pipe_code(pipe1_code)); 
	   Generate_Pipe2 random_pipe2(.clock(enable2), .reset(SW[9]), .light(init2), .gap_top(height2), .gap_size(size2), .pipe_code(pipe2_code));
	 //end
	 
	 //Generate_Pipe3 random_pipe3(.clock(enable2), .reset(SW[9]), .light(init3), .gap_top(height2), .gap_size(size3), .pipe_code(pipe3_code));
	 //end
	 logic GAMEOVER;
	 
	 
	 logic bird_OFB;
	 logic [3:0] bird_pos;
	 
	 // create bird - bird module takes fly signal from user input module to update bird position
	 Bird_Vertical bird_position(.out(bird_OFB), .bird_pos(bird_pos), .clock(SYSTEM_CLOCK), .reset(SW[9]), .fly(input1), .mode(SW[8]), .gravity(enable2), .game_over(GAME_OVER));
	 
	 // check for Collision or pipe cleared
	 logic cleared;
	 game_status check_game(.clock(SYSTEM_CLOCK), .reset(SW[9]), .bird_pos(bird_pos), .pipe1(pipe1_code), .pipe2(pipe2_code), .height1(height1), .height2(height2), .size1(size1), .size2(size2), .increment(cleared), .game_over(GAMEOVER), .OFB(bird_OFB));
	 
	 // score counter
	 logic [3:0] hex1_signal, hex10_signal, hex100_signal;
	 logic next1, next10, next100; // call next counter signal 
	 
	 // score module 
	 counter score(.clk(SYSTEM_CLOCK),.reset(SW[9]), .inc(cleared), .game_over(GAMEOVER), .a(hex1_signal),.b(hex10_signal),.c(hex100_signal));
	
	 // Displays Green pipes and Red Bird
	 LED_Display board(.RST(RST), .light(init1), .light2(init2), .bird_index(bird_pos), .RedPixels, .GrnPixels, .clock(enable2));
	 
	 // Display score (0-999) on HEX2 HEX1 HEX0
	 hex1 hex_1(.Clock(SYSTEM_CLOCK), .Reset(SW[9]), .counter1(hex1_signal), .counter2(hex10_signal), .counter3(hex100_signal), .hex1(HEX0), .hex2(HEX1), .hex3(HEX2));
	 
	 
endmodule
