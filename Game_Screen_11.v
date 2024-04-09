module Game_Screen_11(
  input [6:0] x,
  input [5:0] y,
  output reg [15:0] oled_data
);

//Define constant as local parameter
//Colour display
localparam GREEN = 16'h07E0;
localparam ORANGE = 16'hFFE0; //Yellow
localparam RED = 16'hF800;
localparam BLACK = 16'h0000;
localparam PURPLE = 16'hF81F;
localparam YELLOW = 16'hFC00;    
localparam BLUE = 16'h001F;
localparam WHITE = 16'hFFFF;
localparam CYAN = 16'hF81F;
localparam MAGENTA = 16'hF81F;
localparam BROWN = 16'h8204;
localparam SKYBLUE = 16'h5FFF;

    wire REPLAY = ((x == 10) && (y >= 18 && y <= 22)) || ((x >= 10 && x <= 12) && (y == 18)) || ((x == 13) && (y == 19)) || ((x >= 10 && x <= 12) && (y == 20)) || ((x == 12) && (y == 21)) || ((x == 13) && (y == 22)) ||
                  ((x == 15) && (y >= 18 && y <= 22)) || ((x >= 15 && x <= 18) && (y == 18)) || ((x >= 15 && x <= 17) && (y == 20)) || ((x >= 15 && x <= 18) && (y == 22)) ||
                  ((x >= 20 && x <= 22) && (y == 18)) || ((x == 23) && (y == 19)) || ((x >= 20 && x <= 22) && (y == 20)) || ((x == 20) && (y >= 18 && y <= 22)) ||
                  ((x == 25) && (y >= 18 && y <= 22)) || ((x >= 25 && x <= 28) && (y == 22)) ||
                  ((x == 30) && (y >= 19 && y <= 22)) || ((x >= 31 && x <= 32) && (y == 18)) || ((x >= 30 && x <= 33) && (y == 20)) || ((x == 33) && (y >= 19 && y <= 22)) ||
                  ((x == 35) && (y >= 18 && y <= 19)) || ((x == 39) && (y >= 18 && y <= 19)) || ((x >= 36 && x <= 38) && (y == 20)) || ((x == 37) && (y >= 20 && y <= 22)) ||
                  ((x >= 41 && x <= 43) && (y == 18)) || ((x == 44) && (y >= 19 && y <= 20)) || ((x >= 42 && x <= 44) && (y ==20)) || ((x == 42) && (y == 22)); 

    wire LOADING_BAR_OB1 = ((x >= 10 && x <= 12) && (y >= 29 && y <= 46)) || ((x >= 87 && x <= 89) && (y >= 29 && y <= 46)) ||
                          ((x >= 13 && x <= 86) && (y >= 26 && y <= 28)) || ((x >= 13 && x <= 86) && (y >= 47 && y <= 49));
                          
    wire LOADING_BAR1 = ((x >= 14 && x <= 30) && (y >= 30 && y <= 45)) ||
                       ((x >= 32 && x <= 49) && (y >= 30 && y <= 45)) ||
                       ((x >= 51 && x <= 67) && (y >= 30 && y <= 45)) ||
                       ((x >= 69 && x <= 85) && (y >= 30 && y <= 45));

endmodule