// counter uses increment signal to increment score for hexdisplay
// game over and SW9 restart count
module counter(clk,reset, inc, game_over, a,b,c);
    input clk,reset;
	 input inc, game_over;
    output [3:0] a,b,c;
    reg[3:0] a,b,c;
    
	initial begin
        a=0;
        b=0;
        c=0;
    end
    always @(posedge clk) begin
        if(reset | game_over) begin 
            a<=0;
            b<=0;
            c<=0;
        end else if (inc) begin
		  
          if(c>9) begin
              c<=0;
              b<=b+1;
          end else if(b>9) begin
              c<=0;
              b<=0;
              a<=a+1;
        end else if(a>9) begin
              a<=0;
              b<=0;
              c<=0;
        end else begin
          c<=c+1;
		  end
		  end  else begin // end else if
		    a <= a;
		    b <= b;
			 c <= c;
		  end
		  end // end always_ff
    endmodule


module counter_testbench();
	reg clk, reset, test;
	wire [3:0] a, b, c;
	logic inc, game_over;

	counter dut(clk, reset, test, game_over, a, b, c);
	
	parameter CLOCK_PERIOD = 100;
	
	initial clk = 1; 
	always begin 
		#(CLOCK_PERIOD/2); 
		clk = ~clk; 
	end 
	
	initial begin 
						
		reset <= 1; @(posedge clk); 
				
		reset <= 0; @(posedge clk); 
					
		test <= 1;
						@(posedge clk);

		test <= 0;
	

		for(integer i = 0; i < 999; i++) begin				
		 test <= 1;
						@(posedge clk);
						@(posedge clk);
       end
						@(posedge clk);
						
						
		$stop; 
	end
endmodule
