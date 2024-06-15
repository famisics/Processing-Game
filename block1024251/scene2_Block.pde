int SB_block[][] = new int[10][12];
ArrayList<Ball> SB_balls = new ArrayList<Ball>(); // カッコ内にボールの個数を指定したい(拡張処理をスキップできる)
float SB_ballSize = GAME_width / 40;
boolean SB_isTimeProcessing = false; // 停止状態で開始
int SB_lastEnergy = 0;
int SB_gameSpeed = 100;
int SB_blockLife = 10;
int SB_barSize = 50;



void SB_boot() {
  // 初期化
  SB_isTimeProcessing = false;
  SB_lastEnergy = 0;
  SB_balls = new ArrayList<Ball>();
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 12; j++) {
      SB_block[i][j] = SB_blockLife;
    }
  }
  VB_addBall(50); // ボールの追加
}
void SB_update() {
  background(50, 100, 100);
  // ブロックの描画
  textAlign(CENTER,CENTER);
  for (int x = 0; x < 12; x++) {
    for (int y = 0; y < 10; y++) {
      SB_updateBlock(x,y);
    }
  }
  for (int i = 0; i < SB_balls.size(); i++) {
    SB_balls.get(i).update();
  }
  SB_updateBar();
  if (!SB_isTimeProcessing) {
    fill(255, 100, 100, 50);
    rect(0, 0, GAME_width, GAME_height);
    fill(255, 0, 0);
    textAlign(CENTER,CENTER);
    textFont(fontXl);
    text("PAUSED", GAME_width / 2, GAME_height / 2 - (GAME_height / 6));
    textFont(fontMd);
    text("Press space to resume", GAME_width / 2, GAME_height / 2 + (GAME_height / 6));
  }
  VS_update();
  navbar("","ENERGY: " + str(SB_lastEnergy));
}
void SB_pause() {
  // TODO: 音楽の再生停止
  SB_isTimeProcessing = !SB_isTimeProcessing;
  if (SB_isTimeProcessing) {
    bgm2.play();
  } else {
    bgm2.pause();
  }
}
void SB_updateBlock(int x, int y) {
  if (SB_block[y][x] > 0) {
    fill(250 - (250 * x / 12), 250 * x / 12, 250 * y / 10);
    rect(x * GAME_width / 12, y * GAME_height / 20, GAME_width / 12, GAME_height / 20);
    fill(0);
    textFont(fontMd);
    text(SB_block[y][x], x * GAME_width / 12 + GAME_width / 24 , y * GAME_height / 20 + GAME_height / 40);
  }
}
void SB_updateBar() {
  fill(255, 255, 0);
  int _barX = mouseX - GAME_width * SB_barSize / 480;
  if (_barX < 0) {_barX = 0;} else if (_barX + GAME_width * SB_barSize / 240 > GAME_width) {_barX = GAME_width - GAME_width * SB_barSize / 240;}
  rect(_barX, GAME_height - GAME_height / 10, GAME_width * SB_barSize / 240, GAME_height / 20);
}


