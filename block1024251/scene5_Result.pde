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
