module key(Clock, Reset, pressed, mode, set, clk);
  input Clock, Reset;
  input mode;
  input pressed;
  output reg set;
  reg [1:0] PS, NS;
  input clk;
  
  parameter [1:0] on = 2'b10, hold = 2'b01, off = 2'b00;
  
  always_comb
  case(PS)
		on:    if(pressed) NS = hold;
			           else NS = off;
			
		hold:  if(pressed) NS = hold;
		              else NS = off;
	
	   off:   if(pressed) NS = on;
		             else NS = off;
						 
		default: NS = 2'bxx;
		         
 endcase
 
 always_comb
 case(PS)
   on: set = 1;
	
	hold: set = mode;
	
	off: set = 0;
	
	default: set = 1'bx;
endcase
 
 always_ff @(posedge Clock)
   if (Reset) PS <= off;
	else PS <= NS;
endmodule

module key_testbench();

	reg Clk, Reset;
	wire set;
	
	wire out;
	wire [3:0] KEY;
	wire [9:0] LEDR;

	reg [9:0] SW;	
	reg pressed;
	reg mode;
	key dut(.Clock(Clk), .Reset(Reset), .pressed(pressed), .mode(mode), .set(set));


	parameter CLOCK_PERIOD=100;

	initial Clk = 1;
	always begin
			#(CLOCK_PERIOD/2);
		Clk = ~Clk;
	end
	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
	
	
	   Reset <= 1;		@(posedge Clk); 
						@(posedge Clk);
						
						
		Reset <= 0;	
		mode <= 0;
						@(posedge Clk);
						@(posedge Clk);
						@(posedge Clk);
						@(posedge Clk);

		pressed <= 1; @(posedge Clk);
						@(posedge Clk);
						@(posedge Clk);
						@(posedge Clk);
						
						
		pressed <= 0;	@(posedge Clk);
						@(posedge Clk);
						@(posedge Clk);
						@(posedge Clk);
						
						
		pressed <= 1;		@(posedge Clk);
						@(posedge Clk);
						@(posedge Clk);
						@(posedge Clk);
						
						
		Reset <= 1;		@(posedge Clk); 
						@(posedge Clk);
						@(posedge Clk);
						@(posedge Clk);
						@(posedge Clk);
						
						
		Reset <= 0;		@(posedge Clk);
						@(posedge Clk);
						@(posedge Clk);	
						@(posedge Clk);
						@(posedge Clk);
		mode <= 1;
						@(posedge Clk);
						@(posedge Clk);
						@(posedge Clk);
						@(posedge Clk);

		pressed <= 1; @(posedge Clk);
						@(posedge Clk);
						@(posedge Clk);
						@(posedge Clk);
						
						
		pressed <= 0;	@(posedge Clk);
						@(posedge Clk);
						@(posedge Clk);
						@(posedge Clk);
						
						
		pressed <= 1;		@(posedge Clk);
						@(posedge Clk);
						@(posedge Clk);
						@(posedge Clk);
						
						
		Reset <= 1;		@(posedge Clk); 
						@(posedge Clk);
						@(posedge Clk);
						@(posedge Clk);
						@(posedge Clk);
						
						
		Reset <= 0;		@(posedge Clk);
						@(posedge Clk);
						@(posedge Clk);	
						@(posedge Clk);
						@(posedge Clk);
						
										
		$stop;
	end
endmodule