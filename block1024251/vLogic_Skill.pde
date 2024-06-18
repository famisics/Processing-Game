// スキル制御のロジック

String[][] VS_skillTable;
int VS_clock = 0;
int VS_clockBefore = 0;

ArrayList<Skill> Skills = new ArrayList<>(); // スキルクラスを定義

void VS_boot() {
  // スキル一覧の読み込み
  String[] _csv = loadStrings("src/skills.csv");
  VS_skillTable = new String[_csv.length][];
  for (int i = 0; i < _csv.length; i++) {
    VS_skillTable[i] = split(_csv[i], ',');
  }
  VS_clock = 0;
  VS_clockBefore = GAME_clock;
}

void VS_update() {
  // 時間が進行中の時のみスキルの時間を進める
  if (SB_isTimeProcessing) {
    int _diff = GAME_clock - VS_clockBefore;
    VS_clock += _diff;
  }
  VS_clockBefore = GAME_clock;
}

// ネットワーク関連
void VS_skillSend(String _id) { // スキル送信
  for (int i = 1; i < VS_skillTable.length; i++) { // 0行目は説明なので飛ばす
    if (VS_skillTable[i][0].equals(_id)) {
      NET_send("skill",_id);
      break;
    }
  }
}
void VS_skillRecv(String _id, String _acterName) { // スキル受信
  for (int i = 1; i < VS_skillTable.length; i++) { // 0行目は説明なので飛ばす
    if (VS_skillTable[i][0].equals(_id)) {
      VS_skill(VS_skillTable[i], _acterName);
      break;
    }
  }
}
// _skill = {id, 発動対象, 発動時間, 必要エネルギー, スキルネーム(カットイン画像), スキル日本語名, スキル日本語説明}
void VS_skill(String[] _skill, String _acterName) {
  if (_skill[1].equals("self")) {
    VS_self(_skill, _acterName);
  } else if (_skill[1].equals("oppo")) {
    VP_message(_acterName + " が" + i[5] + "を発動しました");
    VS_addSKill(_skill, _acterName);
  } else {
    println("[skill] 規定外のデータであるため破棄されました");
  }
}
void VS_self(String[] i, String _acterName) {

}
