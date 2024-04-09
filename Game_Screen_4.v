module Game_Screen_4(
  input [6:0] x,
  input [5:0] y,
  output [15:0] oled_data
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

assign oled_data = MAGENTA;

endmodule
