// サイドパネル制御のロジック

void VP_Boot() {
  
}
void VP_update() {
  fill(20, 100, 80);
  rect(SB_blockWindowWidth, 0, GAME_width - SB_blockWindowWidth, GAME_height);
  fill(255);
  textAlign(LEFT, TOP);
  textFont(fontMd);
  text("獲得エネルギー", float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 3 / 100);
  text("累計エネルギー", float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 20 / 100);
  text("エネルギー獲得効率", float(SB_blockWindowWidth) * 127 / 100, float(GAME_height) * 20 / 100);
  text("プレイヤーレベル", float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 30 / 100);
  text("接続中のチャンネル (c : 変更)", float(SB_blockWindowWidth) * 127 / 100, float(GAME_height) * 30 / 100);
  textFont(VP_fontScore);
  text(doubleToJp(SB_lastEnergy), float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 8 / 100);
  textFont(VP_fontScoreMd);
  text(doubleToJp(DATA_ENERGY), float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 23 / 100);
  text(doubleToJp(SB_inflationRate * SB_inflationRateTemporary) + "倍", float(SB_blockWindowWidth) * 127 / 100, float(GAME_height) * 23 / 100);
  text(NET_channel, float(SB_blockWindowWidth) * 127 / 100, float(GAME_height) * 33 / 100);
  textSize(GAME_width / 58);
  text("Lv. " + doubleToJp(Math.ceil(SB_inflationRate / 1000)), float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 33 / 100);
  textFont(fontMdsm);
  text("1 : シールド　　　　2 : バー拡張　　　　\n3 : 相手のバー縮小　4 : 時間減速　　　　\n5 : 相手の時間加速　6 : ボール分裂　　　\n7 : 支援砲撃　　　　8 : ブロック追加１　\n9 : ブロック追加２　0 : インフレ　　　　\nL : リスタート(デモ)\nI : インフレ(x2,デモ)\nP : ポーズ(デモ)", float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 41 / 100);
}
