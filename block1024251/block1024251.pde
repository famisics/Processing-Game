import java.util.Iterator;
import java.util.Collections;
import java.util.Arrays;
import java.util.List;
import processing.sound.*;
import websockets.*;

// *重要な設定 ------------------

// 【ネットワーク機能を有効にするかどうか】ネットワーク機能を有効にするには true にする
boolean NET_isNetworkEnable = false; // TODO:trueの状態でビルドする
// !Proxyサーバーが起動していないにも関わらず、trueになっているとゲームがフリーズします

// 【プロキシサーバーのポート番号】ポート番号を変更する場合はここを変更する
int NET_SERVER_PORT = 8001;

// 獲得エネルギーインフレ率 (デモ, 簡易ゲームバランス調整)
double SB_inflationRateTemporary = 0.2;

// *設定ここまで ----------------

// TODO:フルスクリーンの状態でビルドする
// void settings() {
//   fullScreen();
// }

void setup() {
  background(0);
  println("[GENERAL] Initializing");
  se = new SoundFile(this, "src/sounds/mute.mp3");
  size(1280, 800); // デバッグ用の解像度
  frameRate(60);
  noStroke();
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
      switch((int)random(1, 4)) { // 1-3までランダムにBGMを選択
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
  println("[GENERAL] Stopped\n");
  if (!DATA_SAVELOCKED) {
    println("> Your current energy: " + String.valueOf(DATA_ENERGY) + " (Saved)\n\n########  ##   ##  #######  ###  ##  ##   ##          ##   ##  #######  ##   ##\n   ##     ##   ##  ##   ##  ###  ##  ##  ##           ##   ##  ##   ##  ##   ##\n   ##     #######  #######  ## ####  #####            #######  ##   ##  ##   ##\n   ##     ##   ##  ##   ##  ##  ###  ##  ##                ##  ##   ##  ##   ##\n   ##     ##   ##  ##   ##  ##   ##  ##   ##          #######  #######  #######\n\n ");
  }
}
