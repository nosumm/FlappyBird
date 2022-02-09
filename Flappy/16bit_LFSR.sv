// 16 bit LFSR
module LFSR(Clock, Reset, Out);
	input Clock, Reset;
	output [15:0] Out;
	reg [15:0] PS, NS;
	reg T;
	
	always @(*) begin
		T = ~(PS[3] ^ PS[12] ^ PS[14] ^ PS[15]);
		NS = {PS[14:0], T};
	end
		
	assign Out = PS;
	
	always @(posedge Clock)
		if (Reset)
			PS <= 16'b0000000000000000;
		else 
			PS <= NS;

endmodule


// 2^16 - 1 = 65535 = cycle length 
module LFSR_testbench();
	reg clock, reset;
	wire [8:0] Out;

	LFSR dut(clock, reset, Out);
	
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

