// 探索開始画面

int SS_startTime = 0; // SPACEを押し始めた時間
boolean SS_isSpace = false; // SPACEを押しているかどうか

void SS_boot() {
  noTint();
  image1 = loadImage("src/images/world.png");
}

void SS_update() {
  image(image1, 0, 0, GAME_width, GAME_height);
  actions("探索を開始");
  textAlign(CENTER, CENTER);  
  fill(255);
  textFont(fontLg);
  text("対戦する他のプレイヤーにチャンネル名を伝えてください", GAME_width / 2, GAME_height / 4);
  textFont(SC_fontChannel);
  fill(100, 255, 200);
  text(SC_ch, GAME_width / 2, GAME_height / 2);
  navbar("Enter : チャンネル選択に戻る　SPACE長押し : 探索開始","");
  fill(255);
  textFont(fontLg);
  if (SS_isSpace) {
    text("押し続けてください", GAME_width / 2, GAME_height * 3 / 4);
    fill(100, 255, 200);
    rect(0, GAME_height * 19 / 20 - (GAME_width / 50), float(GAME_width) * (float(GAME_clock - SS_startTime) / 1000), GAME_height / 20);
    if (GAME_clock - SS_startTime >= 1000) {
      SS_isSpace = false;
      cmode(2);
    }
  } else {
    text("同じチャンネルの誰かがSPACEキーを長押しすると\n全員の探索が開始されます", GAME_width / 2, GAME_height * 3 / 4);
  }
}