// ブロック崩し部分のロジック

int VB_barX = 0;

void VB_boot() {
  SB_isTimeProcessing = false; // 停止状態で開始
  SB_lastEnergy = 0; // 最後のエネルギーを初期化
  SB_blockWindowWidth = GAME_width * 2 / 3 - GAME_width / 40; // ブロック崩しの幅
  SB_inflationRate = 1 + (DATA_ENERGY + SB_lastEnergy) / 10000 * BS_inflationBoostRate; // インフレ率を計算
  SB_ballSize = float(GAME_width) / 50; // ボールの大きさ
  SB_balls = new ArrayList<Ball>(); // ボールの初期化
  SB_ballCount = 0; // ボールの数を初期化
  SB_blockCount = 0; // ブロックの数を初期化
  for (int i = 0; i < 10; i++) {
    for (int j = 0; j < 12; j++) {
      SB_blocks[i][j] = SB_blocksLife;
    }
  }
  VB_addBall(1); // ボールは1で開始
}

void VB_update() {
  textAlign(CENTER,CENTER);
  SB_inflationRate = 1 + (DATA_ENERGY + SB_lastEnergy) / 10000 * BS_inflationBoostRate; // インフレ率を計算
  SB_blockCount = 0;
  stroke(255);
  for (int x = 0; x < 12; x++) {
    for (int y = 0; y < 10; y++) {
      VB_updateBlock(x,y);
    }
  }
  for (Ball _Ball : SB_balls) {
    _Ball.update();
  }
  VB_updateBar();
  if (SB_ballCount == 0 || SB_blockCount == 0) {
    cmode(5);
  }
  noStroke();
}

void VB_updateBlock(int x, int y) {
  if (SB_blocks[y][x] > 0) {
    fill(250 - (250 * x / 12), 250 * x / 12, 250 * y / 10);
    rect(x * SB_blockWindowWidth / 12, y * GAME_height / 20, SB_blockWindowWidth / 12, GAME_height / 20);
    fill(0);
    textFont(fontMd);
    text(SB_blocks[y][x], x * SB_blockWindowWidth / 12 + SB_blockWindowWidth / 24 , y * GAME_height / 20 + GAME_height / 40);
  }
  SB_blockCount += SB_blocks[y][x];
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
    SB_ballCount++;
    SB_balls.add(new Ball(100, GAME_height * 3 / 5, SB_gameSpeed * 100 * (SB_blockWindowWidth / 24) / random(250,500), SB_gameSpeed * 100 * (SB_blockWindowWidth / 24) / random(250,500), SB_ballSize));
  }
}
// 当たり判定
String VB_hit(float _rx, float _ry, float _rw, float _rh, float _cx, float _cy, float _crad) {
  float _closestX = constrain(_cx, _rx, _rx + _rw);
  float _closestY = constrain(_cy, _ry, _ry + _rh);
  float _distanceX = _cx - _closestX;
  float _distanceY = _cy - _closestY;
  float _distanceSquared = _distanceX * _distanceX + _distanceY * _distanceY;
  if (_distanceSquared < (_crad * _crad) || (_cx + _crad > _rx && _cx - _crad < _rx + _rw && abs(_distanceY) < _crad) || (_cy + _crad > _ry && _cy - _crad < _ry + _rh && abs(_distanceX) < _crad)) {
    if (abs(_distanceX) > abs(_distanceY)) {
      return "dx";
      } else {
      return "dy";
      }
  }
  return "";
}
