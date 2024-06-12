int SS_plasma = 0, SS_plasmaCount = 0, SS_displayLastEnergy;
void SS_boot() {
  background(0);
  fill(255);
  SS_displayLastEnergy = SB_lastEnergy;
  SB_lastEnergy = 0;
  SS_plasma = DATA_ENERGY*6;
}
void SS_update() {
  tint(50, 50);
  image1 = loadImage("data/src/images/status.png");
  image(image1, 0, 0, GAME_width, GAME_height);
  // background(100, 0, 100);
  fill(255);
  textAlign(CENTER,CENTER);
  textFont(fontXl);
  text(DATA_USERNAME+"のステータス", GAME_width/2, GAME_height/10);
  textFont(fontMd);
  textAlign(LEFT,CENTER);
  text("ゲームオーバー, 今回のフェーズが終了しました\n\n\n\n今回獲得 エネルギー :\n\n累計獲得 エネルギー :\n\n展開済み エネルギー :\n\n使用可能 エネルギー :\n\n？？？？ ？？？？？ :", GAME_width/4, GAME_height/2);// ボタン
  textAlign(RIGHT,CENTER);
  text("\n\n\n\n"+SS_displayLastEnergy+"\n\n"+DATA_ENERGY+"\n\n"+"0"+"\n\n"+"0\n\n"+SS_plasma, GAME_width/4 + 800, GAME_height/2);// ボタン
  textAlign(CENTER,CENTER);
  navbar("","");
  SS_calcPlasma();
}
void SS_calcPlasma() {
  if (SS_plasmaCount > 20) {
    SS_plasma += random(1000, 20000);
    SS_plasmaCount = 0;
  } else {
    SS_plasmaCount++;
  }
}
