int SR_plasma = 0, SR_plasmaCount = 0, SR_displayLastEnergy;
void SR_boot() {
  background(0);
  fill(255);
  SR_displayLastEnergy = SB_lastEnergy;
  SB_lastEnergy = 0;
  SR_plasma = DATA_ENERGY * 6;
}
void SR_update() {
  tint(50, 50);
  image1 = loadImage("src/images/status.png");
  image(image1, 0, 0, GAME_width, GAME_height);
  // background(100, 0, 100);
  fill(255);
  textAlign(CENTER,CENTER);
  textFont(fontXl);
  text(DATA_USERNAME + "のステータス", GAME_width / 2, GAME_height / 10);
  textFont(fontMd);
  textAlign(LEFT,CENTER);
  text("ゲームオーバー, 今回のフェーズが終了しました\n\n\n\n今回獲得 エネルギー :\n\n累計獲得 エネルギー :\n\n展開済み エネルギー :\n\n使用可能 エネルギー :\n\n？？？？ ？？？？？ :", GAME_width / 4, GAME_height / 2);// ボタン
  textAlign(RIGHT,CENTER);
  text("\n\n\n\n" + SR_displayLastEnergy + "\n\n" + DATA_ENERGY + "\n\n" + "0" + "\n\n" + "0\n\n" + SR_plasma, GAME_width / 4 + 800, GAME_height / 2);// ボタン
  textAlign(CENTER,CENTER);
  navbar("","");
  SR_calcPlasma();
}
void SR_calcPlasma() {
  if (SR_plasmaCount > 20) {
    SR_plasma += random(1000, 20000);
    SR_plasmaCount = 0;
  } else {
    SR_plasmaCount++;
  }
}
