// ボールを表示するクラス

class Ball {
  float _x, _y, _dy, _dx, _size;
  boolean _isHit = false;
  Ball(float _x, float _y, float _dx, float _dy, float _size) {
    this._x = _x;
    this._y = _y;
    this._dx = _dx;
    this._dy = _dy;
    this._size = _size;
  }
  void update() {
    // ブロックとボールの衝突判定
    for (int x = 0; x < 12; x++) {
      for (int y = 0; y < 10; y++) {
        isHit2Block(x, y);
      }
    }
    _isHit = false;
    // バーとボールの衝突判定
    isHit2Bar();
    // 通常の変更処理
    if (SB_isTimeProcessing) {
      // 移動先の当たり判定を確認
      if (_y < _size / 2) _dy *= -1;
      if (_x < _size / 2 || _x + _size / 2 >= SB_blockWindowWidth) _dx *= -1;
      if (US_isShield) { // シールド
        if (_y + _size / 2 >= GAME_height - (GAME_width / 50)) _dy = abs(_dy) * - 1; // 落下しても削除しない
      } else {
        if (_y >= GAME_height - (GAME_width / 50)) SB_balls.remove(this); // 落下判定
      }
      // 移動
      _x += _dx * SB_gameSpeed;
      _y += _dy * SB_gameSpeed;
    }
    // ボールの描画
    fill(100, 255, 255);
    circle(_x, _y, _size);
  }
  void division() {
    SB_balls.add(new Ball(_x, _y, _dx * 0.8, _dy * - 1, _size));
  }
  void isHit2Block(int x, int y) {
    if (SB_blocks[y][x] > 0 && !_isHit) { // ブロックが存在するとき
      String _hit = VB_hit(x * SB_blockWindowWidth / 12, y * GAME_height / 20, SB_blockWindowWidth / 12, GAME_height / 20, _x, _y, _size / 2);
      if (!_hit.equals("")) {
        if (_hit == "dx") {
          _isHit = true;
          _dx *= -1;
        } else {
          _isHit = true;
          _dy *= -1;
        }
        SB_blocks[y][x] = SB_blocks[y][x] - 1; // ブロックの値を1減らす
        if (SB_blocks[y][x] == 0) se("pa"); //se
        SB_lastEnergy += (random(100, 150) * SB_inflationRate * SB_inflationRateTemporary); // スコアを増やす
      }
    }
  }
  void isHit2Bar() {
    String _hit = VB_hit(VB_barX, GAME_height - GAME_height / 12, SB_blockWindowWidth * SB_barSize / 240, GAME_height / 20, _x, _y, _size);
    if (!_hit.equals("") && ((GAME_height - GAME_height / 12) < (_y + _size))) {
      if (_hit == "dy") {
        _dx = SB_gameSpeed * (_x - mouseX) / 15;
        _dy = abs(_dy) * - 1;
      }
    }
  }
}
