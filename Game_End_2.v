module Game_End_2(
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
localparam LIGHTGREEN = 16'hAFE5;
    

    wire too_early = ((x >= 8 && x <= 20) && (y >= 9 && y <= 11)) || ((x >= 12 && x <= 17) && (y >= 12 && y <= 23)) ||
                     ((x >= 24 && x <= 29) && (y >= 9 && y <= 23)) || ((x >= 30 && x <= 32) && (y >= 9 && y <= 11)) || ((x >= 30 && x <= 32) && (y >= 21 && y <= 23)) || ((x >= 33 && x <= 35) && (y >= 9 && y <= 23)) ||
                     ((x >= 39 && x <= 44) && (y >= 9 && y <= 23)) || ((x >= 45 && x <= 47) && (y >= 9 && y <= 11)) || ((x >= 45 && x <= 47) && (y >= 21 && y <= 23)) || ((x >= 48 && x <= 50) && (y >= 9 && y <= 23)) ||
                     
                     ((x >= 9 && x <= 14) && (y >= 39 && y <= 53)) || ((x >= 15 && x <= 20) && (y >= 39 && y <= 41)) || ((x >= 15 && x <= 17) && (y >= 45 && y <= 47)) || ((x >= 15 && x <= 20) && (y >= 51 && y <= 53)) ||
                     ((x >= 24 && x <= 29) && (y >= 39 && y <= 53)) || ((x>= 30 && x <= 32) && (y >= 39 && y <= 41)) || ((x >= 30 && x <= 32) && (y >= 45 && y <= 47)) || ((x >= 33 &&x <= 35) && (y >= 39 && y <= 53)) ||
                     ((x >= 39 && x <= 44) && (y >= 39 && y <= 53)) || ((x >= 45 && x <= 47) && (y >= 39 && y <= 41)) || ((x >= 45 && x <= 47) && (y >= 45 && y <= 47)) || ((x >= 48 && x <= 50) && (y >= 39 && y <= 44)) || ((x >= 48 && x <= 50) && (y >= 48 && y <= 53)) ||
                     ((x >= 54 && x <= 59) && (y >= 39 && y <= 50)) || ((x >= 54 && x <= 65) && (y >= 51 && y <= 53)) ||
                     ((x >= 69 && x <= 71) && (y >= 39 && y <= 44)) || ((x >= 78 && x <= 80) && (y >= 39 && y <= 44)) || ((x >= 72 && x <= 77) && (y >= 45 && y <= 53));  
    
    always @ (*) begin
    oled_data = WHITE;
        if (too_early) begin
            oled_data = BLACK;
        end

    end 
    
endmodule
