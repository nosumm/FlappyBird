// Flip Flop
module D_FF (Q, d, reset, clk);
	output Q;
	input d, reset, clk;
	reg Q; // Indicate that q is stateholding
	
	always @(posedge clk or posedge reset)
	if (reset)
		Q = 0; // On reset, set to 0
	else
		Q = d; // Otherwise out = d
endmodule


// 4 bit adder used for randomly generated gap size
module addN #(parameter N=4) (OF, CF, S, sub, A, B);
  output logic OF, CF;
  output logic [N-1:0] S;
  input logic sub;
  input logic [N-1:0] A, B;
  logic [N-1:0] D; // possibly flipped B
  
  always_comb begin
    D = B ^ {N{sub}}; // replication operator
    {CF, S} = A + D + sub;
    OF = (~S[N-1] & A[N-1] & D[N-1]) |
    (S[N-1] & ~A[N-1] & ~D[N-1]);
  end
  endmodule  