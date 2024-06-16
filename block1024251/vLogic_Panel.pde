// サイドパネル制御のロジック

void VP_Boot() {
  
}
void VP_update() {
  fill(20, 100, 80);
  rect(SB_blockWindowWidth, 0, GAME_width - SB_blockWindowWidth, GAME_height);
  fill(255);
  textAlign(LEFT, TOP);
  textFont(VP_fontScore);
  text(longToJp(SB_lastEnergy), float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 8 / 100);
  textFont(fontMd);
  text("獲得エネルギー", float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 3 / 100);
  textFont(VP_fontScoreMd);
  text(longToJp(DATA_ENERGY), float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 23 / 100);
  textFont(fontSm);
  text("累計エネルギー", float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 20 / 100);
  textFont(VP_fontScoreMd);
  text(longToJp(SB_inflationRate) + "倍", float(SB_blockWindowWidth) * 127 / 100, float(GAME_height) * 23 / 100);
  textFont(fontSm);
  text("インフレ倍率", float(SB_blockWindowWidth) * 127 / 100, float(GAME_height) * 20 / 100);
}
