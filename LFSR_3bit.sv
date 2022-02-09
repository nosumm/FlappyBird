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
	
	always @(posedge clock)
		if (reset)
			PS <= 3'b000;
		else 
			PS <= NS;

endmodule


