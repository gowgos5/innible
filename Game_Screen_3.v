module Game_Screen_3(
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

    //Display Game Control
    wire S1 = ((x >= 20 && x <= 21) && (y >= 5 && y <= 7)) || ((x >= 22 && x <= 23) && (y == 5)) || ((x >= 22 && x <= 23) && (y >= 7 && y <= 9)) || ((x >= 20 && x <= 21) && (y == 9)) ||
              ((x >= 25 && x <= 26) && (y >= 5 && y <= 9)) || ((x >= 27 && x <= 28) && (y == 5)) || ((x == 27) && (y == 7)) || ((x >= 27 && x <= 28) && (y == 9)) ||
              ((x >= 30 && x <= 33) && (y == 5)) || ((x >= 31 && x <= 32) && (y >= 5 && y <= 9)) ||
              ((x >= 35 && x <= 38) && (y == 5)) || ((x >= 36 && x <= 37) && (y >= 5 && y <= 9)) ||
              ((x >= 40 && x <= 43) && (y == 5)) || ((x >= 41 && x <= 42) && (y >= 5 && y <= 9)) || ((x >= 40 && x <= 43) && (y == 9)) ||
              ((x >= 45 && x <= 46) && (y >= 5 && y <= 9)) || ((x == 47) && (y == 5)) || ((x == 48) && (y >= 5 && y <= 9)) ||
              ((x >= 50 && x <= 51) && (y >= 5 && y <= 9)) || ((x >= 52 && x <= 53) && (y == 5)) || ((x == 52) && (y == 9)) || ((x == 53) && (y >= 7 && y <= 9)) ||
                         
              ((x >= 57 && x <= 58) && (y >= 5 && y <= 9)) || ((x == 59) && (y == 5)) || ((x == 60) && (y >= 5 && y <= 9)) ||
              ((x >= 62 && x <= 63) && (y >= 5 && y <= 9)) || ((x == 64) && (y == 5)) || ((x == 64) && (y == 9)) || ((x == 65) && (y >= 5 && y <= 9)) ||
                         
              ((x == 68) && (y == 9)) ||
                         
              ((x == 73) && (y == 6)) || ((x >= 74 && x <= 75) && (y >= 5 && y <= 9)) || ((x == 73) && (y == 9)) || ((x == 76) && (y == 9));

    always @ (*) begin
      oled_data = RED;
    end

endmodule


