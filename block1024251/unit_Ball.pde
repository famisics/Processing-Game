class Ball {
  float _x, _y, _dy, _dx, _size;
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
    // バーとボールの衝突判定
    isHit2Bar();
    // 通常の変更処理
    if (SB_isTimeProcessing) {
      // 移動先の当たり判定を確認
      if (_x < _size/2 || _x + _size/2 >= GAME_width) {_dx = -_dx;}
      if (_y < _size/2) {_dy = -_dy;}
      if (_y + _size/2 >= GAME_height) {
        _dy = -_dy;
        // _dy = 0;
        // _dx = 0;
        // cmode(3); // 別画面への遷移
      }
      // 移動
      _x += _dx;
      _y += _dy;
    }
    // ボールの描画
    fill(100, 255, 255);
    circle(_x, _y, _size);
  }
  void isHit2Block(int x, int y) {
    if(SB_block[y][x] > 0) { // ブロックが存在するとき
      if(SB_isOverlap(x*GAME_width/12, y*GAME_height/20, GAME_width/12, GAME_height/20, _x + _dx - _size/2, _y + _dy - _size/2, _size, _size)) {
        if (SB_isOverlap(x*GAME_width/12, y*GAME_height/20, GAME_width/12, GAME_height/20, _x + _dx - _size/2, _y, _size, _size)) { // X方向に衝突
          _dx = -_dx;
        }
        if (SB_isOverlap(x*GAME_width/12, y*GAME_height/20, GAME_width/12, GAME_height/20, _x, _y + _dy - _size/2, _size, _size)) { // Y方向に衝突
          _dy = -_dy;
        }
        SB_block[y][x] = SB_block[y][x] - 1; // ブロックの値を1減らす
        if (SB_block[y][x] == 0) se("pa");
        SB_lastEnergy += random(100, 200); // スコアを増やす
      }
    }
  }
  void isHit2Bar() {
    int _barX = mouseX - GAME_width*SB_barSize/480;
    if (_barX < 0) {_barX = 0;} else if (_barX + GAME_width*SB_barSize/240 > GAME_width) {_barX = GAME_width - GAME_width*SB_barSize/240;}
    if (SB_isOverlap(_barX, GAME_height - GAME_height/10, GAME_width*SB_barSize/240, GAME_height/20, _x, _y, _size/2, _size/2)) {
        // DYの変更
        if (_dy > 0) {
          _dy = -_dy;
        }
        // DXの変更
        _dx = SB_gameSpeed*(_x - mouseX) / 5000;
    }
  }
}
