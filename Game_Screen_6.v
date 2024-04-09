module Game_Screen_6(
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

    //Display HAND
    wire Hand = ((x >= 34 && x <= 52) && (y >= 7 && y <= 8)) || ((x >= 34 && x <= 35) && (y >= 7 && y <= 12)) || ((x >= 51 && x <= 52) && (y >= 7 && y <= 12)) || 
                ((x >= 32 && x <= 33) && (y >= 13 && y <= 18)) || ((x >= 30 && x <= 31) && (y >= 19 && y <= 31)) || ((x >= 32 && x <= 33) && (y >= 32 && y <= 33)) ||
                ((x >= 34 && x <= 37) && (y >= 34 && y <= 35)) || ((x >= 36 && x <= 37) && (y >= 29 && y <= 35)) || ((x >= 38 && x <= 43) && (y >= 36 && y <= 37)) ||
                ((x >= 42 && x <= 43) && (y >= 30 && y <= 37)) || ((x >= 44 && x <= 49) && (y >= 38 && y <= 39)) || ((x >= 48 && x <= 49) && (y >= 30 && y <= 47)) || 
                ((x >= 50 && x <= 52) && (y >= 48 && y <= 49)) || ((x >= 53 && x <= 54) && (y >= 25 && y <= 47)) || ((x >= 53 && x <= 58) && (y >= 30 && y <= 31)) ||
                ((x >= 59 && x <= 60) && (y >= 25 && y <= 29)) || ((x >= 57 && x <= 58) && (y >= 21 && y <= 24)) || ((x >= 55 && x <= 56) && (y >= 17 && y <= 20)) ||
                ((x >= 53 && x <= 54) && (y >= 13 && y <= 16));
    
    //Display Pushbutton
    wire pushbtn = ((x >= 46 && x <= 56) && (y == 53)) || ((x == 45) && (y == 54)) || ((x == 57) && (y == 54)) || ((x == 58) && (y >= 55 && y <= 59)) || 
                   ((x == 44) && (y >= 55 && y <= 59)) || ((x == 43) && (y == 59)) || ((x == 59) && (y == 59)) || ((x == 43) && (y == 60)) || 
                   ((x == 59) && (y == 60)) || ((x == 44) && (y == 61)) || ((x == 58) && (y == 61)) || ((x >= 45 && x <= 57) && (y == 62));
    
    wire pushbtnbar1 = ((x >= 45 && x<= 57) && (y >= 55 && y <= 59));
    wire pushbtnbar2 = ((x >= 46 && x<= 56) && (y == 54));
    
    //Display PRESS
    wire PRESS = ((x == 3) && (y >= 12 && y <= 16)) || ((x >= 3 && x <= 5) && (y == 12)) || ((x == 6) && (y == 13)) || ((x >= 3 && x <= 5) && (y == 14)) ||
                 ((x == 8) && (y >= 12 && y <= 16)) || ((x >= 8 && x <= 10) && (y == 12)) || ((x == 11) && (y == 13)) || ((x >= 8 && x <= 10) && (y == 14)) || ((x == 10) && (y == 15)) || ((x == 11) && (y == 16)) ||
                 ((x == 13) && (y >= 12 && y <= 16 )) || ((x >= 13 && x <= 16) && (y == 12)) || ((x >= 13 && x <= 15) && (y == 14)) || ((x >= 13 && x <= 16) && (y == 16)) ||
                 ((x >= 19 && x <= 21) && (y == 12)) || ((x == 18) && (y == 13)) || ((x >= 19 && x <= 20) && (y == 14)) || ((x == 21) && (y == 15)) || ((x >= 18 && x <= 20) && (y == 16)) ||
                 ((x >= 24 && x <= 26) && (y == 12)) || ((x == 23) && (y == 13)) || ((x >= 24 && x <= 25) && (y == 14)) || ((x == 26) && (y == 15)) || ((x >= 23 && x <= 25) && (y == 16));
  
    //Display Hold
    wire HOLD = ((x == 3) && (y >= 24 && y <= 28)) || ((x >= 3 && x <= 6) && (y == 26)) || ((x == 6) && (y >= 24 && y <= 28)) || 
                ((x == 8) && (y >= 25 && y <= 27)) || ((x >= 9 && x <= 10) && (y == 24)) || ((x >= 9 && x <= 10) && (y == 28)) || ((x == 11) && (y >= 25 && y <= 27)) ||
                ((x == 13) && (y >= 24 && y <= 28)) || ((x >= 13 && x <= 16) && (y == 28)) ||
                ((x == 18) && (y >= 24 && y <= 28)) || ((x >= 18 && x <= 20) && (y == 24)) || ((x == 21) && (y >= 25 && y <= 27)) || ((x >= 18 && x <= 20) && (y == 28));

    //Display Centre Button
    wire ctr_btn = ((x == 61) && (y >= 56 && y <= 58)) || ((x >= 62 && x <= 63) && (y == 55)) || ((x >= 62 && x <= 63) && (y == 59)) || ((x == 64) && (y == 56)) || ((x == 64) && (y == 58)) ||
                   ((x >= 66 && x <= 70) && (y == 55)) || ((x == 68) && (y >= 55 && y <= 59)) ||
                   ((x == 72) && (y >= 55 && y <= 59)) || ((x >= 72 && x <= 74) && (y == 55)) || ((x == 75) && (y == 56)) || ((x >= 72 && x <= 74) && (y == 57)) || ((x == 74) && (y == 58)) || ((x == 75) && (y == 59)) ||
                   ((x == 79) && (y >= 55 && y <= 59)) || ((x >= 79 && x <= 81) && (y == 55)) || ((x == 82) && (y == 56)) || ((x >= 79 && x <= 81) && (y == 57)) ||  ((x == 82) && (y == 58)) || ((x >= 79 && x <= 81) && (y == 59)) ||  
                   ((x >= 84 && x< 88) && (y == 55)) || ((x == 86) && (y >= 55 && y <= 59)) ||
                   ((x == 90) && (y >= 55 && y <= 59)) || ((x == 91) && (y == 56)) || ((x == 92) && (y == 57)) || ((x == 93) && (y >= 55 && y <= 59));

endmodule
