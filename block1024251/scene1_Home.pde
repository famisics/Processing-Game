// ホーム

int SH_titleShakeIndex = 0;
float SH_titleShakeX = 0;
float SH_titleShakeDX = 0;
float SH_titleShakeY = 0;
float SH_titleShakeDY = 0;
float SH_fontTitleSize = 3.0;

void SH_boot() {
  background(0);
  image1 = loadImage("src/images/start.png");
  image2 = loadImage("src/images/earth.png");
  image3 = loadImage("src/images/mars.png");
  int _size = GAME_width / 4;
  image2.resize(_size, _size);
  image3.resize(_size, _size);
  SH_titleShakeX = 0;
  SH_titleShakeY = 0;
}
void SH_update() {
  SH_titleShakeIndex++;
  if (SH_titleShakeIndex > 20) {
    SH_titleShakeIndex = 0;
    float _s = (float(GAME_width) / 10000);
    SH_titleShakeDX = random( -_s, _s);
    SH_titleShakeDY = random( -_s, _s);
  }
  SH_titleShakeX += SH_titleShakeDX;
  SH_titleShakeY += SH_titleShakeDY;
  if (abs(SH_titleShakeX) > GAME_width / 10) SH_titleShakeX = 0;
  if (abs(SH_titleShakeY) > GAME_height / 10) SH_titleShakeY = 0;
  tint(100, 100);
  image(image1, 0, 0, GAME_width, GAME_height);
  noTint();
  textAlign(CENTER,CENTER);
  textFont(SH_fontTitle);
  fill(255, 0, 0);
  text("地球再生計画", GAME_width / 2 + SH_titleShakeX + 10, GAME_height / 2 - (GAME_height / 6) + SH_titleShakeY + 10);
  fill(255);
  text("地球再生計画", GAME_width / 2 + SH_titleShakeX, GAME_height / 2 - (GAME_height / 6) + SH_titleShakeY);
  textFont(fontMd);
  text("Press space to start", GAME_width / 2 + (SH_titleShakeX / 2), GAME_height / 2 + (GAME_height / 6) + (SH_titleShakeY / 2));
  textAlign(LEFT);
  text("現在のエネルギー: " + DATA_ENERGY, GAME_height / 10, GAME_height / 10);
  rectMode(CORNER);
  navbar("","2024 (C) b1024251 Takumi Yamazaki");
}
