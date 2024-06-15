// 全体で参照する関数や変数の定義

ControlP5 CP; // ControlP5ライブラリ
SoundFile se, bgm1, bgm2, bgm3, bgm4, bgm5, bgm6; // サウンドファイル
FPS FPS_data; // FPSカウンター
ButtonClass Button; // ボタン
PImage image1, image2, image3, image4; // 画像ファイル
PFont fontXl, fontLg, fontMd, fontSm, fontMono, VP_fontScore, VP_fontScoreMd, SH_fontTitle; // フォント
JSONObject json; // JSONデータ

WebsocketClient NET_CLIENT; // Websocketクライアント
String NET_SERVER_HOST; // Proxyサーバーのホスト名

// JSONデータ
double DATA_ENERGY;
String DATA_USERNAME;
boolean DATA_SAVELOCKED = false;

int GAME_MODE = 0; // ゲームモード 
int GAME_width, GAME_height; // width, heightを置換する可能性があるためこの値を使う
boolean GAME_isTalkFinished = false; // チュートリアルが終わっているかどうか
boolean GAME_isAlert = false; // アラートが表示されているかどうか
String GAME_alertText = ""; // アラートテキスト
int GAME_alertTime = 0; // アラートの時間
int GAME_clock = millis(); // ゲーム内の時計

int GAME_fpsIndex = 2; // FPSのインデックス
int GAME_fps[] = {10, 30, 60, 90, 120, 240, 990}; // FPSの設定値

void boot() { // 初期化用の関数
  // initailize
  GAME_width = width;
  GAME_height = height;
  FPS_data = new FPS();
  CP = new ControlP5(this);
  Button = new ButtonClass();
  noStroke();
  // fonts
  println("[setup]   fonts をロードしています");
  fontXl = createFont("HGS創英ﾌﾟﾚｾﾞﾝｽEB", GAME_width / 20);
  fontLg = createFont("HGS創英ﾌﾟﾚｾﾞﾝｽEB", GAME_width / 40);
  fontMd = createFont("HGS創英ﾌﾟﾚｾﾞﾝｽEB", GAME_width / 50);
  fontSm = createFont("HGS創英ﾌﾟﾚｾﾞﾝｽEB", GAME_width / 80);
  fontMono = createFont("Monospaced.plain", GAME_width / 80);
  VP_fontScore = createFont("Meiryo UI", GAME_width / 22);
  VP_fontScoreMd = createFont("Meiryo UI", GAME_width / 50);
  SH_fontTitle = createFont("src/fonts/glitch.otf", GAME_width / 10);
  // bgm
  println("[setup]   sounds/bgm をロードしています");
  bgm1 = new SoundFile(this, "src/sounds/bgm/Haiko.mp3");
  // bgm2 = new SoundFile(this, "src/sounds/bgm/battle/3_流幻.mp3"); //TODO: bgmどれにしよう
  bgm2 = new SoundFile(this, "src/sounds/bgm/battle/ビーボルト.mp3");
  bgm5 = new SoundFile(this, "src/sounds/bgm/Flutter.mp3");
  bgm6 = new SoundFile(this, "src/sounds/bgm/Kaigiencho.mp3");
  // jsonデータを取得
  println("[setup]   config.json をロードしています");
  json = loadJSONObject("config.json");
  if (json == null) {
    DATA_SAVELOCKED = true;
    println("[json]    config.json does not exist\nサーバー情報が記録されたconfig.jsonが必要です\nこのファイルを誤って削除してしまった場合は、制作者にお問い合わせください");
    exit();
  } else {
    DATA_USERNAME = json.getString("username");
    DATA_ENERGY = json.getDouble("energy");
    NET_SERVER_HOST = json.getString("server");
    println("[json]    username: " + DATA_USERNAME + "\n          energy: " + DATA_ENERGY + "\n          server: " + NET_SERVER_HOST);
    if (NET_isNetworkEnable) {
      println("[WSocket] サーバーに接続しています");
      NET_CLIENT = new WebsocketClient(this, NET_SERVER_HOST);
      println("[WSocket] サーバーに接続しました: " + NET_SERVER_HOST);
    } else {
      println("[WSocket] サーバーは設定により無効化されています");
    }
    println("[GENERAL] スクリーンサイズ: " + GAME_width + "x" + GAME_height + " (どのようなサイズでも遊べるように最適化されています)");
    println("[GENERAL] ロード完了　ゲームを開始します");
    // cmode(1); // ホーム画面へ遷移
    cmode(3); //TODO:デバッグ用に変更してます
  }
}

void se(String _path) {
  SoundFile se = new SoundFile(this, "src/sounds/se/" + _path + ".mp3");
  se.play();
}

void save() { // jsonデータを保存
  if (!DATA_SAVELOCKED) {
    double _t = DATA_ENERGY += SB_lastEnergy;
    if (_t < 0) {
      println("累計エネルギーオーバーフロー、変更を保存しません");
      _t = 0;
      DATA_ENERGY = 0;
    }
    if(isOutOfRange(_t)) {
      _t = DATA_ENERGY;
      println("累計エネルギーオーバーフロー、変更を保存しません");
      GAME_isAlert = true;
      GAME_alertText = "エネルギーがオーバーフローしました\n追加のエネルギーを破棄しました\nこれ以上ゲームをインフレさせることはできません\nありがとうございました";
    } else {
      json = new JSONObject();
      json.setString("username", DATA_USERNAME);
      json.setFloat("energy", (float)_t);
      json.setString("server", NET_SERVER_HOST);
      saveJSONObject(json, "config.json");
      println("[json]    config.json saved");
    }
  } else {
    println("[setup]   config.json does not exist");
  }
}

boolean isOutOfRange(double value) {
  println(value);
  println(3.2e38);
  double _max = 3.2e38;
  return value > _max;
}

void navbar(String _left, String _Right) {
  if (_left == "") _left = "Shift+(1 : HOME　2 : PvE　3 : STATUS　4 : FIGHT　 5 : PvP　6 : Talk　7 : Worldmap)　↑ : FPS+　↓ : FPS-　ESC : QUIT　";
  fill(0);
  rect(0, GAME_height - GAME_width / 50, GAME_width, GAME_width / 50);
  fill(255);
  textAlign(LEFT,CENTER);
  textFont(fontSm);
  text(_left, 5, GAME_height - GAME_width / 100);
  textAlign(RIGHT,CENTER);
  text(_Right, GAME_width - 5, GAME_height - GAME_width / 100);
  textAlign(CENTER,CENTER);
}

void actions(String _title) {
  noStroke();
  fill(0, 30, 50, 200);
  rect(0, 0, 600, 90);
  triangle(600, 0, 600, 90, 650, 0);
  fill(255);
  textAlign(LEFT,CENTER);
  textFont(fontLg);
  text(_title, 50, 45);
}

void alert() {
  if (GAME_isAlert) {
    GAME_alertTime++;
    fill(0, 30, 50, 200);
    rect(GAME_width / 4, GAME_height / 4, GAME_width / 2, GAME_height / 2);
    fill(255);
    textAlign(CENTER,CENTER);
    textFont(fontMd);
    text(GAME_alertText, GAME_width / 2, GAME_height / 2);
    if (GAME_alertTime > (3 * GAME_fps[GAME_fpsIndex])) {
      GAME_isAlert = false;
      GAME_alertTime = 0;
    }
  }
}
