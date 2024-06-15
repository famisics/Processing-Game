// ブロック崩し、vBlock_*.pdeに依存

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
      VB_updateBlock(x,y);
    }
  }
  for (int i = 0; i < SB_balls.size(); i++) {
    SB_balls.get(i).update();
  }
  VB_updateBar();
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
