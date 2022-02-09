module hex1(Clock, Reset, counter1, counter2, counter3, hex1, hex2, hex3);
  input Clock, Reset;
  input [3:0] counter1, counter2, counter3; // 4 bit counter 0-9
  reg [6:0] PS, NS;
  output reg [6:0] hex1, hex2, hex3; // 7 seg displays

  
  parameter [9:0] zero = 7'b1000000, 	one = 7'b1111001,		two = 7'b0100100, three = 7'b0110000,
						four = 7'b0011001, 	five = 7'b0010010, six = 7'b0000010, 	seven = 7'b1111000, eight = 7'b0000000, nine = 7'b0011000;
  
  always @(*) begin
    case (counter1)
			4'b0000:	hex1 = zero;
			4'b0001:	hex1 = one;
			4'b0010:	hex1 = two;
			4'b0011:	hex1 = three;
			4'b0100:	hex1 = four;
			4'b0101:	hex1 = five;
			4'b0110:	hex1 = six;
			4'b0111:	hex1 = seven;
			4'b1000:	hex1 = eight;
			4'b1001:	hex1 = nine;
			default: hex1 = 7'bxxxxxxx;
	 endcase
	 
	 // recurses to counter1 after every call
    case (counter2)
			4'b0000:	hex2 = zero;
			4'b0001:	hex2 = one;
			4'b0010:	hex2 = two;
			4'b0011:	hex2 = three;
			4'b0100:	hex2 = four;
			4'b0101:	hex2 = five;
			4'b0110:	hex2 = six;
			4'b0111:	hex2 = seven;
			4'b1000:	hex2 = eight;
			4'b1001:	hex2 = nine;
			default: hex2 = 7'bxxxxxxx;
	 endcase
	 // recurses to counter2 after every call
	 case (counter3)
			4'b0000:	hex3 = zero;
			4'b0001:	hex3 = one;
			4'b0010:	hex3 = two;
			4'b0011:	hex3 = three;
			4'b0100:	hex3 = four;
			4'b0101:	hex3 = five;
			4'b0110:	hex3 = six;
			4'b0111:	hex3 = seven;
			4'b1000:	hex3 = eight;
			4'b1001:	hex3 = nine;
			default: hex3 = 7'bxxxxxxx;
	 endcase
	 
  end

endmodule


module hex1_testbench();
	reg Clock, Reset;
	reg [3:0] counter1, counter2, counter3;
	reg [6:0] hex1, hex2, hex3;
	

	hex1 dut(Clock, Reset, counter1, counter2, counter3, hex1, hex2, hex3);
	
	parameter CLOCK_PERIOD = 100;
	
	initial Clock = 1; 
	always begin 
		#(CLOCK_PERIOD/2); 
		Clock = ~Clock; 
	end 
	
	initial begin 
						@(posedge Clock);
					
		counter1 <= 9; counter2 <= 9; counter3 <= 9;
						@(posedge Clock); 
						@(posedge Clock); 
		counter1 <= 0; counter2 <= 0; counter3 <= 0;
						@(posedge Clock); @(posedge Clock); 
		counter1 <= 4; counter2 <= 1; counter3 <= 7;
						@(posedge Clock);		
						@(posedge Clock); 
		$stop; 
	end
endmodule


