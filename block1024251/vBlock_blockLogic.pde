

void VB_addBall(int n) {
  for (int i = 0; i < n; i++) {
    SB_balls.add(new Ball(100, GAME_height * 3 / 5, SB_gameSpeed * (GAME_width / 12) / random(500,1500), SB_gameSpeed * (GAME_width / 12) / random(500,1500), 64));
    // TODO:SB_ballSize:64(wid th=2560時)のはずだけどなぜかそうならない、いったん64で固定
  }
}
boolean VB_isOverlap(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {
  return x1 < x2 + w2 && x2 < x1 + w1 && y1 < y2 + h2 && y2 < y1 + h1;
}
