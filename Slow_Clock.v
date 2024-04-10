module Slow_Clock(
  input clk,
  output reg slow_clk = 1'b0
);

localparam CLOCK_FREQUENCY = 100000000;
parameter SLOW_CLOCK_FREQUENCY = 1;
localparam MAX_COUNT = CLOCK_FREQUENCY / SLOW_CLOCK_FREQUENCY;

reg [31:0] cnt = 0;

always @ (posedge clk) begin
  cnt <= cnt + 31'b1;
  if (cnt >= (MAX_COUNT - 1)) begin
    cnt <= 31'b0;
    slow_clk <= ~slow_clk;
  end
end

endmodule

