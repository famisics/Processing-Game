// 全体で参照する関数や変数の定義

ControlP5 CP; // ControlP5ライブラリ
SoundFile se, bgm1, bgm2, bgm3, bgm4, bgm5, bgm6; // サウンドファイル
FPS FPS_data; // FPSカウンター
PImage image1, image2, image3, image4; // 画像ファイル
PFont fontXl, fontLg, fontMd, fontSm, fontMono; // フォント
JSONObject json; // JSONデータ

WebsocketClient NET_CLIENT; // Websocketクライアント
String NET_SERVER_HOST; // Proxyサーバーのホスト名

// JSONデータ
int DATA_ENERGY;
String DATA_USERNAME;
boolean DATA_SAVELOCKED = false;

int GAME_MODE = 0; // ゲームモード 
int GAME_width, GAME_height; // width, heightを置換する可能性があるためこの値を使う
boolean GAME_isTalkFinished = false; // チュートリアルが終わっているかどうか

void boot() { // 初期化用の関数
  // initailize
  GAME_width = width;
  GAME_height = height;
  noStroke();
  // fonts
  println("[setup]   fonts をロードしています");
  fontXl = createFont("HGS創英ﾌﾟﾚｾﾞﾝｽEB", GAME_width / 20);
  fontLg = createFont("HGS創英ﾌﾟﾚｾﾞﾝｽEB", GAME_width / 40);
  fontMd = createFont("HGS創英ﾌﾟﾚｾﾞﾝｽEB", GAME_width / 50);
  fontSm = createFont("HGS創英ﾌﾟﾚｾﾞﾝｽEB", GAME_width / 80);
  fontMono = createFont("Monospaced.plain", GAME_width / 80);
  // lib
  FPS_data = new FPS();
  CP = new ControlP5(this);
  // vs
  VS_boot();
  // bgm
  println("[setup]   sounds/bgm をロードしています");
  bgm1 = new SoundFile(this, "src/sounds/bgm/Haiko.mp3");
  bgm2 = new SoundFile(this, "src/sounds/bgm/battle/3_流幻.mp3");
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
    DATA_ENERGY = json.getInt("energy");
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
    cmode(2); //TODO:デバッグ用に変更してます
  }
}

void se(String _path) {
  SoundFile se = new SoundFile(this, "src/sounds/se/" + _path + ".mp3");
  se.play();
}

void save() { // jsonデータを保存
  if (!DATA_SAVELOCKED) {
    DATA_ENERGY += SB_lastEnergy;
    json = new JSONObject();
    json.setString("username", DATA_USERNAME);
    json.setInt("energy", DATA_ENERGY);
    json.setString("server", NET_SERVER_HOST);
    saveJSONObject(json, "config.json");
    println("[json]    config.json saved");
  } else {
    println("[setup]   config.json does not exist");
  }
}

void navbar(String _left, String _Right) {
  if (_left == "") _left = "1 : HOME　2 : PvE　3 : STATUS　4 : FIGHT　 5 : PvP　6 : Talk　7 : Worldmap　ESC : QUIT";
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
  fill(0, 30, 50, 200);
  rect(0, 0, 600, 90);
  triangle(600, 0, 600, 90, 650, 0);
  fill(255);
  textAlign(LEFT,CENTER);
  textFont(fontLg);
  text(_title, 50, 45);
}
