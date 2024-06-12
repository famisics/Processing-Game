class FPS {
  int _flame;
  long _now;
  double _temp;
  long _start = System.currentTimeMillis();
  int _fps = 0;
  void update() {
    _flame++;
    _now = System.currentTimeMillis();
    double _time = Math.floor((_now-_start)/1000);
    if (_time - _temp >= 1) {
      _fps = _flame;
      _flame=0;
      _temp=_time;
    }
    fill(0, 50, 0);
    rect(GAME_width - GAME_width/28, 0, GAME_width/28, GAME_width/60);
    textAlign(RIGHT,CENTER);
    fill(100, 255, 255);
    textFont(fontMono);
    text(_fps+"fps", GAME_width - 4, GAME_width/120);
  }
}
