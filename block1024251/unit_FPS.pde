// FPS(フレーム/秒)を表示するクラス

class FPS {
  int _flame;
  long _now;
  double _temp;
  long _start = System.currentTimeMillis();
  int _fps = 0;
  void update() {
    _flame++;
    _now = System.currentTimeMillis();
    double _time = Math.floor((_now - _start) / 1000);
    if (_time - _temp >= 1) {
      _fps = _flame;
      _flame = 0;
      _temp = _time;
    }
    fill(0, 50, 0);
    if (GAME_fpsIndex < 4) {
      rect(GAME_width - GAME_width / 18, 0, GAME_width / 18, GAME_width / 60);
    } else {
      rect(GAME_width - GAME_width / 15, 0, GAME_width / 15, GAME_width / 60);
    }
    textAlign(RIGHT,CENTER);
    fill(100, 255, 255);
    textFont(fontMono);
    text(_fps + "/" + GAME_fps[GAME_fpsIndex] + "fps", GAME_width - 3, GAME_width / 120);
  }
}
