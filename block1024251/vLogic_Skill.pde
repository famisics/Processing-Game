// スキル制御のロジック

String[][] VS_skillTable;
int VS_clock = 0;
int VS_clockBefore = 0;

boolean VS_isDivision = false; // ボールを2倍にするスキルのフラグ

ArrayList<Skill> SB_skills = new ArrayList<>(); // スキルクラスを定義

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
  // スキルの更新
  Iterator<Skill> iterator = SB_skills.iterator();
  int i = 0;
  while(iterator.hasNext()) {
    Skill _skill = iterator.next();
    _skill.update(i);
    if(_skill.isEnable()) {
      i++;
    }
  }
}

void VS_skillRegister(String _id, String _acterName) { // *すべてのスキルはここに投げる
  if (SB_isTimeProcessing) {
    String[] _skillData = new String[0];
    for (int i = 1; i < VS_skillTable.length; i++) { // スキルテーブルからスキルを探し、発動対象を取得する
      if (VS_skillTable[i][0].equals(_id)) {
        _skillData = VS_skillTable[i];
        break;
      }
    }
    String _target = _skillData[1];
    // !重要 スキルの発動者と対象によるイベントの振り分け
    // !発火場所、残り時間表示、クールタイムの有無、発火する関数が複雑なので、if elseで分けています
    if (_acterName.equals(DATA_USERNAME) && _target.equals("self")) {
      // * 発動者が自分 + 対象が自分 = 自分のフィールドで発火、残り時間表示、クールタイムあり
      
      VS_skillRegister2(_id, _skillData, _acterName, true, true); // スキルの登録
      NET_send("skill",_id); // スキルの送信
      
    } else if (!_acterName.equals(DATA_USERNAME) && _target.equals("oppo")) {
      // * 発動者が相手 + 対象が自分 = 自分のフィールドで発火、残り時間表示、クールタイムなし
      
      VS_skillRegister2(_id, _skillData, _acterName, true, false); // スキルの登録
      
    } else if (_acterName.equals(DATA_USERNAME) && _target.equals("oppo")) {
      // * 発動者が自分 + 対象が相手 = 相手のフィールドで発火、残り時間なし、クールタイムあり
      
      VP_message(_skillData[5] + "を発動しました"); // メッセージ表示
      NET_send("skill",_id); // スキルの送信
      
    } else if (!_acterName.equals(DATA_USERNAME) && _target.equals("self")) {
      // * 発動者が相手 + 対象が相手 = 相手のフィールドで発火、残り時間なし、クールタイムなし
      
      VP_message(_acterName + "が" + _skillData[5] + "を発動しました"); // メッセージ表示
      
    }
  }
}
void VS_skillRegister2(String _id, String[] _skillData, String _acterName, boolean _isDisplayMonitor, boolean _isBlockDuplicate) {
  boolean isDuplicate = false;
  for (Skill _skill : SB_skills) {
    if (_skill._skillId.equals(_id) && _skill.isEnable()) {
      println("[skill] このスキルはクールタイム中です");
      VP_message("このスキルはクールタイム中です");
      isDuplicate = true;
    }
  }
  if (!isDuplicate || (isDuplicate && !_isBlockDuplicate)) {
    SB_skills.add(new Skill(_skillData, _acterName, _isDisplayMonitor));
  }
}
