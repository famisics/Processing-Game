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
  size(900, 600); // デバッグ用の解像度
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
    case 8 : // blackout
      noTint();
      background(0);
      textAlign(CENTER,CENTER);
      textFont(SH_fontTitle);
      fill(255);
      text("暗転", GAME_width / 2 , GAME_height / 2);
      textFont(fontXl);
      text("スペースキーを押して復帰", GAME_width / 2 , GAME_height * 3 / 4);
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
    case 3 : // channel
      println("[SCENE3]  Channel");
      SC_boot();
      break;
    case 4 : // start
      println("[SCENE4]  Start");
      SS_boot();
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
    case 7 : // username
      println("[SCENE7]  Username");
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
