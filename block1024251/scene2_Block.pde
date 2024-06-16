// ブロック崩し、vBlock_*.pdeに依存

int SB_blocks[][] = new int[10][12]; // ブロックのHPを格納する2次元配列
ArrayList<Ball> SB_balls = new ArrayList<Ball>(); // ボールのclassを格納するArrayList
float SB_ballSize; // ボールの大きさ
boolean SB_isTimeProcessing = false; // 停止状態で開始
double SB_lastEnergy = 0; // 最後の獲得エネルギー
float SB_gameSpeed = 1.0; // ゲームの速度
int SB_blocksLife = 1; // ブロックの初期HP
int SB_barSize = 50; // バーの横幅
double SB_inflationRate = 1.0; // 獲得エネルギーインフレ率

int SB_blockWindowWidth; // ブロック崩し本体のウィンドウの横幅
int SB_bootTime = 0; // ブロック崩の起動時間 
boolean SB_isStart = false; // ブロック崩しの起動状態

void SB_boot() { // 初期化
  SB_isTimeProcessing = false; // 停止状態で開始
  SB_lastEnergy = 0; // 最後のエネルギーを初期化
  SB_blockWindowWidth = GAME_width * 2 / 3 - GAME_width / 40; // ブロック崩しの幅
  VB_boot(); // ブロック崩し本体を初期化
  VP_Boot(); // サイドパネルを初期化
  VS_boot(); // スキルを初期化
  SB_isStart = false; // 起動状態にする
  SB_bootTime = GAME_clock; // 起動時間を記録
}
void SB_update() { // 更新
  background(50, 100, 100);
  VB_update(); // ブロック崩し本体を更新
  VP_update(); // サイドパネルを更新
  VS_update(); // スキルを更新
  SB_pauseUpdate(); // 一時停止時の描画
  SB_start(); // ゲーム開始時のカウントダウン
  navbar("1 : シールド　2 : バー拡張　3 : 相手のバー縮小　4 : 時間減速　5 : 相手の時間加速　6 : 逆転　7 : 支援砲撃　8 : 追加１　9 : 追加２　0 : インフレ　L : リセット","総ブロック数 : " + VB_sumLife);
}

void SB_start() {
  if (!SB_isStart) {
    int _r = (5 - (int)Math.floor((GAME_clock - SB_bootTime) / 1000.0));
    fill(200, 200, 255);
    textFont(SH_fontTitle);
    textAlign(CENTER, CENTER);
    text("探索開始まで: " + str(_r), GAME_width / 2, GAME_height * 3 / 4);
    if (_r <=  0) {
      SB_isStart = true;
      SB_pause();
    }
  }
}

void SB_pause() { // 一時停止
  SB_isTimeProcessing = !SB_isTimeProcessing;
  if (SB_isTimeProcessing) {
    bgm2.play();
  } else {
    bgm2.pause();
  }
}

void SB_pauseUpdate() {
  if (!SB_isTimeProcessing) {
    textAlign(CENTER, CENTER);
    fill(20, 200);
    rect(0, 0, GAME_width, GAME_height);
    fill(0, 200, 200);
    textFont(fontXl);
    text("PAUSED", GAME_width / 2, GAME_height / 2 - (GAME_height / 6));
    textFont(fontMd);
    // text("Press Enter to resume", GAME_width / 2, GAME_height / 2 + (GAME_height / 6));
    // TODO:いつでもpauseできたらまずいのでは…？(デモ用かな)
  }
}
