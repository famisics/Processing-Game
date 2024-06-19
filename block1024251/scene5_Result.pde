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
  text("ゲームが終了しました", GAME_width / 2, GAME_height / 12);
  textFont(VP_fontScoreMd);
  textAlign(LEFT,TOP);
  text("今回獲得 エネルギー　:　" + doubleToJp(SR_displayLastEnergy) + "\n\n累計獲得 エネルギー　:　" + doubleToJp(DATA_ENERGY) + "\n\n？？？？？？？？？　:　" + doubleToJp(SR_plasma) + "\n\nスペースキーを押してトップに戻ります", GAME_width / 20, GAME_height * 7 / 20);
  if(NET_isNetworkEnable) text(VP_scoreBoard(), GAME_width * 10 / 20, GAME_height * 7 / 20);
  textFont(ST_fontTutorial);
  text(DATA_USERNAME + " のステータス", GAME_width / 20, GAME_height * 5 / 20);
  if(NET_isNetworkEnable) text("チャンネル " + NET_channel + " のランキング", GAME_width * 10 / 20, GAME_height * 5 / 20);
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
