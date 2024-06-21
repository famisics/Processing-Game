// 全体で参照する関数や変数の定義

// ライブラリ, クラス
SoundFile se, bgm1, bgm2, bgm3, bgm5; // サウンドファイル
FPS FPS_data; // FPSカウンター
PImage image1, image2, image3, image4; // 画像ファイル
PFont fontXl, fontLg, fontMd, fontMdsm, fontSm, fontMono, VP_fontScore, VP_fontScoreMd, SH_fontTitle, SC_fontChannel, ST_fontTutorial; // フォント
JSONObject json; // JSONデータ

// Network
WebsocketClient NET_client; // Websocketクライアント
String NET_channel = "";

// JSONデータ
double DATA_ENERGY; // エネルギー
String DATA_USERNAME; // ユーザー名
boolean DATA_SAVELOCKED = false; // セーブがロックされているかどうか
boolean DATA_isTutorialFinished = false; // チュートリアルが終わっているかどうか
boolean DATA_isOutOfRange = false; // エネルギーが限界に達したかどうか

// ゲーム共通変数
int GAME_MODE = 0; // ゲームモード 
int GAME_width, GAME_height; // width, heightを置換する可能性があるためこの値を使う
boolean GAME_isAlert = false; // アラートが表示されているかどうか
String GAME_alertText = ""; // アラートテキスト
int GAME_alertTime = 0; // アラートの時間
int GAME_clock = millis(); // ゲーム内の時計
int GAME_fpsIndex = 2; // FPSのインデックス
int GAME_fps[] = {10, 30, 60, 90, 120, 240, 990}; // FPSの設定値

// 数詞データ
String[] jpUnit = {"", "万", "億", "兆", "京", "垓", "秭", "穣", "溝", "澗", "正"}; // doubleToJp用の数詞 (澗まで使う)
int[] jpUnitRank = {0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40}; // doubleToJp用

void boot() { // 初期化用の関数
  // initailize
  GAME_width = width;
  GAME_height = height;
  FPS_data = new FPS();
  // fonts
  println("[setup]   fonts is loading");
  fontXl = createFont("HGS創英ﾌﾟﾚｾﾞﾝｽEB", GAME_width / 20);
  fontLg = createFont("HGS創英ﾌﾟﾚｾﾞﾝｽEB", GAME_width / 40);
  fontMd = createFont("HGS創英ﾌﾟﾚｾﾞﾝｽEB", GAME_width / 50);
  fontMdsm = createFont("HGS創英ﾌﾟﾚｾﾞﾝｽEB", GAME_width / 60);
  fontSm = createFont("HGS創英ﾌﾟﾚｾﾞﾝｽEB", GAME_width / 80);
  fontMono = createFont("Monospaced.plain", GAME_width / 80);
  VP_fontScore = createFont("Meiryo UI", GAME_width / 22);
  VP_fontScoreMd = createFont("Meiryo UI", GAME_width / 50);
  SH_fontTitle = createFont("src/fonts/glitch.otf", GAME_width / 10);
  SC_fontChannel = createFont("src/fonts/jetbrains.ttf", GAME_width / 15);
  ST_fontTutorial = createFont("游ゴシック Bold", GAME_width / 30);
  // bgm
  println("[setup]   sounds/bgm is loading");
  bgm1 = new SoundFile(this, "src/sounds/bgm/haiko.mp3");
  bgm2 = new SoundFile(this, "src/sounds/bgm/bi-boruto.mp3");
  bgm3 = new SoundFile(this, "src/sounds/bgm/new-morning.mp3");
  bgm5 = new SoundFile(this, "src/sounds/bgm/flutter.mp3");
  // jsonデータを取得
  println("[setup]   config.json is loading");
  json = loadJSONObject("src/config.json");
  if (json == null) {
    DATA_SAVELOCKED = true;
    println("[json]    config.json does not exist\nサーバー情報が記録されたconfig.jsonが必要です\nこのファイルを誤って削除してしまった場合は、制作者にお問い合わせください");
    exit();
  } else {
    DATA_USERNAME = json.getString("username");
    DATA_ENERGY = json.getDouble("energy"); 
    DATA_isTutorialFinished = json.getBoolean("isTutorialFinished"); 
    DATA_isOutOfRange = json.getBoolean("isOutOfRange"); 
    println("[json]    username: " + DATA_USERNAME + "\n          energy: " + DATA_ENERGY);
    if (NET_isNetworkEnable) {
      println("[WSocket] connecting");
      NET_client = new WebsocketClient(this, "ws://localhost:" + String.valueOf(NET_SERVER_PORT) + "/");
      println("[WSocket] connected: ws://localhost:" + String.valueOf(NET_SERVER_PORT) + "/");
    } else {
      println("[WSocket] ws disabled by user settings");
    }
    println("[GENERAL] screen size: " + GAME_width + "x" + GAME_height + " (Interface will adjust automatically)");
    println("[GENERAL] initialized, starting game");
    cmode(1);
  }
}

void se(String _path) {
  SoundFile se = new SoundFile(this, "src/sounds/se/" + _path + ".mp3");
  se.play();
}

void save() { // jsonデータを保存
  if (!DATA_SAVELOCKED) {
    double _t = DATA_ENERGY + SB_lastEnergy;
    _t = Math.floor(_t);
    DATA_ENERGY = Math.floor(DATA_ENERGY);
    if (_t < 0) {
      println("[save] energy overflow! it may not be saved");
      _t = 0;
      DATA_ENERGY = 0;
    }
    if (isOutOfRange(_t)) {
      DATA_isOutOfRange = true;
      _t = DATA_ENERGY;
      println("[save] energy overflow! it may not be saved");
      GAME_isAlert = true;
      GAME_alertText = "エネルギーが限界に到達し、地球が再生されました\n今回獲得したエネルギーは破棄されます\nこれ以上ゲームをインフレさせることはできません\n\nここまで遊んでいただきありがとうございました\n\nあなたをこのゲームのクリア者として認めます";
    } else {
      DATA_isOutOfRange = false;
    }
    json = new JSONObject();
    json.setString("username", DATA_USERNAME);
    json.setFloat("energy",(float)_t);
    json.setBoolean("isTutorialFinished", DATA_isTutorialFinished);
    json.setBoolean("isOutOfRange", DATA_isOutOfRange);
    saveJSONObject(json, "src/config.json");
    println("[json]    config.json saved");
  } else {
    println("[setup]   config.json does not exist");
  }
}

boolean isOutOfRange(double value) {
  double _max = 3.2e38;
  return value > _max;
}

String doubleToJp(double value) {
  if (value == 0) return "0";
  StringBuilder _sb = new StringBuilder();
  int _i = jpUnit.length - 1;
  int _count = 0;
  while(_i >= 0 && _count < 2) {
    double _v = pow(10, jpUnitRank[_i]);
    long _current = (long)(value / _v);
    value = value % _v;
    if (_current > 0) {
      _sb.append(_current);
      _sb.append(jpUnit[_i]);
      _count++;
    }
    _i--;
  }
  return _sb.toString();
}


void navbar(String _left, String _Right) {
  if (_left == "") _left = "Shift+(1 : HOME　2 : Block　3 : Channel　4 : Start　 5 : Result　6 : Tutorial　7 : Username)　↑ : FPS+　↓ : FPS-　ESC : QUIT　";
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
  rect(0, 0, GAME_width / 2, GAME_height / 8);
  triangle(GAME_width / 2, 0, GAME_width / 2, GAME_height / 8, GAME_width / 2 + GAME_width / 10, 0);
  fill(255);
  textAlign(LEFT,CENTER);
  textFont(fontXl);
  text(_title, GAME_width / 20, GAME_height / 16);
}

void alert() {
  if (GAME_isAlert) {
    GAME_alertTime++;
    stroke(255);
    fill(0, 0, 0, 220);
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
  noStroke();
}
