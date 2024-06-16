// ブロック崩し、vBlock_*.pdeに依存

int SB_blocks[][] = new int[10][12]; // ブロックのHPを格納する2次元配列
ArrayList<Ball> SB_balls = new ArrayList<Ball>(); // ボールのclassを格納するArrayList
float SB_ballSize; // ボールの大きさ
boolean SB_isTimeProcessing = false; // 停止状態で開始
double SB_lastEnergy = 0; // 最後の獲得エネルギー
int SB_gameSpeed = 100; // ゲームの速度
int SB_blocksLife = 1; // ブロックの初期HP
int SB_barSize = 50; // バーの横幅
double SB_inflationRate = 1.0; // 獲得エネルギーインフレ率

int SB_blockWindowWidth; // ブロック崩し本体のウィンドウの横幅

void SB_boot() {
  SB_ballSize = float(GAME_width) / 50;
  SB_blockWindowWidth = GAME_width * 2 / 3 - GAME_width / 40;
  VB_boot(); // ブロック崩し本体を初期化
  VP_Boot(); // サイドパネルを初期化
  VS_boot(); // スキルを初期化
}
void SB_update() {
  background(50, 100, 100);
  VB_update(); // ブロック崩し本体を更新
  VP_update(); // サイドパネルを更新
  VS_update(); // スキルを更新
  navbar("","モード: " + "ソロ探索"+"　接続Channel:"+"rd1234"); // ナビゲーションバー
}

void SB_pause() { // 一時停止
  SB_isTimeProcessing = !SB_isTimeProcessing;
  if (SB_isTimeProcessing) {
    bgm2.play();
  } else {
    bgm2.pause();
  }
}
