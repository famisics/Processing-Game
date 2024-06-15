// ホーム

Button SH_button1, SH_button2;
void SH_boot() {
  background(0);
  image1 = loadImage("src/images/start.png");
  image2 = loadImage("src/images/earth.png");
  image3 = loadImage("src/images/mars.png");
  int _buttonSize = GAME_width / 4;
  image2.resize(_buttonSize, _buttonSize);
  image3.resize(_buttonSize, _buttonSize);
  SH_button1 = CP.addButton("home1")
    .setLabel("探索(PvE, 1人プレイ)")
    .setFont(fontMd)
    .setImage(image2)
    .setPosition(GAME_width / 10, GAME_height / 2)
    .setSize(_buttonSize, _buttonSize);
  SH_button2 = CP.addButton("home2")
    .setLabel("戦闘(PvP, 2人プレイ)")
    .setFont(fontMd)
    .setImage(image3)
    .setPosition(GAME_width - GAME_width / 4 - GAME_width / 10, GAME_height / 2)
    .setSize(_buttonSize, _buttonSize);
}
void SH_update() {
  tint(100, 100);
  image(image1, 0, 0, GAME_width, GAME_height);
  noTint();
  fill(255);
  textAlign(CENTER,CENTER);
  textFont(fontXl);
  text("地球再生計画", GAME_width / 2, GAME_height / 2 - (GAME_height / 6));
  textFont(fontMd);
  text("Press space to start", GAME_width / 2, GAME_height / 2 + (GAME_height / 6));
  textAlign(LEFT);
  text("現在のエネルギー: " + DATA_ENERGY, GAME_height / 10, GAME_height / 10);
  rectMode(CORNER);
  navbar("","2024 (C) b1024251 Takumi Yamazaki");
}
