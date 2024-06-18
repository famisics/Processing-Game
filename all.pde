// メイン

import java.util.Iterator;
import processing.sound.*;
import websockets.*;

int NET_SERVER_PORT = 8001; // Proxyサーバーのホスト名
boolean NET_isNetworkEnable = true; // ネットワーク機能を有効にするには true を代入する
// !Proxyサーバーが起動していないにも関わらず、trueになっているとゲームがフリーズします

// void settings() {
//   fullScreen();
// }
// TODO:フルスクリーンの状態でビルドする

void setup() {
  background(0);
  println("[GENERAL] ゲームを初期化しています");
  se = new SoundFile(this, "src/sounds/mute.mp3");
  size(1200, 800); // デバッグ用の解像度
  frameRate(60);
  textAlign(CENTER,CENTER);
  background(0);
  boot();
}

void draw() { // !画面遷移(常に実行)
  switch(GAME_MODE) {
    case 1 : // home
      SH_update();
      break;
    case 2 : // block
      SB_update();
      break;
    case 3 : // channel
      SC_update();
      break;
    case 4 : // start
      SS_update();
      break;
    case 5 : // result
      SR_update();
      break;
    case 6 : // talk
      ST_update();
      break;
    case 7 : // username
      SU_update();
      break;
    default :
    break;
  }
  FPS_data.update();
  GAME_clock = millis();
  alert();
}

void cmode(int _mode) { // !画面遷移(1回だけ実行)
  GAME_MODE = _mode;
  save();
  switch(_mode) {
    case 1 : // home
      if (bgm2.isPlaying()) bgm2.stop();
      if (bgm3.isPlaying()) bgm3.stop();
      if (bgm5.isPlaying()) bgm5.stop();
      println("[SCENE1]  Home");
      if (!bgm1.isPlaying()) bgm1.loop();
      // background(0); // 画面を暗くしてから描画, 今は無効
      SH_boot();
      break;
    case 2 : // block
      if (bgm1.isPlaying()) bgm1.stop();
      if (bgm3.isPlaying()) bgm3.stop();
      if (bgm5.isPlaying()) bgm5.stop();
      println("[SCENE2]  Block");
      switch ((int)random(1, 4)) { // 1-3までランダムにBGMを選択
        case 1 :
          bgm2 = new SoundFile(this, "src/sounds/bgm/tattasoredakenomonogatari.mp3");
          break;
        case 2 :
          bgm2 = new SoundFile(this, "src/sounds/bgm/bi-boruto.mp3");
          break;
        default :
          bgm2 = new SoundFile(this, "src/sounds/bgm/ryugen.mp3");
          break;
      }
      bgm2.loop();
      bgm2.pause();
      SB_boot();
      break;
    case 3 : // channel
      if (bgm1.isPlaying()) bgm1.stop();
      if (bgm2.isPlaying()) bgm2.stop();
      if (bgm5.isPlaying()) bgm5.stop();
      println("[SCENE3]  Channel");
      if (!bgm3.isPlaying()) bgm3.loop();
      SC_boot();
      break;
    case 4 : // start
      if (bgm1.isPlaying()) bgm1.stop();
      if (bgm2.isPlaying()) bgm2.stop();
      if (bgm5.isPlaying()) bgm5.stop();
      println("[SCENE4]  Start");
      if (!bgm3.isPlaying()) bgm3.loop();
      SS_boot();
      break;
    case 5 : // result
      if (bgm1.isPlaying()) bgm1.stop();
      if (bgm3.isPlaying()) bgm3.stop();
      if (bgm2.isPlaying()) bgm2.stop();
      println("[SCENE5]  Result");
      bgm5.loop();
      SR_boot();
      break;
    case 6 : // talk
      if (bgm2.isPlaying()) bgm2.stop();
      if (bgm3.isPlaying()) bgm3.stop();
      if (bgm5.isPlaying()) bgm5.stop();
      println("[SCENE6]  Talk");
      if (!bgm1.isPlaying()) bgm1.loop();
      ST_boot();
      break;
    case 7 : // username
      if (bgm1.isPlaying()) bgm1.stop();
      if (bgm2.isPlaying()) bgm2.stop();
      if (bgm5.isPlaying()) bgm5.stop();
      println("[SCENE7]  Username");
      if (!bgm3.isPlaying()) bgm3.loop();
      SU_boot();
      break;
    default :
    break;
  }
}

void dispose() {
  save();
  println("[GENERAL] ゲームが停止しました\n");
  if (!DATA_SAVELOCKED) {
    println("> あなたの累計獲得エネルギー: " + String.valueOf(DATA_ENERGY) + " (保存されました)\n\n########  ##   ##  #######  ###  ##  ##   ##          ##   ##  #######  ##   ##\n   ##     ##   ##  ##   ##  ###  ##  ##  ##           ##   ##  ##   ##  ##   ##\n   ##     #######  #######  ## ####  #####            #######  ##   ##  ##   ##\n   ##     ##   ##  ##   ##  ##  ###  ##  ##                ##  ##   ##  ##   ##\n   ##     ##   ##  ##   ##  ##   ##  ##   ##          #######  #######  #######");
  }
}
// 入力を受け付ける

void keyPressed() { // キー入力
  // *ローカル
  switch(GAME_MODE) { // ゲームモード限定の処理
    case 1 : // Home
      if (keyCode == 32 && !GAME_isTalkFinished) { // SPACE, 一時停止
        cmode(6);
      } else if (keyCode == 32 && GAME_isTalkFinished) { // SPACE, チャンネル選択へ
        cmode(3);
      }
      if (keyCode == ENTER) cmode(3); // ENTER, チャンネル選択へ //!デモ用
      if (key == 'n') cmode(7); // ユーザー名変更 //!デモ用
      if (key == 't') cmode(6); // チュートリアル //!デモ用
      if (key == 'c') cmode(3); // チャンネル選択へ //!デモ用
      break;
    case 2 : // Block
      if (key == '1') VS_skillRegister("1", DATA_USERNAME);
      if (key == '2') VS_skillRegister("2", DATA_USERNAME);
      if (key == '3') VS_skillRegister("3", DATA_USERNAME);
      if (key == '4') VS_skillRegister("4", DATA_USERNAME);
      if (key == '5') VS_skillRegister("5", DATA_USERNAME);
      if (key == '6') VS_skillRegister("6", DATA_USERNAME);
      if (key == '7') VS_skillRegister("7", DATA_USERNAME);
      if (key == '8') VS_skillRegister("8", DATA_USERNAME);
      if (key == '9') VS_skillRegister("9", DATA_USERNAME);
      if (key == '0') VS_skillRegister("0", DATA_USERNAME);
      if (key == 'i') SB_inflationRateTemporary *= 2; // インフレ倍率をあげる(2倍) //!デモ用
      if (key == 'l') cmode(2); // リセット //!デモ用
      if (key == 'p') SB_pause(); // SPACE, ポーズ //!デモ用
      break;
    case 3 : // Channel
      if ((keyCode >= 48 && keyCode <= 57) || (keyCode >= 65 && keyCode <= 90) || (keyCode >= 96 && keyCode <= 105)) SC_input(str(key)); // 入力
      if (keyCode == DELETE) SC_input("del"); // DELETE, 全字削除
      if (keyCode == BACKSPACE) SC_input("bs"); // BACKSPACE, 一字削除
      if (keyCode == ENTER) SC_input("enter"); // ENTER, 確定
      break;
    case 4 : // Start
      if (keyCode == 32 && !SS_isSpace) { // ENTER, ゲーム開始, 3秒以上長押しで実行, 時間の判定ロジックはscene4にあります
        SS_isSpace = true;
        SS_startTime = GAME_clock;
      }
      break;
    case 5 : // Result
      if (keyCode == 32) cmode(1); // SPACE, 復帰
      break;
    case 6 : // Tutorial
      if (keyCode == LEFT) ST_ScriptPrev(); // シナリオ戻し
      if (keyCode == RIGHT) ST_ScriptNext(); // シナリオ進め
      if (keyCode == 32) ST_ScriptNext(); // SPACE, シナリオ進め
      if (keyCode == ENTER) ST_ScriptNext(); // ENTER, シナリオ進め
      if (key == 'f') ST_ScriptNext(); // f, シナリオ進め
      break;
    case 7 : // Username
      if ((keyCode >= 48 && keyCode <= 57) || (keyCode >= 65 && keyCode <= 90) || (keyCode >= 96 && keyCode <= 105)) SU_input(str(key)); // 入力
      if (keyCode == DELETE) SU_input("del"); // DELETE, 全字削除
      if (keyCode == BACKSPACE) SU_input("bs"); // BACKSPACE, 一字削除
      if (keyCode == ENTER) SU_input("enter"); // ENTER, 確定
      break;
    case 8 : // 暗転
      if (keyCode == 32) cmode(1); // SPACE, 復帰
      break;
    default:
    break;
  }
  // *グローバル
  if (keyCode == 27) { // ESCキー
    
    if (GAME_MODE == 1) {
      exit();
    } else if (GAME_MODE == 4) {
      cmode(3);
      key = 0;
    } else {
      cmode(1);
      key = 0;
    }
  }
  if (keyCode == UP) cfps(true);
  if (keyCode == DOWN) cfps(false);
  // モード切り替え //!(デモ用)
  if (keyEvent.isShiftDown()) {
    // 0のキーコードは48(参考)
    if (keyCode == 49) cmode(1);
    if (keyCode == 50) cmode(2);
    if (keyCode == 51) cmode(3);
    if (keyCode == 52) cmode(4);
    if (keyCode == 53) cmode(5);
    if (keyCode == 54) cmode(6);
    if (keyCode == 55) cmode(7);
  }
}

void keyReleased() {
  if (GAME_MODE == 4 && keyCode == 32) SS_isSpace = false;
}

void cfps(boolean _isUp) { // FPS変更
  if (_isUp) {
    GAME_fpsIndex++;
  } else {
    GAME_fpsIndex--;
  }
  if (GAME_fpsIndex < 0) GAME_fpsIndex = 0;
  if (GAME_fpsIndex > 6) GAME_fpsIndex = 6;
  switch(GAME_fpsIndex) {
    case 0:
      frameRate(10);
      println("[fps] 10");
      break;
    case 1:
      frameRate(30);
      println("[fps] 30");
      break;
    case 2:
      frameRate(60);
      println("[fps] 60");
      break;
    case 3:
      frameRate(90);
      println("[fps] 90");
      break;
    case 4:
      frameRate(120);
      println("[fps] 120");
      break;
    case 5:
      frameRate(240);
      println("[fps] 240");
      break;
    case 6:
      frameRate(999);
      println("[fps] unlimited");
      break;
    default:
    break;
  }
}
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
double DATA_ENERGY;
String DATA_USERNAME;
boolean DATA_SAVELOCKED = false;

// ゲーム共通変数
int GAME_MODE = 0; // ゲームモード 
int GAME_width, GAME_height; // width, heightを置換する可能性があるためこの値を使う
boolean GAME_isTalkFinished = false; // チュートリアルが終わっているかどうか
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
  noStroke();
  // fonts
  println("[setup]   fonts をロードしています");
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
  println("[setup]   sounds/bgm をロードしています");
  bgm1 = new SoundFile(this, "src/sounds/bgm/haiko.mp3");
  bgm2 = new SoundFile(this, "src/sounds/bgm/bi-boruto.mp3");
  bgm3 = new SoundFile(this, "src/sounds/bgm/new-morning.mp3");
  bgm5 = new SoundFile(this, "src/sounds/bgm/flutter.mp3");
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
    println("[json]    username: " + DATA_USERNAME + "\n          energy: " + DATA_ENERGY);
    if (NET_isNetworkEnable) {
      println("[WSocket] サーバーに接続しています");
      NET_client = new WebsocketClient(this, "ws://localhost:" + String.valueOf(NET_SERVER_PORT) + "/");
      println("[WSocket] サーバーに接続しました: ws://localhost:" + String.valueOf(NET_SERVER_PORT) + "/");
    } else {
      println("[WSocket] サーバーは設定により無効化されています");
    }
    println("[GENERAL] スクリーンサイズ: " + GAME_width + "x" + GAME_height + " (どのようなサイズでも遊べるように最適化されています)");
    println("[GENERAL] ロード完了　ゲームを開始します");
    cmode(1);
  }
}

void se(String _path) {
  SoundFile se = new SoundFile(this, "src/sounds/se/" + _path + ".mp3");
  se.play();
}

void save() { // jsonデータを保存
  if (!DATA_SAVELOCKED) {
    double _t = DATA_ENERGY += SB_lastEnergy;
    _t = Math.floor(_t);
    DATA_ENERGY = Math.floor(DATA_ENERGY);
    if (_t < 0) {
      println("累計エネルギーオーバーフロー、変更を保存しません");
      _t = 0;
      DATA_ENERGY = 0;
    }
    if (isOutOfRange(_t)) {
      _t = DATA_ENERGY;
      println("累計エネルギーオーバーフロー、変更を保存しません");
      GAME_isAlert = true;
      GAME_alertText = "累計獲得エネルギーが限界に到達しました\n今回獲得したエネルギーは破棄されます\nこれ以上ゲームをインフレさせることはできません\n\nここまで遊んでいただきありがとうございました\n\nあなたをこのゲームのクリア者として認めます";
    } else {
      json = new JSONObject();
      json.setString("username", DATA_USERNAME);
      json.setFloat("energy",(float)_t);
      saveJSONObject(json, "config.json");
      println("[json]    config.json saved");
    }
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
  noStroke();
  fill(0, 30, 50, 200);
  rect(0, 0, GAME_width / 2, GAME_height / 8);
  triangle(GAME_width / 2, 0, GAME_width / 2, GAME_height / 8, GAME_width / 2 + GAME_width / 10, 0);
  fill(255);
  textAlign(LEFT,CENTER);
  textFont(fontXl);
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
// WebSocket通信制御

// 他クライアントからの受信イベントを処理
void NET_recv(String i) {
  String[] _data = split(i, ","); // データ構造 : [0] = イベント名, [1] = データ, [2] = 送信先チャンネル, [3] = ユーザーネーム
  if (_data[2].equals(NET_channel)) {
    switch(_data[0]) {
      case "skill" :
        println("[WS:skill] " + _data[3] + "がスキルID" + _data[1] + "を発動しました");
        VS_skillRegister(_data[1], _data[3]);
        break;
      case "join" :
        println("[WS:join] " + _data[3] + "がチャンネル" + _data[2] + "に参加しました");
        SS_message(_data[3] + "がチャンネル" + NET_channel + "に参加しました");
        break;
      case "score" : // TODO:リアルタイムスコアの同期
        println("[WS:join] " + _data[3] + "がチャンネル" + _data[2] + "で" + _data[1] + "エネルギーを獲得しています");
        VP_scoreRecv(_data[1], _data[3]);
        break;
      case "start" :
        println("[WS:start] " + _data[3] + "がチャンネル" + _data[2] + "のゲームを開始します！");
        SB_startMessageText = _data[3] + "がチャンネル" + _data[2] + "のゲームを開始します！";
        cmode(2);
        break;
      default :
      println("[WS:RECV] (" + i + ")は規定外のデータであるため破棄されました");
      break;
    }
  } else {
    println("[WS:RECV] (" + i + ")はチャンネルが異なるため破棄されました");
  }
}

// websocketの送信イベント
void NET_send(String _event, String _data) { // データ構造 : イベント名,データ
  String _token = _event + "," + _data + "," + NET_channel + "," + DATA_USERNAME; // ユーザーネームと送信先チャンネルを付加
  if (NET_isNetworkEnable) {
    NET_client.sendMessage(_token);
    println("[WS:SEND] (" + _token + ")を送信中");
  } else {
    println("[WS:SEND] ネットワークが無効になっています");
    
  }
}

// websocketの受信イベント
void webSocketEvent(String i) {
  String[] _data = split(i, ":");
  switch(_data[0]) {
    case "SUCCESS" :
      println("[WS:SEND] (" + _data[1] + ")の送信に成功しました");
      break;
    case "DELIVER" :
      println("[WS:RECV] (" + _data[1] + ")を受信しました");
      NET_recv(_data[1]);
      default :
      println("[WS:RECV] (" + i + ")は規定外のデータであるため破棄されました");
      break;
  }
}
// ホーム

float SH_alpha = 0; // 透明度の初期値
float SH_fontSize = 200; // フォントサイズの初期値
float SH_targetFontSize = 30; // 最終的なフォントサイズ
float SH_easing = 0.12; // イージングの係数

void SH_boot() {
  background(0);
  image1 = loadImage("src/images/home.png");
  SH_fontSize = GAME_width / 5;
  SH_targetFontSize = GAME_width / 10;
}
void SH_update() {
  SH_titleAnime();
  tint(100, 100);
  image(image1, 0, 0, GAME_width, GAME_height);
  noTint();
  textAlign(CENTER,CENTER);
  textFont(SH_fontTitle);
  textSize(SH_fontSize);
  fill(255, 0, 0, SH_alpha);
  text("地球再生計画", GAME_width / 2 + 10, GAME_height / 2 - (GAME_height / 6) + 10);
  fill(255, SH_alpha);
  text("地球再生計画", GAME_width / 2, GAME_height / 2 - (GAME_height / 6));
  fill(255);
  textFont(fontLg);
  text("スペースキーを押してください", GAME_width / 2, GAME_height / 2 + (GAME_height / 6));
  textAlign(LEFT);
  text("ユーザー名 : " + DATA_USERNAME + " (nキーを押して変更)\n累計獲得エネルギー : " + doubleToJp(DATA_ENERGY), GAME_height / 10, GAME_height / 10);
  textFont(fontSm);
  fill(0, 255, 255);
  text("[デモが有効になっています] 以下のキーコンフィグが有効です\n\nホーム> SPACE : ゲームを開始/チュートリアル(自動選択)　Enter : ゲームを開始　n : ユーザー名変更　t : チュートリアルを見る　c : ゲームを開始\n\n全てのシーン>　Shift+(1 : HOME　2 : Block　3 : Channel　4 : Start　 5 : Result　6 : Tutorial　7 : Username)　↑ : FPS+　↓ : FPS-　ESC : QUIT\n\nブロック崩し>　I : エネルギー倍率を増加　L : リスタート　P : ポーズ", GAME_width / 20, GAME_height * 3 / 4);
  rectMode(CORNER);
  navbar("","2024 (C) b1024251 Takumi Yamazaki");
}
void SH_titleAnime() { // タイトルのアニメーション
  if (SH_alpha < 255) {
    float _dalpha = (255 - SH_alpha) * SH_easing;
    SH_alpha += _dalpha;
    if (SH_alpha > 255) {
      SH_alpha = 255;
    }
  }
  if (SH_fontSize > SH_targetFontSize) {
    float _dFontSize = (SH_targetFontSize - SH_fontSize) * SH_easing;
    SH_fontSize += _dFontSize;
    if (SH_fontSize < SH_targetFontSize) {
      SH_fontSize = SH_targetFontSize;
    }
  }
}
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
String SC_channelDisplay = "";
boolean SC_channelFlag = true;

void SC_boot() {
  NET_channel = "";
  SC_channelDisplay = "-";
  SC_channelFlag = true;
  noTint();
  image1 = loadImage("src/images/night.png");
  if (DATA_USERNAME.equals("")) {
    cmode(7);
  }
}
void SC_update() {
  image(image1, 0, 0, GAME_width, GAME_height);
  textAlign(CENTER, CENTER);
  fill(100, 255, 200);
  textFont(SC_fontChannel);
  text(SC_channelDisplay, GAME_width / 2, GAME_height / 2);
  fill(255);
  textFont(fontMd);
  text("12文字までのチャンネル名を入力し、Enterしてください\nわかりやすいので4桁の数字か英単語をおすすめします\n\nESC : トップに戻る　Backspace : 1字消し　Delete : 全字消し　Enter : 確定", GAME_width / 2, GAME_height * 3 / 4);
  actions("ゲームを開始");
  navbar("ESC : トップに戻る　Backspace : 1字消し　Delete : 全字消し　Enter : 確定","");
}

void SC_input(String _key) {
  if (_key.equals("bs")) {
    if (NET_channel.length() > 0) {
      NET_channel = NET_channel.substring(0, NET_channel.length() - 1);
    }
  } else if (_key.equals("del")) {
    NET_channel = "";
  } else if (_key.equals("enter")) {
    if (NET_channel.length()>0) {
      NET_send("join", NET_channel);
      cmode(4);
    } else {
      return;
    }
  } else {
    if (NET_channel.length() < 12) NET_channel += _key;
  }
  if (NET_channel == "") {
    SC_channelFlag = true;
  } else {
    SC_channelFlag = false;
    SC_channelDisplay = NET_channel;
  }
  if (SC_channelFlag) {
    SC_channelDisplay = "-";
    NET_channel = "";
  }
}
// ゲーム開始画面

int SS_startTime = 0; // SPACEを押し始めた時間
boolean SS_isSpace = false; // SPACEを押しているかどうか

boolean SS_isMessage = false; // メッセージが表示されているかどうか
String SS_messageText = ""; // メッセージテキスト
int SS_messageTime = 0; // メッセージの時間

void SS_boot() {
  noTint();
  image1 = loadImage("src/images/start.png");
}

void SS_update() {
  image(image1, 0, 0, GAME_width, GAME_height);
  actions("ゲームを開始");
  textAlign(CENTER, CENTER);  
  fill(255);
  textFont(fontLg);
  text("対戦する他のプレイヤーにチャンネル名を伝えてください", GAME_width / 2, GAME_height / 4);
  textFont(SC_fontChannel);
  fill(100, 255, 200);
  text(NET_channel, GAME_width / 2, GAME_height / 2);
  navbar("Enter : チャンネル選択に戻る　SPACE長押し : ゲーム開始","");
  fill(255);
  textFont(fontLg);
  if (SS_isSpace) {
    text("押し続けてください", GAME_width / 2, GAME_height * 3 / 4);
    fill(100, 255, 200);
    rect(0, GAME_height * 19 / 20 - (GAME_width / 50), float(GAME_width) * (float(GAME_clock - SS_startTime) / 1000), GAME_height / 20);
    if (GAME_clock - SS_startTime >= 1000) {
      SS_isSpace = false;
      SB_startMessageText = DATA_USERNAME + "がチャンネル" + NET_channel + "のゲームを開始します！";
      NET_send("start", NET_channel);
      cmode(2);
    }
  } else {
    text("同じチャンネルの誰かがSPACEキーを長押しすると\n全員のゲームが開始されます", GAME_width / 2, GAME_height * 3 / 4);
  }
  SS_messageUpdate();
}
void SS_message(String t) {
  SS_messageText = t;
  SS_messageTime = 0;
  SS_isMessage = true;
}
void SS_messageUpdate() {
  if (SS_isMessage) {
    SS_messageTime++;
    textFont(VP_fontScoreMd);
    fill(255);
    textAlign(LEFT,BOTTOM);
    text(SS_messageText, GAME_width / 50, GAME_height * 9 / 10);
    if (SS_messageTime > (3 * GAME_fps[GAME_fpsIndex])) {
      SS_isMessage = false;
    }
  }
}
// リザルト画面

int SR_plasmaCount = 0;
double SR_displayLastEnergy, SR_plasma = 0;
void SR_boot() {
  background(0);
  fill(255);
  SR_displayLastEnergy = SB_lastEnergy;
  SB_lastEnergy = 0;
  SR_plasma = DATA_ENERGY * 6;
}
void SR_update() {
  tint(50, 50);
  image1 = loadImage("src/images/result.png");
  image(image1, 0, 0, GAME_width, GAME_height);
  // background(100, 0, 100);
  fill(255);
  textAlign(CENTER,CENTER);
  textFont(fontXl);
  text("ゲームが終了しました", GAME_width / 2, GAME_height / 10);
  textFont(VP_fontScoreMd);
  textAlign(LEFT,CENTER);
  text(DATA_USERNAME + "のステータスを表示しています\n\n\n\n今回獲得 エネルギー :\n\n累計獲得 エネルギー :\n\n展開済み エネルギー :\n\n使用可能 エネルギー :\n\n？？？？？？？？？ :\n\nスペースキーを押してトップに戻ります", GAME_width / 4, GAME_height / 2);
  textAlign(RIGHT,CENTER);
  text("\n\n\n\n" + doubleToJp(SR_displayLastEnergy) + "\n\n" + doubleToJp(DATA_ENERGY) + "\n\n" + "0" + "\n\n" + "0\n\n　" + doubleToJp(SR_plasma) + "\n\n　", GAME_width * 3 / 4, GAME_height / 2); // TODO:展開済み、使用可能、？？？？？？？？？は今後追加する
  textAlign(CENTER,CENTER);
  navbar("ESC/SPACE : トップに戻る","");
  SR_calcPlasma();
}
void SR_calcPlasma() {
  if (SR_plasmaCount > 100) {
    SR_plasma *= random(1.01, 2.0);
    SR_plasmaCount = 0;
  } else {
    SR_plasmaCount++;
  }
}
// チュートリアル

String[][] ST_Script = {
  {"地球再生計画へようこそ"} ,
  {"このゲームでは、スキルを駆使して他のプレイヤーと戦ったり、１人で何度もゲームをプレイしすることで、エネルギーという単位をインフレさせます"} ,
  {"地球を凌駕するほどのエネルギー 約320澗(かん) に達したとき、このゲームのクリアとします\n\n≒JSONの限界, 対応している数詞:(万, 億, 兆, 京, 垓, 秭, 穣, 溝, 澗)"} ,
  {"獲得したエネルギーはポイントの倍率に影響します\nエネルギーを貯蔵すればするほどレベルが上がり、エネルギーの獲得効率が上がります"} ,
  // {"エネルギーの獲得効率はゲームの勝敗に影響することはありませんが、実績として表示されます"} ,
  {"画面下部に主要な操作が書かれているので、参考にしてください\nそれでは、さっそくゲームに向かいましょう"}
};

int ST_ScriptIndex = 0;
int ST_AnimationIndex = 0;

void ST_boot() {
  background(0);
  ST_ScriptIndex = 0;
  ST_AnimationIndex = 0;
  image1 = loadImage("src/images/tutorial.png");
  image2 = loadImage("src/images/chara.png");
}
void ST_update() {
  if (ST_AnimationIndex < 10) {
    ST_AnimationIndex++;
    tint(255, 50);
  }
  image(image1, 0, 0, GAME_width, GAME_height);
  noTint();
  image(image2, GAME_width / 2, GAME_height * 1 / 15, GAME_width * 10 / 3 / 9, GAME_width * 10 * 4 / 9 / 9);
  fill(70, 100, 100);
  rect(0, GAME_height * 3 / 5, GAME_width, GAME_height * 2 / 5);
  fill(255);
  textAlign(CENTER,CENTER);
  textFont(ST_fontTutorial);
  text(ST_Script[ST_ScriptIndex][0], 0, GAME_height * 3 / 5 - 25, GAME_width, GAME_height * 2 / 5);
  navbar("SPACE/Enter/f/→ : テキストを進める　← : テキストを戻る","Script: " + str(ST_ScriptIndex));
}
void ST_ScriptNext() {
  if (ST_ScriptIndex < ST_Script.length - 1) {
    ST_ScriptIndex++;
  } else {
    GAME_isTalkFinished = true;
    cmode(3);
  }
}
void ST_ScriptPrev() {
  if (ST_ScriptIndex > 0) { 
    ST_ScriptIndex--;
  }
}
// ボールを表示するクラス

class Ball {
  float _x, _y, _dy, _dx, _size;
  boolean _isHit = false;
  Ball(float _x, float _y, float _dx, float _dy, float _size) {
    this._x = _x;
    this._y = _y;
    this._dx = _dx;
    this._dy = _dy;
    this._size = _size;
  }
  void update() {
    // ブロックとボールの衝突判定
    for (int x = 0; x < 12; x++) {
      for (int y = 0; y < 10; y++) {
        isHit2Block(x, y);
      }
    }
    _isHit = false;
    // バーとボールの衝突判定
    isHit2Bar();
    // 通常の変更処理
    if (SB_isTimeProcessing) {
      // 移動先の当たり判定を確認
      if (_y < _size / 2) _dy *= -1;
      if (_x < _size / 2 || _x + _size / 2 >= SB_blockWindowWidth) _dx *= -1;
      if (BS_isShield) { // シールド
        if (_y + _size / 2 >= GAME_height - (GAME_width / 50)) _dy = abs(_dy) * - 1; // 落下しても削除しない
      } else {
        if (_y >= GAME_height - (GAME_width / 50)) SB_balls.remove(this); // 落下判定
      }
      // 移動
      _x += _dx * SB_gameSpeed;
      _y += _dy * SB_gameSpeed;
    }
    // ボールの描画
    fill(100, 255, 255);
    circle(_x, _y, _size);
  }
  // void division() {
  //   SB_balls.add(new Ball(_x, _y, _dx * 0.8, _dy * - 1, _size));
  // }
  void isHit2Block(int x, int y) {
    if (SB_blocks[y][x] > 0 && !_isHit) { // ブロックが存在するとき
      String _hit = VB_hit(x * SB_blockWindowWidth / 12, y * GAME_height / 20, SB_blockWindowWidth / 12, GAME_height / 20, _x, _y, _size / 2);
      if (!_hit.equals("")) {
        if (_hit == "dx") {
          _isHit = true;
          _dx *= -1;
        } else {
          _isHit = true;
          _dy *= -1;
        }
        SB_blocks[y][x] = SB_blocks[y][x] - 1; // ブロックの値を1減らす
        if (SB_blocks[y][x] == 0) se("pa"); //se
        SB_lastEnergy += (random(100, 150) * SB_inflationRate * SB_inflationRateTemporary); // スコアを増やす
      }
    }
  }
  void isHit2Bar() {
    String _hit = VB_hit(VB_barX, GAME_height - GAME_height / 12, SB_blockWindowWidth * SB_barSize / 240, GAME_height / 20, _x, _y, _size);
    if (!_hit.equals("") && ((GAME_height - GAME_height / 12) < (_y + _size))) {
      if (_hit == "dy") {
        _dx = SB_gameSpeed * (_x - mouseX) / 15;
        _dy = abs(_dy) * - 1;
      }
    }
  }
}
// FPS(フレーム/秒)を表示するクラス

class FPS {
  int _flame;
  long _now;
  double _temp;
  long _start = GAME_clock;
  int _fps = 0;
  void update() {
    _flame++;
    _now = GAME_clock;
    double _time = Math.floor((_now - _start) / 1000);
    if (_time - _temp >= 1) {
      _fps = _flame;
      _flame = 0;
      _temp = _time;
    }
    fill(0, 50, 0);
    if (GAME_fpsIndex < 4) {
      rect(GAME_width - GAME_width / 18, 0, GAME_width / 18, GAME_width / 60);
    } else {
      rect(GAME_width - GAME_width / 15, 0, GAME_width / 15, GAME_width / 60);
    }
    textAlign(RIGHT,CENTER);
    fill(100, 255, 255);
    textFont(fontMono);
    text(_fps + "/" + GAME_fps[GAME_fpsIndex] + "fps", GAME_width - 3, GAME_width / 120);
  }
}
class Skill {
  String _skillId;
  String _skillName;
  String _skillNameJp;
  int _skillStartTime;
  boolean _isDisplayMonitor;
  int _skillDulation;
  String _skillTarget;
  String _skillActer;
  double _skillEnergy;
  
  // カットイン
  boolean _isCutin = false;
  boolean _isCutinSlideIn = true;
  boolean _isCutinSlideOut = false;
  int _cutinTime;
  float _cutinX = GAME_width;
  float _cutinDX = GAME_width / 20;
  int _cutinSizeX = GAME_width / 3;
  int _cutinSizeY = GAME_width / 6;
  PImage _cutinImage = loadImage("src/images/skill/demo.png");
  int _cutinImageMaskRad = GAME_width / 20;
  
  //* _skillData = {id, 発動対象, 継続時間(兼クールタイム), 必要エネルギー, スキルネーム(カットイン画像path), スキル日本語名, スキル日本語説明}
  Skill(String[] _skillData, String _acter, boolean _isDisplayMonitor) {
    this._skillId = _skillData[0];
    this._skillName = _skillData[4]; // 兼カットイン画像URL
    this._skillNameJp = _skillData[5];
    this._skillTarget = _skillData[1];
    this._skillActer = _acter;
    this._isDisplayMonitor = _isDisplayMonitor; // サイドバーの時間表示に表示するかどうか
    this._skillDulation = parseInt(_skillData[2]) * 1000;
    this._skillEnergy = Double.parseDouble(_skillData[3]);
    this._skillStartTime = VS_clock; // スキル時間を取得

    start();
  }
  
  void start() { //TODO: スキル、エフェクト画像の読み込みと表示 image1 = loadImage("hoge.png");
    // 必要エネルギーが足りるかどうか
    if (_skillActer.equals(DATA_USERNAME)) {
      if (_skillEnergy < SB_lastEnergy) {
        SB_lastEnergy -= _skillEnergy;
      } else {
        double _rem = _skillEnergy - SB_lastEnergy;
        VP_message("エネルギーが" + String.valueOf(_rem) + "足りません");
        end();
        return;
      }
    }
    cutin();
    // スキルごとの動作
    switch(_skillName) {
      case "shield":
        BS_isShield = true;
        break;
      case "extend" :
        SB_barSize = 160;
        break;
      case "contract" :
        SB_barSize = 40;
        break;
      case "slow" :
        SB_gameSpeed = 0.3;
        break;
      case "fast" :
        SB_gameSpeed = 2.0;
        break;
      case "division" : // TODO:重大なエラー、スキル6が発動するとフリーズする
        // Iterator<Ball> iterator = SB_balls.iterator();
        // while (iterator.hasNext()) {
        //   Ball ball = iterator.next();
        //   SB_balls.add(new Ball(ball._x, ball._y, ball._dx * 0.8, ball._dy * -1, ball._size));
        // }
        break;
      case "bomb" :
        for (int x = 0; x < 12; x++) {
          for (int y = 0; y < 10; y++) {
            println("x:" + x + " y:" + y + " SB_blocks[y][x]:" + SB_blocks[y][x]);
            if (SB_blocks[y][x] > 0) {
              float r = random(0, 1);
              if (r > 0.5) {
                int l = (int)Math.ceil(SB_blocks[y][x] - (SB_blocksLife / 2));
                if (l < 0) l = 0;
                SB_blocks[y][x] = l;
              }
            }
          }
        }
        break;
      case "mine1" :
        int _x = (int)Math.ceil(random(0, 12));
        int _y = (int)Math.ceil(random(0, 10));
        for (int x = 0; x < 12; x++) {
          SB_blocks[_y][x] = SB_blocksLife;
        }
        for (int y = 0; y < 10; y++) {
          SB_blocks[y][_x] = SB_blocksLife;
        }
        break;
      case "mine2" :
        for (int x = 0; x < 12; x++) {
          for (int y = 0; y < 10; y++) {
            float r = random(0, 1);
            if (r > 0.5) {
              int l = (int)Math.ceil(SB_blocks[y][x] + (SB_blocksLife / 2));
              if (l > SB_blocksLife) l = SB_blocksLife;
              SB_blocks[y][x] = l;
            }
          }
        }
        break;
      case "magic" :
        BS_inflationBoostRate = 10;
        break;
      default : break;
    }
  }
  void end() {
    // スキルごとの動作
    switch(_skillName) {
      case "shield":
        BS_isShield = false;
        break;
      case "extend" :
        SB_barSize = 80;
        break;
      case "contract" :
        SB_barSize = 80;
        break;
      case "slow" :
        SB_gameSpeed = 1.0;
        break;
      case "fast" :
        SB_gameSpeed = 1.0;
        break;
      case "division" : break;
      case "bomb" : break;
      case "mine1" : break;
      case "mine2" : break;
      case "magic" :
        BS_inflationBoostRate = 1.0;
        break;
      default : break;
    }
    SB_skills.remove(this);
  }
  void update(int i) {
    // タイマーの更新
    if (VS_clock > _skillStartTime + _skillDulation) {
      end();
      return;
    }
    display(i);
    cutinUpdate();
    
    // スキルごとの動作
    switch(_skillName) {
      case "shield" : break;
      case "extend" : break;
      case "contract" : break;
      case "slow" : break;
      case "fast" : break;
      case "division" : break;
      case "bomb" : break;
      case "mine1" : break;
      case "mine2" : break;
      case "magic" : break;
      default : break;
    }
  }
  void display(int i) {
    float _elapsed = VS_clock - _skillStartTime;
    float _remain = _skillDulation - _elapsed;
    fill(20, 50, 150);
    rect(SB_blockWindowWidth,(GAME_height * (18 - (2 * i)) / 20) - GAME_width / 50, GAME_width - SB_blockWindowWidth, GAME_height / 10);
    fill(20, 200, 250);
    rect(SB_blockWindowWidth + (GAME_width - SB_blockWindowWidth) * (_elapsed / _skillDulation),(GAME_height * (39 - (4 * i)) / 40) - GAME_width / 50,(GAME_width - SB_blockWindowWidth) * (_remain / _skillDulation), GAME_height / 40);
    fill(255);
    textAlign(LEFT);
    textFont(fontMd);
    text(_skillNameJp + " : ( " + String.format("%.0f", Math.ceil(_remain / 1000)) + "秒 / " + String.format("%.0f", Math.ceil(_skillDulation / 1000)) + "秒 )", SB_blockWindowWidth + GAME_width / 50,(GAME_height * (9 - i) / 10) - GAME_width / 50 + GAME_height / 20);
  }
  
  //!カットイン
  
  //スキルカットイン画像は横2縦1比率
  void cutin() {
    if (_isCutin) {
      _cutinX = GAME_width;
      _isCutinSlideOut = false;
      _isCutinSlideIn = true;
      _cutinDX = GAME_width / 20;
    }
    _cutinImage = _createRoundedImage();
    _isCutin = true;
  }
  void cutinUpdate() {
    if (_isCutin) { // カットイン処理
      // slideIn
      if (_isCutinSlideIn) {
        _cutinX -= _cutinDX;
        _cutinDX -= float(GAME_width) / 225.0;
        if (_cutinDX < float(GAME_width) / 225.0) _cutinDX = float(GAME_width) / 225.0;
        if (_cutinX <= GAME_width * 2 / 3) {
          _cutinX = GAME_width * 2 / 3;
          _isCutinSlideIn = false;
          _cutinTime = millis();
        }
      }
      // slideOut開始
      if (!_isCutinSlideIn && !_isCutinSlideOut && millis() - _cutinTime > 3000) {
        _cutinDX = GAME_width / 20;
        _isCutinSlideOut = true;
      }
      // slideOut
      if (_isCutinSlideOut) {
        _cutinX += _cutinDX;
        _cutinDX -= float(GAME_width) / 225.0;
        if (_cutinDX < float(GAME_width) / 225.0) _cutinDX = float(GAME_width) / 225.0;
        if (_cutinX >= GAME_width) {
          _isCutinSlideOut = false;
          _isCutinSlideIn = true;
          _cutinDX = GAME_width / 20;
          _isCutin = false;
        }
      }
      image(_cutinImage, _cutinX,(_cutinSizeX) / 2, _cutinSizeX, _cutinSizeY);
    }
  }
  PImage _createRoundedImage() {
    PImage _rawImg = loadImage("src/images/skill/" + _skillName + ".png");
    PGraphics _pg = createGraphics(_rawImg.width, _rawImg.height);
    _pg.beginDraw();
    _pg.image(_rawImg, 0, 0);
    _pg.fill(0, 150);
    _pg.rect(0, _rawImg.height / 2, _rawImg.width, _rawImg.height / 2);
    _pg.fill(255); // テキストの色
    _pg.textAlign(CENTER, CENTER);
    _pg.textFont(createFont("src/fonts/kaiso.otf", GAME_width / 15));
    _pg.text(_skillName, _rawImg.width / 2, _rawImg.height * 5 / 6);
    if (_skillActer != "") _pg.text(_skillActer + "が発動", _rawImg.width / 2, _rawImg.height * 3 / 6);
    _pg.endDraw();
    
    PGraphics _mask = createGraphics(_rawImg.width, _rawImg.height);
    _mask.beginDraw();
    _mask.background(0, 0);
    _mask.noStroke();
    _mask.fill(255);
    _mask.rectMode(CORNER);
    _mask.beginShape();
    _mask.vertex(_cutinImageMaskRad, 0);
    _mask.vertex(_rawImg.width, 0); // 右上の角
    _mask.vertex(_rawImg.width, _rawImg.height); // 右下の角
    _mask.vertex(_cutinImageMaskRad, _rawImg.height);
    _mask.quadraticVertex(0, _rawImg.height, 0, _rawImg.height - _cutinImageMaskRad); // 左下の角を丸くする
    _mask.vertex(0, _cutinImageMaskRad);
    _mask.quadraticVertex(0, 0, _cutinImageMaskRad, 0); // 左上の角を丸くする
    _mask.endShape(CLOSE);
    _mask.endDraw();
    PImage _maskedImage = _pg.get();
    _maskedImage.mask(_mask);
    return _maskedImage;
  }
}
// ブロック崩し部分のロジック

int VB_barX = 0;

void VB_boot() {
  SB_isTimeProcessing = false; // 停止状態で開始
  SB_lastEnergy = 0; // 最後のエネルギーを初期化
  SB_blockWindowWidth = GAME_width * 2 / 3 - GAME_width / 40; // ブロック崩しの幅
  SB_inflationRate = 1 + (DATA_ENERGY + SB_lastEnergy) / 2000 * BS_inflationBoostRate; // インフレ率を計算
  SB_ballSize = float(GAME_width) / 50; // ボールの大きさ
  SB_balls = new ArrayList<Ball>(); // ボールの初期化
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 12; j++) {
      SB_blocks[i][j] = SB_blocksLife;
    }
  }
  VB_addBall(1); // ボールは1で開始
}

void VB_update() {
  textAlign(CENTER,CENTER);
  SB_inflationRate = 1 + (DATA_ENERGY + SB_lastEnergy) / 2000; // インフレ率を計算
  SB_blockCount = 0;
  for (int x = 0; x < 12; x++) {
    for (int y = 0; y < 10; y++) {
      VB_updateBlock(x,y);
    }
  }
  stroke(200);
  for (Ball b : SB_balls) {
    b.update();
  }
  VB_updateBar();
  SB_ballCount = SB_balls.size();
  if (SB_ballCount == 0 || SB_blockCount == 0) {
    cmode(5);
  }
}

void VB_updateBlock(int x, int y) {
  if (SB_blocks[y][x] > 0) {
    fill(250 - (250 * x / 12), 250 * x / 12, 250 * y / 10);
    rect(x * SB_blockWindowWidth / 12, y * GAME_height / 20, SB_blockWindowWidth / 12, GAME_height / 20);
    fill(0);
    textFont(fontMd);
    text(SB_blocks[y][x], x * SB_blockWindowWidth / 12 + SB_blockWindowWidth / 24 , y * GAME_height / 20 + GAME_height / 40);
  }
  SB_blockCount += SB_blocks[y][x];
}
void VB_updateBar() {
  if (SB_isTimeProcessing) {
    fill(255, 255, 0);
    VB_barX = mouseX - SB_blockWindowWidth * SB_barSize / 480;
    if (VB_barX < 0) {
      VB_barX = 0;
    } else if (VB_barX + SB_blockWindowWidth * SB_barSize / 240 > SB_blockWindowWidth) {
      VB_barX = SB_blockWindowWidth - SB_blockWindowWidth * SB_barSize / 240;
    }
  } else {
    fill(150, 150, 0);
  }
  rect(VB_barX, GAME_height - GAME_height / 10, SB_blockWindowWidth * SB_barSize / 240, GAME_height / 20);
}
void VB_addBall(int n) {
  for (int i = 0; i < n; i++) {
    SB_balls.add(new Ball(100, GAME_height * 3 / 5, SB_gameSpeed * 100 * (SB_blockWindowWidth / 24) / random(250,500), SB_gameSpeed * 100 * (SB_blockWindowWidth / 24) / random(250,500), SB_ballSize));
  }
}
// 当たり判定
String VB_hit(float _rx, float _ry, float _rw, float _rh, float _cx, float _cy, float _crad) {
  float _cstx = constrain(_cx, _rx, _rx + _rw);
  float _csty = constrain(_cy, _ry, _ry + _rh);
  float _distance = (_cx - _cstx) * (_cx - _cstx) + (_cy - _csty) * (_cy - _csty);
  boolean _isHit = _distance < (_crad * _crad);
  if (_isHit) { // 円形の当たり判定
    if (abs(_cx - _cstx) > abs(_cy - _csty)) {
      return "dx";
    } else {
      return "dy";
    }
  }
  return "";
}
// サイドパネル制御のロジック

int VP_messageTime = 0; // ブロック崩の起動時間 
boolean VP_isMessage = false; // ブロック崩しの起動状態
String VP_messageText = ""; // ブロック崩しの起動メッセージ
int VP_lastSocreSendTime = 0; // 最後にスコアを送信した時間

void VP_Boot() {
  VP_lastSocreSendTime = GAME_clock;
}
void VP_update() {
  fill(20, 100, 80);
  rect(SB_blockWindowWidth, 0, GAME_width - SB_blockWindowWidth, GAME_height);
  fill(255);
  textAlign(LEFT, TOP);
  textFont(fontMd);
  text("獲得エネルギー", float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 3 / 100);
  text("累計エネルギー", float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 20 / 100);
  text("エネルギー獲得効率", float(SB_blockWindowWidth) * 127 / 100, float(GAME_height) * 20 / 100);
  text("プレイヤーレベル", float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 30 / 100);
  text("接続中のチャンネル (c : 変更)", float(SB_blockWindowWidth) * 127 / 100, float(GAME_height) * 30 / 100);
  textFont(VP_fontScore);
  text(doubleToJp(SB_lastEnergy), float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 8 / 100);
  textFont(VP_fontScoreMd);
  text(doubleToJp(DATA_ENERGY), float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 23 / 100);
  text(doubleToJp(SB_inflationRate * SB_inflationRateTemporary) + "倍", float(SB_blockWindowWidth) * 127 / 100, float(GAME_height) * 23 / 100);
  text(NET_channel, float(SB_blockWindowWidth) * 127 / 100, float(GAME_height) * 33 / 100);
  textSize(GAME_width / 58);
  text("Lv. " + doubleToJp(Math.ceil(SB_inflationRate / 1000)), float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 33 / 100);
  textFont(fontMdsm);
  text(VP_scoreBoard(), float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 41 / 100);
  textAlign(CENTER, TOP);
  text("1 : シールド　　　　2 : バー拡張　　　　\n3 : 相手のバー縮小　4 : 時間減速　　　　\n5 : 相手の時間加速　6 : ボール分裂　　　\n7 : 支援砲撃　　　　8 : ブロック追加１　\n9 : ブロック追加２　0 : インフレ　　　　\nL : リスタート(デモ)\nI : インフレ(x2,デモ)\nP : ポーズ(デモ)", float(SB_blockWindowWidth) / 2, float(GAME_height) * 41 / 100);
  VP_messageUpdate();
  if (GAME_clock - VP_lastSocreSendTime > 2000) {
    VP_lastSocreSendTime = GAME_clock;
    NET_send("score",doubleToJp(SB_lastEnergy));
  }
}
String[][] VP_users = {
  {"userA", "1万8000"} ,
  {"userB", "2億9200万"} ,
  {"userC", "1億2000万"} ,
  {"userD", "1億8000万"}
};
String VP_scoreBoard() {
  String _r = "";
  for (int i = 0; i < VP_users.length; ++i) {
    _r += VP_users[i][0] + " : " + VP_users[i][1] + " E\n";
  }
  return _r;
}
void VP_scoreRecv(String _score, String _acterName) {
  for (int i = 0; i < VP_users.length; ++i) {
    if (VP_users[i][0].equals(_acterName)) {
      VP_users[i][1] = _score;
      return;
    }
  }
  String[][] _new = new String[VP_users.length + 1][2];
  for (int i = 0; i < VP_users.length; ++i) {
    _new[i][0] = VP_users[i][0];
    _new[i][1] = VP_users[i][1];
  }
  _new[VP_users.length][0] = _acterName;
  _new[VP_users.length][1] = _score;
  VP_users = _new;
}


void VP_message(String i) {
  VP_messageText = i;
  VP_messageTime = GAME_clock;
  VP_isMessage = true;
}
void VP_messageUpdate() {
  if (VP_isMessage) {
    fill(0, 200);
    rect(GAME_width * 4 / 10, GAME_height * 9 / 20, width / 5, height / 10);
    fill(255);
    textAlign(CENTER, CENTER);
    textFont(fontMd);
    text(VP_messageText, GAME_width * 4 / 10, GAME_height * 9 / 20, width / 5, height / 10);
    if (GAME_clock - VP_messageTime > 1500) {
      VP_isMessage = false;
    }
  }
}
// スキル制御のロジック

String[][] VS_skillTable;
int VS_clock = 0;
int VS_clockBefore = 0;

boolean VS_isDivision = false; // ボールを2倍にするスキルのフラグ

ArrayList<Skill> SB_skills = new ArrayList<>(); // スキルクラスを定義

void VS_boot() {
  // スキル一覧の読み込み
  String[] _csv = loadStrings("src/skills.csv");
  VS_skillTable = new String[_csv.length][];
  for (int i = 0; i < _csv.length; i++) {
    VS_skillTable[i] = split(_csv[i], ',');
  }
  VS_clock = 0;
  VS_clockBefore = GAME_clock;
}

void VS_update() {
  // 時間が進行中の時のみスキルの時間を進める
  if (SB_isTimeProcessing) {
    int _diff = GAME_clock - VS_clockBefore;
    VS_clock += _diff;
  }
  VS_clockBefore = GAME_clock;
  // スキルの更新
  int _i = 0;
  for (Skill skill : SB_skills) {
      skill.update(_i);
      _i++;
  }
}

void VS_skillRegister(String _id, String _acterName) { // *すべてのスキルはここに投げる
  if(SB_isTimeProcessing) {
    String[] _skillData = new String[0];
    for (int i = 1; i < VS_skillTable.length; i++) { // スキルテーブルからスキルを探し、発動対象を取得する
      if (VS_skillTable[i][0].equals(_id)) {
        _skillData = VS_skillTable[i];
        break;
      }
    }
    String _target = _skillData[1];
    // !重要 スキルの発動者と対象によるイベントの振り分け
    // !発火場所、残り時間表示、クールタイムの有無、発火する関数が複雑なので、if elseで分けています
    if (_acterName.equals(DATA_USERNAME) && _target.equals("self")) {
      // * 発動者が自分 + 対象が自分 = 自分のフィールドで発火、残り時間表示、クールタイムあり

      VS_skillRegister2(_id, _skillData, _acterName, true, true); // スキルの登録
      NET_send("skill",_id); // スキルの送信

    } else if (!_acterName.equals(DATA_USERNAME) && _target.equals("oppo")) {
      // * 発動者が相手 + 対象が自分 = 自分のフィールドで発火、残り時間表示、クールタイムなし

      VS_skillRegister2(_id, _skillData, _acterName, true, false); // スキルの登録

    } else if (_acterName.equals(DATA_USERNAME) && _target.equals("oppo")) {
      // * 発動者が自分 + 対象が相手 = 相手のフィールドで発火、残り時間なし、クールタイムあり

      VP_message(_skillData[5] + "を発動しました"); // メッセージ表示
      NET_send("skill",_id); // スキルの送信

    } else if (!_acterName.equals(DATA_USERNAME) && _target.equals("self")) {
      // * 発動者が相手 + 対象が相手 = 相手のフィールドで発火、残り時間なし、クールタイムなし

      VP_message(_acterName + "が" + _skillData[5] + "を発動しました"); // メッセージ表示

    }
  }
}
void VS_skillRegister2(String _id, String[] _skillData, String _acterName, boolean _isDisplayMonitor, boolean _isBlockDuplicate) {
  boolean isDuplicate = false;
  for (Skill _skill : SB_skills) {
    if (_skill._skillId.equals(_id)) {
      println("[skill] このスキルはクールタイム中です");
      isDuplicate = true;
    }
  }
  if (!isDuplicate || (isDuplicate && !_isBlockDuplicate)) {
    SB_skills.add(new Skill(_skillData, _acterName, _isDisplayMonitor));
  }
}
