module LFSR(
  input clk,
  input init,
  input [8:0] seed,
  output [8:0] out
);

reg [9:1] lfsr;
wire x;

always @ (posedge clk) begin
  if (init) begin
    lfsr <= seed;
  end else begin
    lfsr <= { lfsr[8:1], x };
  end
end

assign x = lfsr[9] ^~ lfsr[5];
assign out = lfsr[9:1];

endmodule

