// サイドパネル制御のロジック

int VP_messageTime = 0; // ブロック崩の起動時間 
boolean VP_isMessage = false; // ブロック崩しの起動状態
String VP_messageText = ""; // ブロック崩しの起動メッセージ

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
  text(VP_scoreBoard(), float(SB_blockWindowWidth) * 103 / 100, float(GAME_height) * 41 / 100);
  textAlign(CENTER, TOP);
  text("1 : シールド　　　　2 : バー拡張　　　　\n3 : 相手のバー縮小　4 : 時間減速　　　　\n5 : 相手の時間加速　6 : ボール分裂　　　\n7 : 支援砲撃　　　　8 : ブロック追加１　\n9 : ブロック追加２　0 : インフレ　　　　\nL : リスタート(デモ)\nI : インフレ(x2,デモ)\nP : ポーズ(デモ)", float(SB_blockWindowWidth) / 2, float(GAME_height) * 41 / 100);
  VP_messageUpdate();
}
String[][] VP_users = {
  {"userA", "1万8000"} ,
  {"userB", "2億9200万"} ,
  {"userC", "1億2000万"} ,
  {"userD", "1億8000万"}
};
String VP_scoreBoard() {
  String _r = "";
  for (int i = 0; i < VP_users.length; ++i) {
    _r += VP_users[i][0] + " : " + VP_users[i][1] + " E\n";
  }
  return _r;
}
void VP_scoreRecv(String _score, String _acterName) {
  for (int i = 0; i < VP_users.length; ++i) {
    if (VP_users[i][0].equals(_acterName)) {
      VP_users[i][1] = _score;
      return;
    }
  }
  String[][] _new = new String[VP_users.length + 1][2];
  for (int i = 0; i < VP_users.length; ++i) {
    _new[i][0] = VP_users[i][0];
    _new[i][1] = VP_users[i][1];
  }
  _new[VP_users.length][0] = _acterName;
  _new[VP_users.length][1] = _score;
  VP_users = _new;
}

void VP_message(String i) {
  VP_messageText = i;
  VP_messageTime = GAME_clock;
  VP_isMessage = true;
}
void VP_messageUpdate() {
  if (VP_isMessage) {
    fill(0, 200);
    rect(GAME_width * 4 / 10, GAME_height * 9 / 20, width / 5, height / 10);
    fill(255);
    textAlign(CENTER, CENTER);
    textFont(fontMd);
    text(i, GAME_width * 4 / 10, GAME_height * 9 / 20, width / 5, height / 10);
    if (GAME_clock - VP_messageTime > 1500) {
      VP_isMessage = false;
    }
  }
}
