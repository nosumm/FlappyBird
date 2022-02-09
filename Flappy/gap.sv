// generates 
module gap(clock, reset, height, size);
  input logic clock, reset;
  output logic [2:0] size, height;

// generate random gap
// random 3 bit gap top index between 0-7
	LFSR_3bit random_top(.clock(clock), .reset(reset), .Out(size));
	
// random 3 bit gap size between 0-7
	LFSR_3bit random_size(.clock(clock), .reset(reset), .Out(height));

	
endmodule

// 3 bit LFSR
module LFSR_3bit(clock, reset, Out);
	input clock, reset;
	output [2:0] Out;
	reg [2:0] PS, NS;
	reg T;
	
	always @(*) begin
		T = ~(PS[2] ^ PS[1]);
		NS = {PS[1:0], T};
	end
		
	assign Out = PS;
	
	always_ff @(posedge clock)
		if (reset)
			PS <= 3'b000;
		else 
			PS <= NS;

endmodule

