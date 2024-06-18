// ブロック崩し、vBlock_*.pdeに依存

int SB_blocks[][] = new int[10][12]; // ブロックのHPを格納する2次元配列
ArrayList<Ball> SB_balls = new ArrayList<Ball>(); // ボールのclassを格納するArrayList
float SB_ballSize; // ボールの大きさ
boolean SB_isTimeProcessing = false; // 停止状態で開始
double SB_lastEnergy = 0; // 最後の獲得エネルギー
float SB_gameSpeed = 1.0; // ゲームの速度
int SB_blocksLife = 10; // ブロックの初期HP
int SB_barSize = 80; // バーの横幅
double SB_inflationRateTemporary = 1.0; // 獲得エネルギーインフレ率 (このゲームのみ)
double SB_inflationRate = 0.0; // 総エネルギーをもとに計算
int SB_ballCount = 1; // ボールの数
int SB_blockCount = 0; // ブロックの数

int SB_blockWindowWidth; // ブロック崩し本体のウィンドウの横幅
int SB_bootTime = 0; // ブロック崩の起動時間 
boolean SB_isStart = false; // ブロック崩しの起動状態
String SB_startMessageText = ""; // ブロック崩しの起動メッセージ
boolean SB_isBgmStarted = false; // BGMが開始されたかどうか

boolean BS_isShield = false;
double BS_inflationBoostRate = 1;

void SB_boot() { // 初期化
  noTint(); // 他ページのtintをオーバーライド、念のため
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
  navbar("総ブロック数 : " + SB_blockCount + "　総ボール数 : " + SB_ballCount,"");
}

void SB_start() {
  if (!SB_isStart) {
    int _r = (10 - (int)Math.floor((GAME_clock - SB_bootTime) / 1000.0));
    fill(255);
    textFont(SH_fontTitle);
    textAlign(CENTER, CENTER);
    text(str(_r), GAME_width / 2, GAME_height / 2);
    textFont(fontLg);
    text(SB_startMessageText, GAME_width / 2, GAME_height * 3 / 4);
    if (_r <= 0) {
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
    fill(50, 200);
    rect(0, 0, GAME_width, GAME_height);
    if (SB_isStart) {
      fill(255);
      textFont(fontXl);
      text("PAUSED", GAME_width / 2, GAME_height / 2 - (GAME_height / 6));
      textFont(fontMd);
      text("このゲームでポーズは想定されていません、これはデモ用です\n\npキーを押してゲームを再開します", GAME_width / 2, GAME_height / 2 + (GAME_height / 6));
    }
  }
}
