`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//
//  LAB SESSION DAY (Delete where applicable): MONDAY P.M, TUESDAY P.M, WEDNESDAY P.M, THURSDAY A.M., THURSDAY P.M
//
//  STUDENT A NAME: ALYSSA YAN JIAQI
//  STUDENT A MATRICULATION NUMBER: 
//
//  STUDENT B NAME: KWOK HUI XIAN 
//  STUDENT B MATRICULATION NUMBER: A0287529L
//
//////////////////////////////////////////////////////////////////////////////////

module Top_Student (
    //Common input
    input CLK, //100Mhz clock signal
    //input for 4.1A: setting up the microphone
    input [1:0] SW,
    input btnR,
    input btnC,
    input btnL,
    input J_MIC3_Pin3,   // Connect from this signal to Audio_Capture.v
    //input for 4.2B: Design volume bar
    input [8:1] VOLUME_SW,
    //Output for 4.1A: setting up the microphone
    output J_MIC3_Pin1,   // Connect to this signal from Audio_Capture.v
    output J_MIC3_Pin4,   // Connect to this signal from Audio_Capture.v
    //output [11:0] LED,  // Display microphone data received from Audio_Capture.v, mic_in on 12 LEDs
    //Output for 4.1B //Setting up the OLED
    output [7:0] JC,
    //Output for 4.2A: REAL-TIME AUDIO VOLUME INDICATOR
    //we use the 7-segment displays and LED array on the Basys 3 as audio volume indicators. 
    //Each numerical value on the 7-segment displays, and each LED, would represent an amplitude range from the audio signal.
    output [15:0] LED, 
    output [6:0] SEG, 
    output DP,
    output [3:0] AN        
    );

    //4.1A Setting up the Microphone
    //4.2A REAL-TIME AUDIO VOLUME INDICATOR    

    reg [12:0]COUNT1 = 0;
    reg CLK_20KHZ = 0;
    
    reg [23:0]COUNT2 = 0;
    reg CLK_10HZ = 0;

    reg [25:0]COUNT3 = 0;
    reg CLK_2HZ = 0;
    
    reg [26:0]COUNT5 = 0;
    reg CLK_1HZ = 0;
    
    wire [11:0]sample; //the audio signal from the microphone is read and stored in a 12-bit register named sample
        
    reg [11:0]peak_v = 0;
    reg rst = 0;
    reg [15:0]LED_temp;
    reg [6:0]SEG_temp;
    
    reg [6:0]SEG_temp1 = 7'b1111111;
    reg [3:0]AN_temp1 = 4'b1111;
    reg [3:0]AN_temp = 4'b1111;
    
    reg setting = 0;
    
    reg [17:0]COUNT6 = 0;
    reg FAST_CLOCK = 0;
    
    reg [2:0]countx = 3'b000;
    
    reg counta = 0;

    reg [4:0] volume;

    wire [15:0] game_oled_data;
    wire [15:0] volume_oled_data;
    
    //toggling CLK_20KHZ and CLK_10HZ signal
    always @ (posedge CLK) begin
        COUNT1 <= (COUNT1 == 2500) ? 0 : COUNT1 + 1; //Count Value = 100MHZ / (2 x 20KHZ)
        CLK_20KHZ <= ( COUNT1 == 0 ) ? ~CLK_20KHZ : CLK_20KHZ;
   
        COUNT2 <= (COUNT2 == 4999999) ? 0 : COUNT2 + 1;//Count Value = 100MHZ / (2 x 10HZ)
        CLK_10HZ <= ( COUNT2 == 0 ) ? ~CLK_10HZ : CLK_10HZ;
    end
    
    //When enabled by SW == 1, the module assigns SW = CLK_10HZ, otherwise it assigns SW = CLK_20HZ:
    //When SW is ON (1): The 12-bitmic_in IS represented on LEDs that updates at a clock speed of 10HZ
    //When SW is OFF (0): The 12-bitmic_in IS represented on LEDs that updates at a clock speed of 20KHZ
    wire CLK_SW;
    
    assign CLK_SW = SW[0] ? CLK_10HZ : CLK_20KHZ;
    
    //instantiate the Audio_Capture.v module in Top_Student.v
    Audio_Capture uo (CLK, CLK_SW, J_MIC3_Pin3, J_MIC3_Pin1, J_MIC3_Pin4, sample);
    
    //Audio_Capture uo (CLK, CLK_20KHZ_4pt2A, J_MIC3_Pin3, J_MIC3_Pin1, J_MIC3_Pin4, sample);
    
    reg [25:0] peak_count = 0;
    always @ (posedge CLK_20KHZ) begin
        //peak_v = sample;
        peak_v <= (peak_count == 0) ? 0 : ((sample > peak_v) ? sample : peak_v);
        peak_count <= (peak_count == 10000) ? 0 : (peak_count +1);
    end
    always @ (posedge CLK) begin
        COUNT1 <= (COUNT1 == 2500) ? 0 : COUNT1 + 1;
        CLK_20KHZ <= ( COUNT1 == 0 ) ? ~CLK_20KHZ : CLK_20KHZ;
        
        COUNT3 <= (COUNT3 == 24999999) ? 0 : COUNT3 + 1;
        CLK_2HZ <= ( COUNT3 == 0 ) ? ~CLK_2HZ : CLK_2HZ;
        
        //COUNT5 <= (COUNT5 == 4999999) ? 0 : COUNT5 + 1;
        COUNT5 <= (COUNT5 == 49999999) ? 0 : COUNT5 + 1;
        CLK_1HZ <= ( COUNT5 == 0 ) ? ~CLK_1HZ : CLK_1HZ;
        
        COUNT6 <= (COUNT6 == 131232) ? 0 : COUNT6 + 1;
        FAST_CLOCK <= ( COUNT6 == 0 ) ? ~FAST_CLOCK : FAST_CLOCK;

    //end
         
        if (peak_v <= 2175) begin
            LED_temp[15:0] = 16'b0000000000000001;
            SEG_temp[6:0] = 7'b1000000; //Display 0 
            setting = 0;
            volume <= 5'd0;
        end
        else if (peak_v > 2175 && peak_v <= 2303) begin
            LED_temp[15:0] = 16'b0000000000000011;
            SEG_temp[6:0] = 7'b1111001;//1
            setting = 0;
            volume <= 5'd1;
        end
        else if (peak_v > 2303 && peak_v <= 2431) begin
            LED_temp[15:0] = 16'b0000000000000111;
            SEG_temp[6:0] = 7'b0100100;//2
            AN_temp[3:0] = 4'b1110;
            setting = 0;
            volume <= 5'd2;
        end
        else if (peak_v > 2431 && peak_v <= 2559) begin
            LED_temp[15:0] = 16'b0000000000001111;
            SEG_temp[6:0] = 7'b0110000;//3
            AN_temp[3:0] = 4'b1110;
            setting = 0;
            volume <= 5'd3;
        end
        else if (peak_v > 2559 && peak_v <= 2687) begin
            LED_temp[15:0] = 16'b0000000000011111;
            SEG_temp[6:0] = 7'b0011001;//4
            AN_temp[3:0] = 4'b1110;
            setting = 0;
            volume <= 5'd4;
        end
        else if (peak_v > 2687 && peak_v <= 2815) begin
            LED_temp[15:0] = 16'b0000000000111111;
            SEG_temp[6:0] = 7'b0010010;//5
            AN_temp[3:0] = 4'b1110;
            setting = 0;
            volume <= 5'd5;
        end
        else if (peak_v > 2815 && peak_v <= 2943) begin
            LED_temp[15:0] = 16'b0000000001111111;
            SEG_temp[6:0] = 7'b0000010;//6
            AN_temp[3:0] = 4'b1110;
            setting = 0;
            volume <= 5'd6;
        end
        else if (peak_v > 2943 && peak_v <= 3071) begin
            LED_temp[15:0] = 16'b0000000011111111;
            SEG_temp[6:0] = 7'b1111000;//7
            AN_temp[3:0] = 4'b1110;
            setting = 0;
            volume <= 5'd7;
        end
        else if (peak_v > 3071 && peak_v <= 3199) begin
            LED_temp[15:0] = 16'b0000000111111111;
            SEG_temp[6:0] = 7'b0000000;//8
            AN_temp[3:0] = 4'b1110;
            setting = 0;
            volume <= 5'd8;
        end
        else if (peak_v > 3199 && peak_v <= 3327) begin
            LED_temp[15:0] = 16'b0000001111111111; 
            SEG_temp[6:0] = 7'b0010000;//9
            AN_temp[3:0] = 4'b1110;
            setting = 0;
            volume <= 5'd9;
        end
        else if (peak_v > 3327 && peak_v <= 3455) begin
            LED_temp[15:0] = 16'b0000011111111111;
            setting = 1;
            countx = 3'b000;
            volume <= 5'd10;
        end
        else if (peak_v > 3455 && peak_v <= 3583) begin
            LED_temp[15:0] = 16'b0000111111111111;
            setting = 1;
            countx = 3'b001;
            volume <= 5'd11;
        end
        else if (peak_v > 3583 && peak_v <= 3711) begin
            LED_temp[15:0] = 16'b0001111111111111;
            setting = 1;
            countx = 3'b010;
            volume <= 5'd12;
        end
        else if (peak_v > 3711 && peak_v <= 3839) begin
            LED_temp[15:0] = 16'b0011111111111111;
            setting = 1;
            countx = 3'b011;
            volume <= 5'd13;
        end
        else if (peak_v > 3839 && peak_v <= 3967) begin
            LED_temp[15:0] = 16'b0111111111111111;
            setting = 1;
            countx = 3'b100;
            volume <= 5'd14;
        end
        else if (peak_v > 3967 && peak_v <= 4095) begin
            LED_temp[15:0] = 16'b1111111111111111;
            setting = 1;
            countx = 3'b101;
            volume <= 5'd15;
        end
    end
    
    always @ (posedge FAST_CLOCK) begin        
        if (setting == 1) begin
            if(countx == 3'b000) begin //10
                if (counta == 0) begin
                    SEG_temp1[6:0] <= 7'b1111001;
                    AN_temp1[3:0] <= 4'b1101;
                    counta <= 1'b1;
                end 
                if (counta == 1) begin
                    SEG_temp1[6:0] <= 7'b1000000;
                    AN_temp1[3:0] <= 4'b1110;
                    counta <= 1'b0;
                end
            end
            else if (countx == 3'b001) begin //11
                if (counta == 0) begin
                    SEG_temp1[6:0] <= 7'b1111001;
                    AN_temp1[3:0] <= 4'b1101;
                    counta <= 1'b1;
                end 
                if (counta == 1) begin
                    SEG_temp1[6:0] <= 7'b1111001;
                    AN_temp1[3:0] <= 4'b1110;
                    counta <= 1'b0;
                end
            end
            else if (countx == 3'b010) begin //12
                if (counta == 0) begin
                    SEG_temp1[6:0] <= 7'b1111001;
                    AN_temp1[3:0] <= 4'b1101;
                    counta <= 1'b1;
                end 
                if (counta == 1) begin
                    SEG_temp1[6:0] <= 7'b0100100;
                    AN_temp1[3:0] <= 4'b1110;
                    counta <= 1'b0;
                end
            end
            else if (countx == 3'b011) begin //13
                if (counta == 0) begin
                    SEG_temp1[6:0] <= 7'b1111001;
                    AN_temp1[3:0] <= 4'b1101;
                    counta <= 1'b1;
                end 
                if (counta == 1) begin
                    SEG_temp1[6:0] <= 7'b0110000;
                    AN_temp1[3:0] <= 4'b1110;
                    counta <= 1'b0;
                end
            end
            else if (countx == 3'b100) begin //14
                if (counta == 0) begin
                    SEG_temp1[6:0] <= 7'b1111001;
                    AN_temp1[3:0] <= 4'b1101;
                    counta <= 1'b1;
                end 
                if (counta == 1) begin
                    SEG_temp1[6:0] <= 7'b0011001;
                    AN_temp1[3:0] <= 4'b1110;
                    counta <= 1'b0;
                end
            end
            else if (countx == 3'b101) begin //15
                if (counta == 0) begin
                    SEG_temp1[6:0] <= 7'b1111001;
                    AN_temp1[3:0] <= 4'b1101;
                    
                    counta <= 1'b1;
                end 
                if (counta == 1) begin
                    SEG_temp1[6:0] <= 7'b0010010;
                    AN_temp1[3:0] <= 4'b1110;
                    counta <= 1'b0;
                end
            end
        end
    end
    
    assign SEG[6:0] = (setting == 1) ? SEG_temp1[6:0] : SEG_temp[6:0];
    assign AN[3:0] = (setting == 1) ? AN_temp1[3:0] : AN_temp[3:0];
//    assign LED[14:11] = AN_temp1;
//    assign LED[2:0] = countx;
//    assign LED[10:3] = SEG_temp1;
    //assign LED = peak_v;
    assign LED[15:0] = LED_temp[15:0];
    assign DP = 1;  

    //Setting up the OLED
    wire frame_begin; 
    wire sending_pixels; 
    wire sample_pixel; 
    wire [12:0] pixel_index; 
    wire clk;
    wire reset;
    //wire [15:0] oled_data; //16-bit color setting; 5 bits for R, 6 bits for G, 5 bits for B
    wire [15:0] oled_data;
    wire [4:0] teststate;
  

    //toggling clk6pt25m signal
    reg clk6p25m = 0;
    reg [2 : 0] COUNT = 0; 
    
    always @ (posedge CLK) begin
    COUNT <= (COUNT == 8) ? 0 : COUNT + 1; // COUNT = (100M / (2 X 6.25M) = 8
    clk6p25m <= (COUNT == 0) ? ~clk6p25m : clk6p25m ;
    end

    assign clk = clk6p25m;
    assign JC[2] = 0;
    assign reset = 0;
    //assign oled_data = GREEN
    
    //4.1C: System integration
    //Student B's matriculation number: A0287529L
    //First rightmost numerical digit of the matriculation card of student B: 9
    //The 5 most significant bits of mic_in must be connected to the B component 
    //assign oled_data = {5'b0, 6'b0, LED[11:7]};

    //Instantiate the Oled_Display.v module in Top_Student.v
    Oled_Display d0 (clk, reset, frame_begin, sending_pixels, sample_pixel, pixel_index, oled_data, JC[0], JC[1], JC[3], JC[4], JC[5], JC[6], JC[7], teststate
    ); 
    

    //4.2B Design a volume bar
    //Create 1 pixel border
    //Create 60 by 30 pixels bar
    wire [6:0] x;
    assign x [6:0] = pixel_index % 96; //2^6 = 64; 2^0 = 1 
    wire [5:0] y;
    assign y [5:0] = pixel_index / 96; //2^5 = 32; 2^0 = 1
    
    Volume_Screen v0(x, y, VOLUME_SW[2:1], VOLUME_SW[8:3], volume, volume_oled_data);
    Game game(CLK, x, y, btnL, btnR, btnC, SW[1], VOLUME_SW[2:1], volume,  game_oled_data);

    assign oled_data = SW[1] ? game_oled_data : volume_oled_data;

endmodule

