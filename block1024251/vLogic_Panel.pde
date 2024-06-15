// サイドパネル制御のロジック

String[] VP_jpu = {"", "万", "億", "兆", "京", "垓", "秭", "穣", "溝", "澗", "正", "載", "極", "恒河沙", "阿僧祇", "那由他", "不可思議", "無量大数"};
int[] VP_jpuRank = {0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64, 68};

void VP_Boot() {
  
}
void VP_update() {
  fill(20, 100, 80);
  rect(SB_blockWindowWidth, 0, GAME_width - SB_blockWindowWidth, GAME_height);
  fill(255);
  textAlign(LEFT, TOP);
  textFont(VP_fontScore);
  text(VP_longToJapanese(SB_lastEnergy), float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 8 / 100);
  textFont(fontMd);
  text("獲得エネルギー", float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 3 / 100);
  textFont(VP_fontScoreMd);
  text(VP_longToJapanese(DATA_ENERGY), float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 23 / 100);
  textFont(fontSm);
  text("累計エネルギー", float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 20 / 100);
  textFont(VP_fontScoreMd);
  text( VP_longToJapanese(SB_inflationRate)+"倍", float(SB_blockWindowWidth) * 127 / 100, float(GAME_height) * 23 / 100);
  textFont(fontSm);
  text("インフレ倍率", float(SB_blockWindowWidth) * 127 / 100, float(GAME_height) * 20 / 100);
}

String VP_longToJapanese(double value) {
  if (value == 0) return "0";
  StringBuilder _sb = new StringBuilder();
  int _i = VP_jpu.length - 1;
  int _count = 0;
  while (_i >= 0 && _count < 2) {
    double _v = pow(10, VP_jpuRank[_i]);
    long _current = (long) (value / _v);
    value = value % _v;
    if (_current > 0) {
      _sb.append(_current);
      _sb.append(VP_jpu[_i]);
      _count++;
    }
    _i--;
  }
  return _sb.toString();
}
