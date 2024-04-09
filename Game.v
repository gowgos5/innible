module Game(
  input clk,
  input [6:0] x,
  input [5:0] y,
  input btnR,
  input sw,
  input [4:0] volume,
  output reg [15:0] oled_data
);

localparam IDLE = 4'b0000; 
localparam SCREEN_1 = 4'b0001; 
localparam SCREEN_2 = 4'b0010; 
localparam SCREEN_3 = 4'b0011; 
localparam SCREEN_4 = 4'b0100; 
localparam SCREEN_5 = 4'b0101; 
localparam SCREEN_6 = 4'b0110; 
localparam SCREEN_7 = 4'b0111; 
localparam SCREEN_8 = 4'b1000; 
localparam SCREEN_9 = 4'b1001; 
localparam SCREEN_10 = 4'b1010; 
localparam SCREEN_11 = 4'b1011; 

localparam BLACK = 16'h0000;

reg [3:0] state;
reg [3:0] next_state;

always @ (posedge clk) begin
  state <= next_state;
end

always @ (*) begin
  next_state = state;
  case (next_state)
    IDLE: if (sw) next_state = SCREEN_1;
    SCREEN_1: if (btnR) next_state = SCREEN_2;
    SCREEN_2: if (btnR) next_state = SCREEN_3;
    SCREEN_3: if (btnR) next_state = SCREEN_4;
    SCREEN_4: if (btnR) next_state = SCREEN_5;
    SCREEN_5: if (btnR) next_state = SCREEN_6;
    SCREEN_6: if (btnR) next_state = SCREEN_7;
    SCREEN_7: if (btnR) next_state = SCREEN_8;
    SCREEN_8: if (btnR) next_state = SCREEN_9;
    SCREEN_9: if (btnR) next_state = SCREEN_10;
    SCREEN_10: if (btnR) next_state = SCREEN_11;
    SCREEN_11: if (btnR) next_state = SCREEN_1;
  endcase
  if (~sw) begin
    next_state = IDLE;
  end
end

wire [15:0] s1_oled_data;
wire [15:0] s2_oled_data;
wire [15:0] s3_oled_data;
wire [15:0] s4_oled_data;
wire [15:0] s5_oled_data;
wire [15:0] s6_oled_data;
wire [15:0] s7_oled_data;
wire [15:0] s8_oled_data;
wire [15:0] s9_oled_data;
wire [15:0] s10_oled_data;
wire [15:0] s11_oled_data;

Game_Screen_1 screen_1(x, y, s1_oled_data);
Game_Screen_2 screen_2(x, y, s2_oled_data);
Game_Screen_3 screen_3(x, y, s3_oled_data);
Game_Screen_4 screen_4(x, y, s4_oled_data);
Game_Screen_5 screen_5(x, y, s5_oled_data);
Game_Screen_6 screen_6(x, y, s6_oled_data);
Game_Screen_7 screen_7(x, y, s7_oled_data);
Game_Screen_8 screen_8(x, y, s8_oled_data);
Game_Screen_9 screen_9(x, y, s9_oled_data);
Game_Screen_10 screen_10(x, y, s10_oled_data);
Game_Screen_11 screen_11(x, y, s11_oled_data);

always @ (*) begin
  oled_data = BLACK;
  case (state)
    SCREEN_1: oled_data = s1_oled_data;
    SCREEN_2: oled_data = s2_oled_data;
    SCREEN_3: oled_data = s3_oled_data;
    SCREEN_4: oled_data = s4_oled_data;
    SCREEN_5: oled_data = s5_oled_data;
    SCREEN_6: oled_data = s6_oled_data;
    SCREEN_7: oled_data = s7_oled_data;
    SCREEN_8: oled_data = s8_oled_data;
    SCREEN_9: oled_data = s9_oled_data;
    SCREEN_10: oled_data = s10_oled_data;
    SCREEN_11: oled_data = s11_oled_data;
  endcase
end

endmodule

