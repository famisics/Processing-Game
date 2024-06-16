// サイドパネル制御のロジック

void VP_Boot() {
  
}
void VP_update() {
  fill(20, 100, 80);
  rect(SB_blockWindowWidth, 0, GAME_width - SB_blockWindowWidth, GAME_height);
  fill(255);
  textAlign(LEFT, TOP);
  textFont(VP_fontScore);
  text(doubleToJp(SB_lastEnergy), float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 8 / 100);
  textFont(fontMd);
  text("獲得エネルギー", float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 3 / 100);
  textFont(VP_fontScoreMd);
  text(doubleToJp(DATA_ENERGY), float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 23 / 100);
  textFont(fontSm);
  text("累計エネルギー", float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 20 / 100);
  textFont(VP_fontScoreMd);
  text(doubleToJp(SB_inflationRate) + "倍", float(SB_blockWindowWidth) * 127 / 100, float(GAME_height) * 23 / 100);
  textFont(fontSm);
  text("インフレ倍率", float(SB_blockWindowWidth) * 127 / 100, float(GAME_height) * 20 / 100);
  textFont(fontMdsm);
  text("1 : シールド　　　　2 : バー拡張　　　　\n3 : 相手のバー縮小　4 : 時間減速　　　　\n5 : 相手の時間加速　6 : ボール分裂　　　\n7 : 支援砲撃　　　　8 : ブロック追加１　\n9 : ブロック追加２　0 : インフレ　　　　\nL : リスタート(デモ)\nI : インフレ(x2,デモ)\nP : ポーズ(デモ)", float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 33 / 100);
}
