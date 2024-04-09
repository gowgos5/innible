module Game_Screen_9(
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

    //Display Chair
    wire xrange_bar1 = (x >= 35 && x <= 62);
    wire yrange_stick1 = (y >= 12 && y <= 21);
    wire xrange_bar2 = (x >= 30 && x <= 67);
    wire yrange_stick2 = (y >= 37 && y <= 38);    
    wire xrange_bar3 = (x >= 40 && x <= 57);
    wire yrange_stick3 = (y >= 23 && y <= 35);
    wire yrange_stick4 = (y >= 22 && y <= 35);
    wire yrange_stick5 = (y >= 40 && y <= 56);
    wire yrange_stick6 = (y >= 40 && y <= 56);


    wire CHAIR = xrange_bar1 && (y >= 11 && y <= 12) || xrange_bar1 && (y >= 21 && y <= 22) || ((x >= 33 && x <= 34) && yrange_stick1) || ((x >= 64 && x <= 65) && yrange_stick1) || 
                 xrange_bar2 && (y >= 35 && y <= 36) || xrange_bar2 && (y >= 39 && y <= 40) || ((x >= 28 && x <= 29) && yrange_stick2) || ((x >= 68 && x <= 69) && yrange_stick2) || 
                 xrange_bar3 && (y >= 43 && y <= 44) || xrange_bar3 && (y >= 46 && y <= 47) || 
                 ((x >= 35 && x <= 39) && (y >= 55 && y <= 56)) || ((x >= 58 && x <= 62) && (y >= 55 && y <= 56)) ||
                 ((x >= 39 && x <= 40) && yrange_stick3)|| ((x >= 42 && x <= 43) && yrange_stick3) ||
                 ((x >= 54 && x <= 55) && yrange_stick4) || ((x >= 57 && x <= 58) && yrange_stick4) ||
                 ((x >= 35 && x <= 36) && yrange_stick5) || ((x >= 38 && x <= 39) && yrange_stick5) ||
                 ((x >= 58 && x <= 59) && yrange_stick6) || ((x >= 61 && x <= 62) && yrange_stick6);

  
    wire BROWN_CHAIR = xrange_bar1 && yrange_stick1 || xrange_bar2 && yrange_stick2 || xrange_bar3 && y == 45 || x == 41 && yrange_stick3 || x == 56 && yrange_stick4 || x == 37 && yrange_stick5 || x == 60 && yrange_stick6;

always @ (*) begin
  oled_data = MAGENTA;
end

endmodule
