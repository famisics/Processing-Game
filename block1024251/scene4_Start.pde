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
