// 5 bit LFSR
module LFSR_5bit(clock, reset, Out);
	input clock, reset;
	output [4:0] Out;
	reg [4:0] PS, NS;
	reg T;
	
	always @(*) begin
		T = ~(PS[4] ^ PS[2]);
		NS = {PS[3:0], T};
	end
		
	assign Out = PS;
	
	always_ff @(posedge clock)
		if (reset)
			PS <= 5'b00000;
		else 
			PS <= NS;

endmodule


module LFSR_5bit_testbench();
	reg clock, reset;
	wire [4:0] Out;

	LFSR_5bit dut(clock, reset, Out);
	
 parameter CLOCK_PERIOD = 100;
  initial begin
    clock <= 0;
    forever #(CLOCK_PERIOD / 2) clock <= ~clock;
  end

  integer i;
  initial begin
                @(posedge clock);
    reset <= 1; @(posedge clock);
    reset <= 0; @(posedge clock);
    for (i = 0; i < 100; ++i)
      @(posedge clock);
    $stop;
  end
endmodule
