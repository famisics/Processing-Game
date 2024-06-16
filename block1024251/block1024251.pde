// メイン

// ライブラリのインポート
import java.util.Iterator;
import processing.sound.*;
import websockets.*;
import controlP5.*;

// ネットワーク機能を有効にするには true を代入する
boolean NET_isNetworkEnable = false;

// void settings() {
//   fullScreen();
// }
// TODO:フルスクリーンの状態でビルドする

void setup() {
  background(0);
  println("[GENERAL] ゲームを初期化しています");
  se = new SoundFile(this, "src/sounds/mute.mp3");
  size(1280, 720);
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
    case 3 : // Channel
      SC_update();
      break;
    case 4 : // -----
      break;
    case 5 : // result
      SR_update();
      break;
    case 6 : // talk
      ST_update();
      break;
    case 7 : // worldmap
      SW_update();
      break;
    default :
    break;	
  }
  FPS_data.update();
  GAME_clock = millis();
  alert();
}

void cmode(int _mode) { // !画面遷移(1回だけ実行)
  save();
  bgm1.stop();
  bgm2.stop();
  bgm5.stop();
  bgm6.stop();
  switch(_mode) {
    case 1 : // home
      println("[SCENE1]  Home");
      bgm1.loop();
      // background(0); // 画面を暗くしてから描画, 今は無効
      SH_boot();
      break;
    case 2 : // block
      println("[SCENE2]  Block");
      bgm2.loop();
      bgm2.pause();
      SB_boot();
      break;
    case 3 : // Channel
      println("[SCENE3]  Channel");
      SC_boot();
      break;
    case 4 : // -----
      println("[SCENE4]  -----");
      break;
    case 5 : // result
      println("[SCENE5]  Result");
      bgm5.loop();
      SR_boot();
      break;
    case 6 : // talk
      println("[SCENE6]  Talk");
      bgm6.loop();
      ST_boot();
      break;
    case 7 : // worldmap
      println("[SCENE7]  Worldmap");
      SW_boot();
      break;
    default :
    break;	
  }
  GAME_MODE = _mode;
}

void dispose() {
  save();
  println("[GENERAL] ゲームが停止しました\n");
  if (!DATA_SAVELOCKED) {
    println("> あなたの累計獲得エネルギー: " + String.valueOf(DATA_ENERGY) + " (保存されました)\n\n########  ##   ##  #######  ###  ##  ##   ##          ##   ##  #######  ##   ##\n   ##     ##   ##  ##   ##  ###  ##  ##  ##           ##   ##  ##   ##  ##   ##\n   ##     #######  #######  ## ####  #####            #######  ##   ##  ##   ##\n   ##     ##   ##  ##   ##  ##  ###  ##  ##                ##  ##   ##  ##   ##\n   ##     ##   ##  ##   ##  ##   ##  ##   ##          #######  #######  #######");
  }
}
