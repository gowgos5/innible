module Record_Speak(
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
    wire xrange_c0 = (x >= 43 && x <= 44);
    wire xrange_c1 = (x >= 46 && x <= 47);
    wire xrange_c2 = (x >= 49 && x <= 50);
    wire xrange_c3 = (x >= 52 && x <= 53);
    wire xrange_c4 = (x >= 55 && x <= 56);
    wire xrange_c5 = (x >= 58 && x <= 59);
    wire xrange_c6 = (x >= 61 && x <= 62);
    wire xrange_c7 = (x >= 64 && x <= 65);
    wire xrange_c8 = (x >= 67 && x <= 68);
    wire xrange_c9 = (x >= 70 && x <= 71);
    wire xrange_c10 = (x >= 73 && x <= 74);
    wire xrange_c11 = (x >= 76 && x <= 77);
    wire xrange_c12 = (x >= 79 && x <= 80);
    wire xrange_c13 = (x >= 82 && x <= 83);
    wire xrange_c14 = (x >= 85 && x <= 86);
    wire xrange_c15 = (x >= 88 && x <= 89);

    wire yrange_r0 = (y >= 51 && y <= 52); 
    wire yrange_r1 = (y >= 48 && y <= 49);
    wire yrange_r2 = (y >= 45 && y <= 46);
    wire yrange_r3 = (y >= 42 && y <= 43);
    wire yrange_r4 = (y >= 39 && y <= 40);
    wire yrange_r5 = (y >= 36 && y <= 37);
    wire yrange_r6 = (y >= 33 && y <= 34);
    wire yrange_r7 = (y >= 30 && y <= 31);
    wire yrange_r8 = (y >= 27 && y <= 28);
    wire yrange_r9 = (y >= 24 && y <= 25);
    wire yrange_r10 = (y >= 21 && y <= 22);
    wire yrange_r11 = (y >= 18 && y <= 19);
    wire yrange_r12 = (y >= 15 && y <= 16);
    wire yrange_r13 = (y >= 12 && y <= 13);
    wire yrange_r14 = (y >= 9 && y <= 10);
    wire yrange_r15 = (y >= 6 && y <= 7);

    wire row0 = ((xrange_c0) && (yrange_r0)) || ((xrange_c1) && (yrange_r0)) || ((xrange_c2) && (yrange_r0)) || ((xrange_c3) && (yrange_r0)) ||
                ((xrange_c4) && (yrange_r0)) || ((xrange_c5) && (yrange_r0)) || ((xrange_c6) && (yrange_r0)) || ((xrange_c7) && (yrange_r0)) ||
                ((xrange_c8) && (yrange_r0)) || ((xrange_c9) && (yrange_r0)) || ((xrange_c10) && (yrange_r0)) || ((xrange_c11) && (yrange_r0)) ||
                ((xrange_c12) && (yrange_r0)) || ((xrange_c13) && (yrange_r0)) || ((xrange_c14) && (yrange_r0)) || ((xrange_c15) && (yrange_r0));     

    wire row1 = ((xrange_c0) && (yrange_r1)) || ((xrange_c1) && (yrange_r1)) || ((xrange_c2) && (yrange_r1)) || ((xrange_c3) && (yrange_r1)) ||
                ((xrange_c4) && (yrange_r1)) || ((xrange_c5) && (yrange_r1)) || ((xrange_c6) && (yrange_r1)) || ((xrange_c7) && (yrange_r1)) ||
                ((xrange_c8) && (yrange_r1)) || ((xrange_c9) && (yrange_r1)) || ((xrange_c10) && (yrange_r1)) || ((xrange_c11) && (yrange_r1)) ||
                ((xrange_c12) && (yrange_r1)) || ((xrange_c13) && (yrange_r1)) || ((xrange_c14) && (yrange_r1)) || ((xrange_c15) && (yrange_r1));     

    wire row2 = ((xrange_c0) && (yrange_r2)) || ((xrange_c1) && (yrange_r2)) || ((xrange_c2) && (yrange_r2)) || ((xrange_c3) && (yrange_r2)) ||
                ((xrange_c4) && (yrange_r2)) || ((xrange_c5) && (yrange_r2)) || ((xrange_c6) && (yrange_r2)) || ((xrange_c7) && (yrange_r2)) ||
                ((xrange_c8) && (yrange_r2)) || ((xrange_c9) && (yrange_r2)) || ((xrange_c10) && (yrange_r2)) || ((xrange_c11) && (yrange_r2)) ||
                ((xrange_c12) && (yrange_r2)) || ((xrange_c13) && (yrange_r2)) || ((xrange_c14) && (yrange_r2)) || ((xrange_c15) && (yrange_r2));     

    wire row3 = ((xrange_c0) && (yrange_r3)) || ((xrange_c1) && (yrange_r3)) || ((xrange_c2) && (yrange_r3)) || ((xrange_c3) && (yrange_r3)) ||
                ((xrange_c4) && (yrange_r3)) || ((xrange_c5) && (yrange_r3)) || ((xrange_c6) && (yrange_r3)) || ((xrange_c7) && (yrange_r3)) ||
                ((xrange_c8) && (yrange_r3)) || ((xrange_c9) && (yrange_r3)) || ((xrange_c10) && (yrange_r3)) || ((xrange_c11) && (yrange_r3)) ||
                ((xrange_c12) && (yrange_r3)) || ((xrange_c13) && (yrange_r3)) || ((xrange_c14) && (yrange_r3)) || ((xrange_c15) && (yrange_r3));     

    wire row4 = ((xrange_c0) && (yrange_r4)) || ((xrange_c1) && (yrange_r4)) || ((xrange_c2) && (yrange_r4)) || ((xrange_c3) && (yrange_r4)) ||
                ((xrange_c4) && (yrange_r4)) || ((xrange_c5) && (yrange_r4)) || ((xrange_c6) && (yrange_r4)) || ((xrange_c7) && (yrange_r4)) ||
                ((xrange_c8) && (yrange_r4)) || ((xrange_c9) && (yrange_r4)) || ((xrange_c10) && (yrange_r4)) || ((xrange_c11) && (yrange_r4)) ||
                ((xrange_c12) && (yrange_r4)) || ((xrange_c13) && (yrange_r4)) || ((xrange_c14) && (yrange_r4)) || ((xrange_c15) && (yrange_r4));     

    wire row5 = ((xrange_c0) && (yrange_r5)) || ((xrange_c1) && (yrange_r5)) || ((xrange_c2) && (yrange_r5)) || ((xrange_c3) && (yrange_r5)) ||
                ((xrange_c4) && (yrange_r5)) || ((xrange_c5) && (yrange_r5)) || ((xrange_c6) && (yrange_r5)) || ((xrange_c7) && (yrange_r5)) ||
                ((xrange_c8) && (yrange_r5)) || ((xrange_c9) && (yrange_r5)) || ((xrange_c10) && (yrange_r5)) || ((xrange_c11) && (yrange_r5)) ||
                ((xrange_c12) && (yrange_r5)) || ((xrange_c13) && (yrange_r5)) || ((xrange_c14) && (yrange_r5)) || ((xrange_c15) && (yrange_r5));     

    wire row6 = ((xrange_c0) && (yrange_r6)) || ((xrange_c1) && (yrange_r6)) || ((xrange_c2) && (yrange_r6)) || ((xrange_c3) && (yrange_r6)) ||
                ((xrange_c4) && (yrange_r6)) || ((xrange_c5) && (yrange_r6)) || ((xrange_c6) && (yrange_r6)) || ((xrange_c7) && (yrange_r6)) ||
                ((xrange_c8) && (yrange_r6)) || ((xrange_c9) && (yrange_r6)) || ((xrange_c10) && (yrange_r6)) || ((xrange_c11) && (yrange_r6)) ||
                ((xrange_c12) && (yrange_r6)) || ((xrange_c13) && (yrange_r6)) || ((xrange_c14) && (yrange_r6)) || ((xrange_c15) && (yrange_r6));     

    wire row7 = ((xrange_c0) && (yrange_r7)) || ((xrange_c1) && (yrange_r7)) || ((xrange_c2) && (yrange_r7)) || ((xrange_c3) && (yrange_r7)) ||
                ((xrange_c4) && (yrange_r7)) || ((xrange_c5) && (yrange_r7)) || ((xrange_c6) && (yrange_r7)) || ((xrange_c7) && (yrange_r7)) ||
                ((xrange_c8) && (yrange_r7)) || ((xrange_c9) && (yrange_r7)) || ((xrange_c10) && (yrange_r7)) || ((xrange_c11) && (yrange_r7)) ||
                ((xrange_c12) && (yrange_r7)) || ((xrange_c13) && (yrange_r7)) || ((xrange_c14) && (yrange_r7)) || ((xrange_c15) && (yrange_r7));     

    wire row8 = ((xrange_c0) && (yrange_r8)) || ((xrange_c1) && (yrange_r8)) || ((xrange_c2) && (yrange_r8)) || ((xrange_c3) && (yrange_r8)) ||
                ((xrange_c4) && (yrange_r8)) || ((xrange_c5) && (yrange_r8)) || ((xrange_c6) && (yrange_r8)) || ((xrange_c7) && (yrange_r8)) ||
                ((xrange_c8) && (yrange_r8)) || ((xrange_c9) && (yrange_r8)) || ((xrange_c10) && (yrange_r8)) || ((xrange_c11) && (yrange_r8)) ||
                ((xrange_c12) && (yrange_r8)) || ((xrange_c13) && (yrange_r8)) || ((xrange_c14) && (yrange_r8)) || ((xrange_c15) && (yrange_r8));     

    wire row9 = ((xrange_c0) && (yrange_r9)) || ((xrange_c1) && (yrange_r9)) || ((xrange_c2) && (yrange_r9)) || ((xrange_c3) && (yrange_r9)) ||
                ((xrange_c4) && (yrange_r9)) || ((xrange_c5) && (yrange_r9)) || ((xrange_c6) && (yrange_r9)) || ((xrange_c7) && (yrange_r9)) ||
                ((xrange_c8) && (yrange_r9)) || ((xrange_c9) && (yrange_r9)) || ((xrange_c10) && (yrange_r9)) || ((xrange_c11) && (yrange_r9)) ||
                ((xrange_c12) && (yrange_r9)) || ((xrange_c13) && (yrange_r9)) || ((xrange_c14) && (yrange_r9)) || ((xrange_c15) && (yrange_r9));     

    wire row10 = ((xrange_c0) && (yrange_r10)) || ((xrange_c1) && (yrange_r10)) || ((xrange_c2) && (yrange_r10)) || ((xrange_c3) && (yrange_r10)) ||
                ((xrange_c4) && (yrange_r10)) || ((xrange_c5) && (yrange_r10)) || ((xrange_c6) && (yrange_r10)) || ((xrange_c7) && (yrange_r10)) ||
                ((xrange_c8) && (yrange_r10)) || ((xrange_c9) && (yrange_r10)) || ((xrange_c10) && (yrange_r10)) || ((xrange_c11) && (yrange_r10)) ||
                ((xrange_c12) && (yrange_r10)) || ((xrange_c13) && (yrange_r10)) || ((xrange_c14) && (yrange_r10)) || ((xrange_c15) && (yrange_r10));     

    wire row11 = ((xrange_c0) && (yrange_r11)) || ((xrange_c1) && (yrange_r11)) || ((xrange_c2) && (yrange_r11)) || ((xrange_c3) && (yrange_r11)) ||
                ((xrange_c4) && (yrange_r11)) || ((xrange_c5) && (yrange_r11)) || ((xrange_c6) && (yrange_r11)) || ((xrange_c7) && (yrange_r11)) ||
                ((xrange_c8) && (yrange_r11)) || ((xrange_c9) && (yrange_r11)) || ((xrange_c10) && (yrange_r11)) || ((xrange_c11) && (yrange_r11)) ||
                ((xrange_c12) && (yrange_r11)) || ((xrange_c13) && (yrange_r11)) || ((xrange_c14) && (yrange_r11)) || ((xrange_c15) && (yrange_r11));     

    wire row12 = ((xrange_c0) && (yrange_r12)) || ((xrange_c1) && (yrange_r12)) || ((xrange_c2) && (yrange_r12)) || ((xrange_c3) && (yrange_r12)) ||
                ((xrange_c4) && (yrange_r12)) || ((xrange_c5) && (yrange_r12)) || ((xrange_c6) && (yrange_r12)) || ((xrange_c7) && (yrange_r12)) ||
                ((xrange_c8) && (yrange_r12)) || ((xrange_c9) && (yrange_r12)) || ((xrange_c10) && (yrange_r12)) || ((xrange_c11) && (yrange_r12)) ||
                ((xrange_c12) && (yrange_r12)) || ((xrange_c13) && (yrange_r12)) || ((xrange_c14) && (yrange_r12)) || ((xrange_c15) && (yrange_r12));     

    wire row13 = ((xrange_c0) && (yrange_r13)) || ((xrange_c1) && (yrange_r13)) || ((xrange_c2) && (yrange_r13)) || ((xrange_c3) && (yrange_r13)) ||
                ((xrange_c4) && (yrange_r13)) || ((xrange_c5) && (yrange_r13)) || ((xrange_c6) && (yrange_r13)) || ((xrange_c7) && (yrange_r13)) ||
                ((xrange_c8) && (yrange_r13)) || ((xrange_c9) && (yrange_r13)) || ((xrange_c10) && (yrange_r13)) || ((xrange_c11) && (yrange_r13)) ||
                ((xrange_c12) && (yrange_r13)) || ((xrange_c13) && (yrange_r13)) || ((xrange_c14) && (yrange_r13)) || ((xrange_c15) && (yrange_r13));     

    wire row14 = ((xrange_c0) && (yrange_r14)) || ((xrange_c1) && (yrange_r14)) || ((xrange_c2) && (yrange_r14)) || ((xrange_c3) && (yrange_r14)) ||
                ((xrange_c4) && (yrange_r14)) || ((xrange_c5) && (yrange_r14)) || ((xrange_c6) && (yrange_r14)) || ((xrange_c7) && (yrange_r14)) ||
                ((xrange_c8) && (yrange_r14)) || ((xrange_c9) && (yrange_r14)) || ((xrange_c10) && (yrange_r14)) || ((xrange_c11) && (yrange_r14)) ||
                ((xrange_c12) && (yrange_r14)) || ((xrange_c13) && (yrange_r14)) || ((xrange_c14) && (yrange_r14)) || ((xrange_c15) && (yrange_r14));     

    wire row15 = ((xrange_c0) && (yrange_r15)) || ((xrange_c1) && (yrange_r15)) || ((xrange_c2) && (yrange_r15)) || ((xrange_c3) && (yrange_r15)) ||
                ((xrange_c4) && (yrange_r15)) || ((xrange_c5) && (yrange_r15)) || ((xrange_c6) && (yrange_r15)) || ((xrange_c7) && (yrange_r15)) ||
                ((xrange_c8) && (yrange_r15)) || ((xrange_c9) && (yrange_r15)) || ((xrange_c10) && (yrange_r15)) || ((xrange_c11) && (yrange_r15)) ||
                ((xrange_c12) && (yrange_r15)) || ((xrange_c13) && (yrange_r15)) || ((xrange_c14) && (yrange_r15)) || ((xrange_c15) && (yrange_r15));     

    always @ (*) begin
    oled_data = WHITE;
        if (SPEAK || AND || RELEASE) begin
            oled_data = BLACK;
        end
        else if (row0 || row1) begin
            oled_data = BROWN;
        end
        else if (row2 || row3) begin
            oled_data = RED;
        end
        else if (row4 || row5) begin
            oled_data = YELLOW;
        end
        else if (row6 || row7) begin
            oled_data = ORANGE;
        end
        else if (row8 || row9) begin
            oled_data = GREEN;
        end
        else if (row10 || row11) begin
            oled_data = SKYBLUE;
        end
        else if (row12 || row13) begin
            oled_data = BLUE;
        end
        else if (row14 || row15) begin
            oled_data = PURPLE;
        end       
    end  
endmodule
