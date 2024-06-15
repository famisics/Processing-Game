// サイドパネル制御のロジック

String[] VP_japaneseUnits = {"", "万", "億", "兆", "京", "垓"}; // 1000京以上の値は計算が難しいので京までに対応する

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
  textFont(fontMd);
  text(VP_longToJapanese(DATA_ENERGY), float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 23 / 100);
  textFont(fontSm);
  text("累計エネルギー", float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 20 / 100);
  textFont(fontMd);
  text( VP_longToJapanese((long)SB_inflationRate)+"倍", float(SB_blockWindowWidth) * 127 / 100, float(GAME_height) * 23 / 100);
  textFont(fontSm);
  text("インフレ倍率", float(SB_blockWindowWidth) * 127 / 100, float(GAME_height) * 20 / 100);
}

String VP_longToJapanese(long _long) {
  String _result = "";
  String[] _results = {};
  String _string = String.valueOf(_long);
  int _length = _string.length();
  int _i = 0;
  while(_length > 0) {
    String _t = _string.substring(max(0, _length - 4), _length);
    _results = append(_results, _t + VP_japaneseUnits[_i]);
    _length -= 4;
    _i++;
  }
  int _rLength = _results.length;
  if (_rLength == 1) {
    return _results[0];
  } else if (_rLength == 2) {
    return _results[1] + _results[0];
  } else if (_rLength > 2) {
    String _r = _results[_rLength - 1] + _results[_rLength - 2];
    if (_r.equals("922京3372兆")) _r = "infinite";
      return _r;
  } else {
    return "0";
  }
}
