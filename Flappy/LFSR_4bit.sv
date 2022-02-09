// 4 bit LFSR
module LFSR_4bit(clock, reset, Out);
	input clock, reset;
	output [3:0] Out;
	reg [3:0] PS, NS;
	reg T;
	
	always @(*) begin
		T = ~(PS[3] ^ PS[2]);
		NS = {PS[2:0], T};
	end
		
	assign Out = PS;
	
	always @(posedge clock) begin
		if (reset)
			PS <= 4'b0000;
		else 
			PS <= NS;
	end

endmodule

module LFSR_4bit_testbench();
	reg clock, reset;
	wire [3:0] Out;

	LFSR_4bit dut(clock, reset, Out);
	
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

