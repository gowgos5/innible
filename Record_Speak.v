module Record_Speak(
  input [6:0] x,
  input [5:0] y,
  input [79:0] volume,
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

    //Display Speak
    wire SPEAK = ((x >= 4 && x <= 6) && (y == 36)) || ((x == 3) && (y == 37)) || ((x >= 4 && x <= 5) && (y == 38)) || ((x == 6) && (y == 39)) || ((x >= 3 && x <= 5) && (y == 40)) ||  
                 ((x == 8) && (y >= 36 && y <= 40)) || ((x >= 8 && x <= 10) && (y == 36)) || ((x == 11) && (y == 37)) || ((x >= 8 && x <=10) && (y == 38)) ||
                 ((x == 13) && (y >= 36 && y <= 40)) || ((x >= 13 && x <= 16) && (y == 36)) || ((x >= 13 && x <= 15) && (y == 38)) || ((x >= 13 && x <= 16) && (y == 40)) ||
                 ((x == 18) && (y >= 37 && y <= 40)) || ((x >= 19 && x <= 20) && (y == 36)) || ((x >= 18 && x <= 21) && (y == 38)) || ((x == 21) && (y >= 37 && y <= 40)) ||
                 ((x == 23) && (y >= 36 && y <= 40)) || ((x == 24) && (y == 38)) || ((x == 25) && (y == 37)) || ((x == 26) && (y == 36)) || ((x == 25) && (y == 39)) || ((x == 26) && (y == 40)); 
    
    //Display And             
    wire AND = ((x >= 31 && x <= 34) && (y == 40)) || ((x == 30) && (y == 39)) || ((x == 33) && (y == 39)) || ((x == 34) && (y == 38)) || ((x == 32) && (y == 38)) || ((x == 32) && (y == 36)) || ((x == 31) && (y >= 37 && y <= 38)) || ((x == 33) && (y >= 36 && y <= 37));  
    
    
    //Display Release
    wire RELEASE = ((x == 3) && (y >= 48 && y <= 52)) || ((x >= 3 && x <= 5) && (y == 48)) || ((x == 6) && (y == 49)) || ((x >= 3 && x <= 5) && (y == 50)) || ((x == 5) && (y == 51)) || ((x == 6) && (y == 52)) ||  
                   ((x == 8) && (y >= 48 && y <= 52)) || ((x >= 8 && x <= 11) && (y == 48)) || ((x >= 8 && x <= 10) && (y == 50)) || ((x >= 8 && x <= 11) && (y == 52)) ||
                   ((x == 13) && (y >= 48 && y <= 52)) || ((x >= 13 && x <= 16) && (y == 52)) ||
                   ((x == 18) && (y >= 48 && y <= 52)) || ((x >= 18 && x <= 21) && (y == 48)) || ((x >= 18 && x <= 20) && (y == 50)) || ((x >= 18 && x <= 21) && (y == 52)) ||
                   ((x == 23) && (y >= 49 && y <= 52)) || ((x >= 24 && x <= 25) && (y == 48)) || ((x >= 23 && x <= 26) && (y == 50)) || ((x == 26) && (y >= 49 && y <= 52)) ||
                   ((x >= 29 && x <= 31) && (y == 48)) || ((x == 28) && (y == 49)) || ((x >= 29 && x <= 30) && (y == 50)) || ((x == 31) && (y == 51)) || ((x >= 28 && x <= 30) && (y == 52)) ||
                   ((x == 33) && (y >= 48 && y <= 52)) || ((x >= 33 && x <= 36) && (y == 48)) || ((x >= 33 && x <= 35) && (y == 50)) || ((x >= 33 && x <= 36) && (y == 52));    
    
    //Display Speaker Volume
    wire xrange [15:0];
    assign xrange[0] = (x >= 43 && x <= 44);
    assign xrange[1] = (x >= 46 && x <= 47);
    assign xrange[2] = (x >= 49 && x <= 50);
    assign xrange[3] = (x >= 52 && x <= 53);
    assign xrange[4] = (x >= 55 && x <= 56);
    assign xrange[5] = (x >= 58 && x <= 59);
    assign xrange[6] = (x >= 61 && x <= 62);
    assign xrange[7] = (x >= 64 && x <= 65);
    assign xrange[8] = (x >= 67 && x <= 68);
    assign xrange[9] = (x >= 70 && x <= 71);
    assign xrange[10] = (x >= 73 && x <= 74);
    assign xrange[11] = (x >= 76 && x <= 77);
    assign xrange[12] = (x >= 79 && x <= 80);
    assign xrange[13] = (x >= 82 && x <= 83);
    assign xrange[14] = (x >= 85 && x <= 86);
    assign xrange[15] = (x >= 88 && x <= 89);

    wire yrange [15:0];
    assign yrange[0] = (y >= 51 && y <= 52); 
    assign yrange[1] = (y >= 48 && y <= 49);
    assign yrange[2] = (y >= 45 && y <= 46);
    assign yrange[3] = (y >= 42 && y <= 43);
    assign yrange[4] = (y >= 39 && y <= 40);
    assign yrange[5] = (y >= 36 && y <= 37);
    assign yrange[6] = (y >= 33 && y <= 34);
    assign yrange[7] = (y >= 30 && y <= 31);
    assign yrange[8] = (y >= 27 && y <= 28);
    assign yrange[9] = (y >= 24 && y <= 25);
    assign yrange[10] = (y >= 21 && y <= 22);
    assign yrange[11] = (y >= 18 && y <= 19);
    assign yrange[12] = (y >= 15 && y <= 16);
    assign yrange[13] = (y >= 12 && y <= 13);
    assign yrange[14] = (y >= 9 && y <= 10);
    assign yrange[15] = (y >= 6 && y <= 7);

  integer i;
  integer j;
  always @ (*) begin
    oled_data = WHITE;
    if (SPEAK || AND || RELEASE) begin
        oled_data = BLACK;
    end

    for (i = 0; i < 16; i = i + 1) begin  // time
      for (j = 0; j < 16; j = j + 1) begin // magnitude
        if (volume[(i*16) +: 16] >= j && xrange[i] && yrange[j]) begin
          if (j <= 1) begin
            oled_data = BROWN;
          end else if (j <= 3) begin
            oled_data = RED;
          end else if (j <= 5) begin
            oled_data = YELLOW;
          end else if (j <= 7) begin
            oled_data = ORANGE;
          end else if (j <= 9) begin
            oled_data = GREEN;
          end else if (j <= 11) begin
            oled_data = SKYBLUE;
          end else if (j <= 13) begin
            oled_data = BLUE;
          end else begin
            oled_data = PURPLE;
          end
        end
      end
    end
  end

endmodule

