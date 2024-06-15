// かなしきかな削除したコードたち

String[] SsT_Script = {
  "地球再生計画に参加していただきありがとうございます",
  "あなたは1隻の工作船の艦長として",
  "惑星の再生に貢献していただきます",
  "",
  "地球再生計画の流れは以下の通りです",
  "1. エネルギーを回収する\n　",
  "1. エネルギーを回収する\nこの惑星には凝固したエネルギーが存在します",
  "1. エネルギーを回収する\nこのエネルギーを回収することで",
  "1. エネルギーを回収する\n次の探査のためのエネルギーを補充します",
  "2. アップグレードを購入する\n　",
  "2. アップグレードを購入する\nアップグレードパーツはルナストアで購入できます",
  "2. アップグレードを購入する\nアップグレードパーツを購入することで",
  "2. アップグレードを購入する\n様々な施設の効率を引き上げます",
  "3. 惑星のコアを起動する\n　",
  "3. 惑星のコアを起動する\n十分なエネルギーとパーツを揃えたのち",
  "3. 惑星のコアを起動する\n膨大なエネルギーを利用して惑星のコアを起動します",
  "3. 惑星のコアを起動する\nこの作業は複数の艦長と共同で行うことができます",
  "さっそくエネルギーを回収してみましょう",
};

class FPS {
  int _fps;
  long _now;
  long _flame;
  double _temp;
  int _count;
  long _start = System.currentTimeMillis();
  String _display = "";
  void get() {
    _count++;
    if (_count == 1)_flame = System.currentTimeMillis();
    _fps++;
    _now = System.currentTimeMillis();
    double _time = Math.floor((_now-_start)/1000);
    if (_time - _temp >= 1)
    {
      _display =  _fps+"fps ("+(_now-_flame)/_fps+"ms)";
      _fps=0;
      _temp=_time;
      _flame = System.currentTimeMillis();
    }
  }
  void update() {
    get();
    fill(0, 50, 0);
    rect(GAME_width - GAME_width/12, 0, GAME_width/12, GAME_width/50);
    textAlign(RIGHT,CENTER);
    fill(100, 255, 255);
    textFont(fontSm);
    text(_display, GAME_width - 8, GAME_width/100);
  }
}

println("\u001b[37;1m> あなたの累計獲得エネルギー: \u001b[33;1m" + str(DATA_ENERGY) + "\u001B[0m (保存されました)\n\n\u001B[31m########\u001B[0m  \u001B[33m##   ##\u001B[0m  \u001B[32m#######\u001B[0m  \u001B[36m###  ##\u001B[0m  \u001B[34m##   ##\u001B[0m          \u001B[34m##   ##\u001B[0m  \u001B[35m#######\u001B[0m  \u001B[31m##   ##\u001B[0m\n\u001B[31m   ##   \u001B[0m  \u001B[33m##   ##\u001B[0m  \u001B[32m##   ##\u001B[0m  \u001B[36m###  ##\u001B[0m  \u001B[34m##  ## \u001B[0m          \u001B[34m##   ##\u001B[0m  \u001B[35m##   ##\u001B[0m  \u001B[31m##   ##\u001B[0m\n\u001B[31m   ##   \u001B[0m  \u001B[33m#######\u001B[0m  \u001B[32m#######\u001B[0m  \u001B[36m## ####\u001B[0m  \u001B[34m#####  \u001B[0m          \u001B[34m#######\u001B[0m  \u001B[35m##   ##\u001B[0m  \u001B[31m##   ##\u001B[0m\n\u001B[31m   ##   \u001B[0m  \u001B[33m##   ##\u001B[0m  \u001B[32m##   ##\u001B[0m  \u001B[36m##  ###\u001B[0m  \u001B[34m##  ## \u001B[0m          \u001B[34m     ##\u001B[0m  \u001B[35m##   ##\u001B[0m  \u001B[31m##   ##\u001B[0m\n\u001B[31m   ##   \u001B[0m  \u001B[33m##   ##\u001B[0m  \u001B[32m##   ##\u001B[0m  \u001B[36m##   ##\u001B[0m  \u001B[34m##   ##\u001B[0m          \u001B[34m#######\u001B[0m  \u001B[35m#######\u001B[0m  \u001B[31m#######\u001B[0m");


if (VB_isOverlap(x * SB_blockWindowWidth / 12, y * GAME_height / 20, SB_blockWindowWidth / 12, GAME_height / 20, _x + _dx - _size / 2, _y + _dy - _size / 2, _size, _size)) {
  if (VB_isOverlap(x * SB_blockWindowWidth / 12, y * GAME_height / 20, SB_blockWindowWidth / 12, GAME_height / 20, _x + _dx - _size / 2, _y, _size, _size)) { // X方向に衝突
    _dx = -_dx;
  }
  if (VB_isOverlap(x * SB_blockWindowWidth / 12, y * GAME_height / 20, SB_blockWindowWidth / 12, GAME_height / 20, _x, _y + _dy - _size / 2, _size, _size)) { // Y方向に衝突
    _dy = -_dy;
  }
}
