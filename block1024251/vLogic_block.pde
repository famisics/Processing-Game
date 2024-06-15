// ブロック崩し部分のロジック

int VB_barX = 0;

void VB_boot() {
  SB_isTimeProcessing = false; // 停止状態で開始
  SB_lastEnergy = 0; // 最後のエネルギーを初期化
  SB_balls = new ArrayList<Ball>(); // ボールの初期化
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 12; j++) {
      SB_blocks[i][j] = SB_blocksLife;
    }
  }
  VB_addBall(20); // ボールは1で開始
}

void VB_update() {
  textAlign(CENTER,CENTER);
  for (int x = 0; x < 12; x++) {
    for (int y = 0; y < 10; y++) {
      VB_updateBlock(x,y);
    }
  }
  stroke(100);
  for (int i = 0; i < SB_balls.size(); i++) {
    SB_balls.get(i).update();
  }
  VB_updateBar();
  if (!SB_isTimeProcessing) {
    fill(255, 100, 100, 50);
    rect(0, 0, GAME_width, GAME_height);
    fill(255, 0, 0);
    textFont(fontXl);
    text("PAUSED", GAME_width / 2, GAME_height / 2 - (GAME_height / 6));
    textFont(fontMd);
    text("Press space to resume", GAME_width / 2, GAME_height / 2 + (GAME_height / 6));
  }
}

void VB_updateBlock(int x, int y) {
  if (SB_blocks[y][x] > 0) {
    fill(250 - (250 * x / 12), 250 * x / 12, 250 * y / 10);
    rect(x * SB_blockWindowWidth / 12, y * GAME_height / 20, SB_blockWindowWidth / 12, GAME_height / 20);
    fill(0);
    textFont(fontMd);
    text(SB_blocks[y][x], x * SB_blockWindowWidth / 12 + SB_blockWindowWidth / 24 , y * GAME_height / 20 + GAME_height / 40);
  }
}
void VB_updateBar() {
  if (SB_isTimeProcessing) {
    fill(255, 255, 0);
    VB_barX = mouseX - SB_blockWindowWidth * SB_barSize / 480;
    if (VB_barX < 0) {
      VB_barX = 0;
    } else if (VB_barX + SB_blockWindowWidth * SB_barSize / 240 > SB_blockWindowWidth) {
      VB_barX = SB_blockWindowWidth - SB_blockWindowWidth * SB_barSize / 240;
    }
  } else {
    fill(150, 150, 0);
  }
  rect(VB_barX, GAME_height - GAME_height / 10, SB_blockWindowWidth * SB_barSize / 240, GAME_height / 20);
}
void VB_addBall(int n) {
  for (int i = 0; i < n; i++) {
    SB_balls.add(new Ball(100, GAME_height * 3 / 5, SB_gameSpeed * (SB_blockWindowWidth / 24) / random(500,1500), SB_gameSpeed * (SB_blockWindowWidth / 24) / random(500,1500), SB_ballSize));
  }
}
// 当たり判定
String VB_hit(float _rx, float _ry, float _rw, float _rh, float _cx, float _cy, float _crad) {
  float _cstx = constrain(_cx, _rx, _rx + _rw);
  float _csty = constrain(_cy, _ry, _ry + _rh);
  float _distance = (_cx - _cstx) * (_cx - _cstx) + (_cy - _csty) * (_cy - _csty);
  boolean _isHit = _distance < (_crad * _crad);
  if(_isHit) { // 円形の当たり判定
    if (abs(_cx - _cstx) > abs(_cy - _csty)) {
      return "dx";
    } else {
      return "dy";
    }
  }
  return "";
}
