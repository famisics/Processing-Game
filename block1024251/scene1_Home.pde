void SH_boot() {
  image1 = loadImage("data/src/images/start.png");
}
void SH_update() {
  tint(100, 50);
  image(image1, 0, 0, GAME_width, GAME_height);
  fill(255);
  textAlign(CENTER,CENTER);
  textFont(fontXl);
  text("地球再生計画", GAME_width/2, GAME_height/2 - (GAME_height/6));
  textFont(fontMd);
  text("Press space to start", GAME_width/2, GAME_height/2 + (GAME_height/6));
  textAlign(LEFT);
  text("現在のエネルギー: " + DATA_ENERGY, GAME_height/10, GAME_height/10);
  rectMode(CORNER);
  navbar("","2024 (C) b1024251 Takumi Yamazaki");
}
