module Volume_Screen(
  input [6:0] x,
  input [5:0] y,
  input [1:0] theme_sw,
  input [5:0] display_sw,
  input [4:0] volume,
  output reg [15:0] oled_data
);

//Define constant as local parameter
//Colour display
localparam GREEN = 16'h07E0;
localparam ORANGE = 16'hFFE0; //Yellow
localparam RED = 16'hF800;
localparam BLACK = 16'h0000;
localparam WHITE = 16'hFFFF;
localparam BLUE = 16'h001F;
localparam SKYBLUE = 16'h5FFF;
localparam PURPLE = 16'hF81F;
localparam CYAN = 16'hF81F;
localparam MAGENTA = 16'hF81F;
localparam BROWN = 16'h8204;
localparam YELLOW = 16'hFC00;    

//96 x 64 bit display screen
//Length (X): 0 - 95; width (Y): 0 - 63
//The coordinates of the corner points of the green border:
//Bottom left corner: x = 1, y = 1
//Top left corner: x = 1, y = 62
//Bottom right corner: x = 94, y = 1
//Top right corner: x = 94, y = 62
//Colour the vertical border green
wire green_left_border = (x == 1) && (y >= 1 && y <= 62); 
wire green_right_border = (x == 94) && (y >= 1 && y <= 62); 
//Colour the horizontal border green
wire green_top_border = (x >= 1 && x <= 94) && (y == 62); 
wire green_bottom_border = (x >= 1 && x <= 94) && (y == 1);

//The coordinates of the corner points of the orange border:
//Bottom left corner: x = 3, y = 3
//Top left corner: x = 3, y = 60
//Bottom right corner: x = 92, y = 3
//Top right corner: x = 92, y = 60
//Colour the vertical border orange
wire orange_left_border = (x == 3) && (y >= 3 && y <= 60);
wire orange_right_border = (x == 92) && (y >= 3 && y <= 60);
//Colour the horizontal border orange
wire orange_top_border = (x >= 3 && x <= 92) && (y == 60);
wire orange_bottom_border = (x >= 3 && x <= 92) && (y == 3);

//The coordinates of the corner points of the red border:
//Bottom left corner: x = 5, y = 5
//Top left corner: x = 5, y = 58
//Bottom right corner: x = 90, y = 5
//Top right corner: x = 90, y = 58
//Colour the vertical border red
wire red_left_border = (x == 5) && (y >= 5 && y <= 58);
wire red_right_border = (x == 90) && (y >= 5 && y <= 58);
//Colour the horizontal border red
wire red_top_border = (x >= 5 && x <= 90) && (y == 58);
wire red_bottom_border = (x >= 5 && x <= 90) && (y == 5);

//Each bar has a length of 60 pixels
//(96 - 60) / 2 = 18
//Minimum point = 18 - 00 = 18 (LHS of x-axis)
//Maximum point = 95 - 18 = 77 (RHS of y-axis) 
wire xrange_bar = (x >= 18 && x <= 77); 
//The coordinates of the bar on the y - axis
//The size of the 6 bars is 30 pixels
//Minimum point = 17; Maximum point = 46
//Each bar has a width of 5 pixels
//Rank the bar from top to bottom (1 to 6)
//bottom corner of the 1th bar: y0 = 42 | top corner of the 1st bar: y1 = 46
wire green_bottom_bar = xrange_bar && (y >= 42 && y <= 46);
//bottom corner of the 2th bar: y0 = 37 | top corner of the 2nd bar: y1 = 41   
wire orange_bottom_bar = xrange_bar && (y >= 37 && y <= 41);
//bottom corner of the 3th bar: y0 = 32 | top corner of the 3rd bar: y1 = 36    
wire red_bottom_bar = xrange_bar && (y >= 32 && y <= 36);
//bottom corner of the 4th bar: y0 = 27 | top corner of the 4th bar: y1 = 31
wire red_top_bar = xrange_bar && (y >= 27 && y <= 31);
//bottom corner of the 5th bar: y0 = 22 | top corner of the 5th bar: y1 = 26
wire orange_top_bar = xrange_bar && (y >= 22 && y <= 26);    
//bottom corner of the 6th bar: y0 = 17 | top corner of the 6th bar: y1 = 21
wire green_top_bar = xrange_bar && (y >= 17 && y <= 21);

reg [15:0] green;
reg [15:0] orange;
reg [15:0] red;
reg [15:0] black;

wire [6:0] active_bars;

assign active_bars = { (volume == 0), (volume >= 1), (volume >= 3), (volume >= 6), (volume >= 9), (volume >= 12), (volume >= 14) };

always @ (*) begin
  // theme
  case (theme_sw)
    2'b00: begin
             green = GREEN;
             orange = ORANGE;
             red = RED;
             black = BLACK;
           end
    2'b01: begin
             green = PURPLE;
             orange = BLUE;
             red = YELLOW;
             black = WHITE;
           end
    2'b10: begin
             green = ORANGE;
             orange = GREEN;
             red = CYAN;
             black = BLUE;
           end
    2'b11: begin
             green = BROWN;
             orange = MAGENTA;
             red = BLUE; 
             black = SKYBLUE;
           end
  endcase
  oled_data = black;
  if (display_sw[2] && (green_left_border || green_right_border || green_top_border || green_bottom_border)) begin
    oled_data = green;
  end 
  else if (display_sw[1] && (orange_left_border || orange_right_border || orange_top_border || orange_bottom_border)) begin
    oled_data = orange;
  end 
  else if (display_sw[0] && (red_left_border || red_right_border || red_top_border || red_bottom_border)) begin
    oled_data = red;
  end 
  else if (display_sw[5] && active_bars[0] && green_top_bar) begin
    oled_data = green;
  end 
  else if (display_sw[5] && active_bars[5] && green_bottom_bar) begin
    oled_data = green;
  end 
  else if (display_sw[4] && active_bars[1] && orange_top_bar) begin
    oled_data = orange;
  end 
  else if (display_sw[4] && active_bars[4] && orange_bottom_bar) begin
    oled_data = orange;
  end 
  else if (display_sw[3] && active_bars[2] && red_top_bar) begin
    oled_data = red;
  end 
  else if (display_sw[3] && active_bars[3] && red_bottom_bar) begin
    oled_data = red;  
  end 
  else if (display_sw[5] && active_bars[6] && (green_top_bar || green_bottom_bar)) begin
    oled_data = green;
  end 
  else if (display_sw[4] && active_bars[6] && (orange_top_bar || orange_bottom_bar)) begin
    oled_data = orange;
  end 
  else if (display_sw[3] && active_bars[6] && (red_top_bar || red_bottom_bar)) begin
    oled_data = red;
  end 
end

endmodule

