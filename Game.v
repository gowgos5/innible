module Game(
  input clk,
  input [6:0] x,
  input [5:0] y,
  input btnL,
  input btnR,
  input btnC,
  input sw,
  input [1:0] theme_sw,
  input [4:0] volume,
  output reg [15:0] oled_data
);

localparam IDLE = 4'b0000;
localparam TITLE = 4'b0001;
localparam CONTROLS_1 = 4'b0010;
localparam CONTROLS_2 = 4'b0011;
localparam SETTINGS = 4'b0100;
localparam MIC_START = 4'b0101;
localparam MIC_VOLUME = 4'b0110;
localparam RECORD_START = 4'b0111;
localparam RECORD_SPEAK = 4'b1000;
localparam GAME_START = 4'b1010;
localparam GAME_PLAY = 4'b1011;
localparam GAME_END_1 = 4'b1100;
localparam GAME_END_2 = 4'b1101;
localparam GAME_END_3 = 4'b1110;
localparam GAME_REPLAY = 4'b1111;

localparam OLED_BLANK = 16'h0000;

localparam GAME_PLAY_TIMEOUT_CNT = 9'd300;

wire clk_1hz;
wire clk_2hz;
wire clk_10hz;
wire clk_20hz;
wire clk_100hz;

Slow_Clock #(.SLOW_CLOCK_FREQUENCY(1)) slow_clock_1_hz(clk, clk_1hz);
Slow_Clock #(.SLOW_CLOCK_FREQUENCY(2)) slow_clock_2_hz(clk, clk_2hz);
Slow_Clock #(.SLOW_CLOCK_FREQUENCY(10)) slow_clock_10_hz(clk, clk_10hz);
Slow_Clock #(.SLOW_CLOCK_FREQUENCY(20)) slow_clock_30_hz(clk, clk_20hz);
Slow_Clock #(.SLOW_CLOCK_FREQUENCY(100)) slow_clock_100_hz(clk, clk_100hz);

reg btnR_pulse [2:0];

reg settings_use_btnR;

reg [8:0] record_cnt;
reg [4:0] record_volume [15:0]; 
reg [8:0] record_total_volume; 

wire lfsr_init;
wire [8:0] lfsr_seed;
wire [8:0] lfsr_out;
reg [8:0] lfsr_cnt = 9'd0;

reg [2:0] game_start_cnt;
reg [8:0] game_play_active_cnt;
reg [8:0] game_play_timeout_cnt;
wire game_play_active;
wire game_play_timeout;
wire [8:0] game_play_score_cnt;

assign lfsr_init = (next_state == GAME_START);
assign lfsr_seed = lfsr_cnt ^ record_total_volume;

LFSR lfsr(clk, lfsr_init, lfsr_seed, lfsr_out);

assign game_play_active = |game_play_active_cnt;
assign game_play_timeout = !(|game_play_timeout_cnt);
assign game_play_score_cnt = GAME_PLAY_TIMEOUT_CNT - game_play_timeout_cnt;

integer i;
always @ (posedge clk) begin
  btnR_pulse[0] <= btnR;
  btnR_pulse[1] <= btnR_pulse[0];
  btnR_pulse[2] <= btnR_pulse[0] & ~btnR_pulse[1];

  case (state)
    SETTINGS: settings_use_btnR <= btnR;
  endcase
end

always @ (posedge clk_2hz) begin
  case (state)
    RECORD_START: begin
                 record_cnt <= 9'd0;
                 for (i = 0; i < 16; i = i + 1) begin
                   record_volume[i] <= 5'd0;
                 end
               end
    RECORD_SPEAK: begin
                 record_cnt <= record_cnt + 9'd1;
                 record_volume[i] <= volume;
                 for (i = 1; i < 16; i = i + 1) begin
                   record_volume[i] <= record_volume[i-1];
                 end
               end
  endcase
end

always @ (posedge clk_100hz) begin
  lfsr_cnt <= lfsr_cnt + 9'd1;

  case (state)
    GAME_START: begin
                  game_play_active_cnt <= lfsr_out < 9'd100 ? lfsr_out + 9'd100 : lfsr_out;
                  game_play_timeout_cnt <= GAME_PLAY_TIMEOUT_CNT;
                end
    GAME_PLAY: begin
                 if (game_play_active) game_play_active_cnt <= game_play_active_cnt - 9'd1;
                 else if (!game_play_timeout) game_play_timeout_cnt <= game_play_timeout_cnt - 9'd1;
               end
  endcase
end

always @ (posedge clk_1hz) begin
  case (state)
    RECORD_SPEAK: game_start_cnt <= 3'b0;
    GAME_START: game_start_cnt <= game_start_cnt + 3'b1;
  endcase
end

wire [15:0] title_oled_data;
wire [15:0] controls_1_oled_data;
wire [15:0] controls_2_oled_data;
wire [15:0] settings_oled_data;
wire [15:0] mic_start_oled_data;
wire [15:0] mic_volume_oled_data;
wire [15:0] record_start_oled_data;
wire [15:0] record_speak_oled_data;
wire [15:0] game_start_oled_data;
wire [15:0] game_play_oled_data;
wire [15:0] game_end_1_oled_data;
wire [15:0] game_end_2_oled_data;
wire [15:0] game_end_3_oled_data;

Title title(x, y, title_oled_data);
Controls_1 controls_1(x, y, controls_1_oled_data);
Controls_2 controls_2(x, y, controls_2_oled_data);
Settings settings(x, y, settings_oled_data);
Mic_Start mic_start(x, y, mic_start_oled_data);
Mic_Volume mic_volume(x, y, theme_sw, volume, mic_volume_oled_data);
Record_Start record_start(x, y, record_start_oled_data);
Record_Speak record_speak(x, y, record_speak_oled_data);
Game_Start game_start(x, y, game_start_cnt, game_start_oled_data);
Game_Play game_play(clk_20hz, x, y, game_play_active, game_play_oled_data);
Game_End_1 game_end_1(x, y, game_play_score_cnt, game_end_1_oled_data);
Game_End_2 game_end_2(x, y, game_end_2_oled_data);
Game_End_3 game_end_3(x, y, game_end_3_oled_data);

always @ (*) begin
  oled_data = OLED_BLANK;
  case (state)
    TITLE: oled_data = title_oled_data;
    CONTROLS_1: oled_data = controls_1_oled_data;
    CONTROLS_2: oled_data = controls_2_oled_data;
    SETTINGS: oled_data = settings_oled_data;
    MIC_START: oled_data = mic_start_oled_data;
    MIC_VOLUME: oled_data = mic_volume_oled_data;
    RECORD_START: oled_data = record_start_oled_data;
    RECORD_SPEAK: oled_data = record_speak_oled_data;
    GAME_START: oled_data = game_start_oled_data;
    GAME_PLAY: oled_data = game_play_oled_data;
    GAME_END_1: oled_data = game_end_1_oled_data;
    GAME_END_2: oled_data = game_end_2_oled_data;
    GAME_END_3: oled_data = game_end_3_oled_data;
  endcase
end

reg [3:0] state;
reg [3:0] next_state;

always @ (posedge clk) begin
  state <= next_state;
end

always @ (*) begin
  next_state = state;
  case (next_state)
    IDLE: if (sw) next_state = TITLE;
    TITLE: if (btnR_pulse[2]) next_state = CONTROLS_1;
    CONTROLS_1: if (btnR_pulse[2]) next_state = CONTROLS_2;
    CONTROLS_2: if (btnR_pulse[2]) next_state = SETTINGS;
    SETTINGS: if (btnL || btnR_pulse[2]) next_state = MIC_START;
    MIC_START: if (btnR_pulse[2]) next_state = MIC_VOLUME;
    MIC_VOLUME: if (btnR_pulse[2]) next_state = RECORD_START;
    RECORD_START: if (btnC) next_state = RECORD_SPEAK;
    RECORD_SPEAK: if (~btnC) next_state = GAME_START;
    GAME_START: if (game_start_cnt > 3'd4) next_state = GAME_PLAY;
    GAME_PLAY: begin
                 if (game_play_timeout) next_state = GAME_END_3;
                 else if (btnL) next_state = game_play_active ? GAME_END_2 : GAME_END_1; // TODO
               end
  endcase
  if (~sw) begin
    next_state = IDLE;
  end

  record_total_volume = 9'd0;
  for (i = 0; i < 16; i = i + 1) begin
    record_total_volume = record_total_volume + record_volume[i];
  end
end

endmodule

