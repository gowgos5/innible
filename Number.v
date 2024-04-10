module Number (
  input [6:0] x,
  input [5:0] y,
  input [3:0] n,
  output out
);

//Define constant as local parameter
//Colour display
localparam GREEN = 16'h07E0;
localparam ORANGE = 16'hFFE0; //Yellow
localparam RED = 16'hF800;
localparam BLACK = 16'h0000;
localparam PURPLE = 16'hF81F;
localparam YELLOW = 16'hFC00;    
localparam BLUE = 16'h001F; localparam WHITE = 16'hFFFF;
localparam CYAN = 16'hF81F;
localparam MAGENTA = 16'hF81F;
localparam BROWN = 16'h8204;
localparam SKYBLUE = 16'h5FFF;
//Display Score

parameter X = 0;
parameter Y = 0;
    
    wire zero = ((x >= X + 3 && x <= X + 7) && (y >= Y + 3 && y <= Y + 4)) || ((x >= X + 3 && x <= X+ 4) && (y >= Y + 3 && y <= Y + 10)) || ((x >= X + 3 && x <= X + 7) && (y >= Y + 9 && y <= Y + 10)) || ((x >= X + 6 && x <= X + 7) && (y >= Y + 3  && y <= Y + 10));
    wire one = ((x >= X + 6 && x <= X + 7)  && (y >= Y + 3 && y <= Y + 10));
    wire two = ((x >= X + 3 && x <= X + 7) && (y >= Y + 3 && y <= Y + 4)) || ((x >= X + 3 && x <= X + 7) && (y >= Y + 9 && y <= Y + 10)) || ((x >= X + 3 && x <= X + 7) && (y >= Y + 6 && y <= Y + 7)) || ((x >= X + 6 && x <= X + 7) && (y == Y + 5)) || ((x >= X + 3 && x <= X + 4) && (y == Y + 8));
    wire three = ((x >= X + 3 && x <= X + 7) && (y >= Y + 3 && y <= Y + 4)) || ((x >= X + 4 && x <= X + 7) && (y >= Y + 6 && y <= Y + 7)) || ((x >= X + 3 && x <= X + 7) && (y >= Y + 9 && y <= Y + 10)) || ((x >= X + 6 && x <= X + 7) && (y == Y + 5)) || ((x >= X + 6 && x <= X + 7) && (y == Y + 8));
    wire four = ((x >= X + 3 && x <= X + 4) && (y >= Y + 3 && y <= Y + 7)) || ((x >= X + 6 && x <= X + 7) && (y >= Y + 3 && y <= Y + 10)) || ((x >= X +3 && x <= X + 7) && (y >= Y + 6 && y <= Y + 7));
    wire five = ((x >= X + 3 && x <= X + 7) && (y >= Y + 3 && y <= Y + 4)) || ((x >= X + 3 && x <= X + 7) && (y >= Y + 9 && y <= Y + 10)) || ((x >= X + 3 && x <= X + 7) && (y >= Y + 6 && y <= Y + 7)) || ((x >= X + 6 && x <= X + 7) && (y == Y + 8)) || ((x >= X + 3 && x <= X + 4) && (y == Y + 5));
    wire six = ((x >= X + 3 && x <= X + 7) && (y >= Y + 3 && y <= Y + 4)) || ((x >= X + 3 && x <= X + 7) && (y >= Y + 9 && y <= Y + 10)) || ((x >= X + 3 && x <= X + 7) && (y >= Y + 6 && y <= Y + 7)) || ((x >= X + 6 && x <= X + 7) && (y == Y + 8)) || ((x >= X + 3 && x <= X + 4) && (y == Y + 5)) || ((x >= X + 3 && x <= X + 4) && (y == Y + 8));
    wire seven = ((x >= X + 6 && x <= X + 7) && (y >= Y + 3 && y <= Y + 10)) || ((x >= X + 3 && x <= X + 7) && (y >= Y + 3 && y <= Y + 4));
    wire eight = ((x >= X + 3 && x <= X + 7) && (y >= Y + 3 && y <= Y + 4)) || ((x >= X + 3 && x <= X + 7) && (y >= Y + 6 && y <= Y + 7)) || ((x >= X + 3 && x <= X + 7) && (y >= Y + 9 && y <= Y + 10)) || ((x >= X + 3 && x <= X + 4) && (y >= Y + 3 && y <= Y + 10)) || ((x >= X + 6 && x <= X + 7) && (y >= Y + 3 && y <= Y + 10));
    wire nine = ((x >= X + 6 && x <= X + 7) && (y >= Y + 3 && y <= Y + 10)) || ((x >= X + 3 && x <= X + 7) && (y >= Y + 3 && y <= Y + 4)) || ((x >= X + 3 && x <= X + 7) && (y >= Y + 6 && y <= Y + 7)) || ((x >= X + 3 && x <= X + 4) && (y >= Y + 3 && y <= Y + 7));

	assign out =  (  (zero && n == 4'd0) || (one && n == 4'd1) || (two && n == 4'd2) || (three && n == 4'd3) || (four && n == 4'd4) ||
                   (five && n == 4'd5) || (six && n == 4'd6) || (seven && n == 4'd7) || (eight && n == 4'd8) || (nine && n == 4'd9) );
endmodule

