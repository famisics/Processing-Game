// ブロック崩し部分のロジック

void VB_updateBlock(int x, int y) {
  if (SB_block[y][x] > 0) {
    fill(250 - (250 * x / 12), 250 * x / 12, 250 * y / 10);
    rect(x * GAME_width / 12, y * GAME_height / 20, GAME_width / 12, GAME_height / 20);
    fill(0);
    textFont(fontMd);
    text(SB_block[y][x], x * GAME_width / 12 + GAME_width / 24 , y * GAME_height / 20 + GAME_height / 40);
  }
}
void VB_updateBar() {
  fill(255, 255, 0);
  int _barX = mouseX - GAME_width * SB_barSize / 480;
  if (_barX < 0) {_barX = 0;} else if (_barX + GAME_width * SB_barSize / 240 > GAME_width) {_barX = GAME_width - GAME_width * SB_barSize / 240;}
  rect(_barX, GAME_height - GAME_height / 10, GAME_width * SB_barSize / 240, GAME_height / 20);
}
void VB_addBall(int n) {
  for (int i = 0; i < n; i++) {
    SB_balls.add(new Ball(100, GAME_height * 3 / 5, SB_gameSpeed * (GAME_width / 12) / random(500,1500), SB_gameSpeed * (GAME_width / 12) / random(500,1500), 64));
    // TODO:SB_ballSize:64(wid th=2560時)のはずだけどなぜかそうならない、いったん64で固定
  }
}
boolean VB_isOverlap(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  return x1 < x2 + w2 && x2 < x1 + w1 && y1 < y2 + h2 && y2 < y1 + h1;
}
