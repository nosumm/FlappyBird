module Generate_Pipe(clock, reset, randompipe, mode, key_signal, light16, light15, light14, light13, light12, light11, light10, light9, light8, light7, light6, light5, light4, light3, light2, light1);
  input clock, reset, mode, key_signal;
  output logic [15:0] randompipe;
  output logic light16, light15, light14, light13, light12, light11, light10, light9, light8, light7, light6, light5, light4, light3, light2, light1;

  
   // generate possible pipes
	
   logic [31:0][15:0] pipe; // 32 possible pipes
	
	assign pipe[0] [15:0] = 16'b1000000111111111;
	assign pipe[1] [15:0] = 16'b1100000011111111;
	assign pipe[2] [15:0] = 16'b1110000001111111;
	assign pipe[3] [15:0] = 16'b1111000000111111;
	assign pipe[4] [15:0] = 16'b1111100000011111;
	assign pipe[5] [15:0] = 16'b1111110000001111;
	assign pipe[6] [15:0] = 16'b1111111000000111;
	assign pipe[7] [15:0] = 16'b1111111100000011;
   assign pipe[8] [15:0] = 16'b1111111110000001;
   assign pipe[9] [15:0] = 16'b1111111111000000;
  
   
	assign pipe[10] [15:0] = 16'b0000011111111111;
	assign pipe[11] [15:0] = 16'b1000001111111111;
	assign pipe[12] [15:0] = 16'b1100000111111111;
	assign pipe[13] [15:0] = 16'b1110000011111111;
	assign pipe[14] [15:0] = 16'b1111000001111111;
	assign pipe[15] [15:0] = 16'b1111100000111111;
	assign pipe[16] [15:0] = 16'b1111110000011111;
	assign pipe[17] [15:0] = 16'b1111111000001111;
	assign pipe[18] [15:0] = 16'b1111111100000111;
   assign pipe[19] [15:0] = 16'b1111111110000011;
   assign pipe[20] [15:0] = 16'b1111111111000001;
	
  
	assign pipe[21] [15:0] = 16'b0000111111111111;
	assign pipe[22] [15:0] = 16'b1000011111111111;
	assign pipe[23] [15:0] = 16'b1100001111111111;
	assign pipe[24] [15:0] = 16'b1110000111111111;
	assign pipe[25] [15:0] = 16'b1111000011111111;
	assign pipe[26] [15:0] = 16'b1111100001111111;
	assign pipe[27] [15:0] = 16'b1111110000111111;
	assign pipe[28] [15:0] = 16'b1111111000011111;
	assign pipe[29] [15:0] = 16'b1111111100001111;
   assign pipe[30] [15:0] = 16'b1111111110000111;
   assign pipe[31] [15:0] = 16'b1111111111000011;
	
	
	// pick a number between 0-32 to generate random pipe
	logic [4:0] number;
	LFSR_5bit random_num(.Clock(Clock), .Reset(Reset), .number(number));
	
	// get fly signal from user input
	logic user_input;
	key user(.Clock(clock), .Reset(reset), .pressed(key_signal), .mode(mode), .set(user_input));
   
   always_comb begin
		if (user_input) begin
	      light16 = pipe[number][15]; 
			light15 = pipe[number][14]; 
			light14 = pipe[number][13]; 
			light13 = pipe[number][12]; 
			light12 = pipe[number][11]; 
			light11 = pipe[number][10]; 
			light10 = pipe[number][09]; 
			light9 = pipe[number][08]; 
			light8 = pipe[number][07]; 
			light7 = pipe[number][06]; 
			light6 = pipe[number][05]; 
			light5 = pipe[number][04]; 
			light4 = pipe[number][03]; 
			light3 = pipe[number][02]; 
			light2 = pipe[number][01]; 
			light1 = pipe[number][00]; 
		end
		else begin
		   light16 = pipe[0][15]; 
			light15 = pipe[0][14]; 
			light14 = pipe[0][13]; 
			light13 = pipe[0][12]; 
			light12 = pipe[0][11]; 
			light11 = pipe[0][10]; 
			light10 = pipe[0][9]; 
			light9 = pipe[0][8]; 
			light8 = pipe[0][7]; 
			light7 = pipe[0][6]; 
			light6 = pipe[0][5]; 
			light5 = pipe[0][4]; 
			light4 = pipe[0][3]; 
			light3 = pipe[0][2]; 
			light2 = pipe[0][1]; 
			light1 = pipe[0][0]; 
		end
	end
 
endmodule
