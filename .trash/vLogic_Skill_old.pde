// スキル制御のロジック

// 有効なスキルのリスト
// ArrayList<ActiveSkill> VS_activeSkills = new ArrayList<>();


void VS_update() {
  // スキルタイマー
  VS_activeSkillUpdate();
  // スキルの処理
  VU_sheldUpdate();
  VU_barExtendUpdate();
  VU_barContractUpdate();
  VU_timeSlowUpdate();
  VU_timeFastUpdate();
  // カットイン
  VS_cutinUpdate();
}



// TODO:必要エネルギーが足りない場合の処理
void VS_self(String[] i) { // 自分側で発動するスキル
  if (VS_addActiveSkill(i[5], GAME_clock, float(i[2]) * 1000)) return; // スキルの追加が失敗した場合は処理を終了する
  if (!i[4].equals("")) VS_cutin(i[4], i[5], "");
  switch(i[0]) {
    case "1" :
      VU_shieldBoot(i[2]);
      break;
    case "2" :
      VU_barExtendBoot(i[2]);
      break;
    // case "3" : // TODO:相手
    //   VU_barContractBoot(i[2]);
    //   break;
    case "4" : 
      VU_timeSlowBoot(i[2]);
      break;
    // case "5" : // TODO:相手
    //   VU_timeFastBoot(i[2]);
    //   break;
    case "6" :
      VU_divisionBallBoot(i[2]);
      break;
    case "7" :
      VU_bomb();
      break;
    case "8" :
      VU_mine1Boot();
      break;
    case "9" :
      VU_mine2Boot();
      break;
    case "0" :
      VU_inflationBoostBoot(i[2]);
    default :
    println("[skill] 規定外のデータであるため破棄されました");
    break;
  }
}

// !有効なスキルの管理

boolean VS_addActiveSkill(String _name, float _start, float _duration) { // スキルの追加かつ追加が可能かどうかを確認
  for (ActiveSkill _skill : VS_activeSkills) {
    if (_skill.name.equals(_name)) {
      return true; // スキルの追加に失敗した場合trueを返す
    }
  }
  VS_activeSkills.add(new ActiveSkill(_name, _start, _duration));
  return false;
}

void VS_activeSkillUpdate() {
  Iterator<ActiveSkill> _i = VS_activeSkills.iterator();
  while(_i.hasNext()) {
    ActiveSkill _skill = _i.next();
    float end = _skill.start + _skill.duration;
    int _index = VS_activeSkills.indexOf(_skill);
    if (GAME_clock >= end) {
      _i.remove();
    } else {
      VS_activeSkillDisplay(_index, _skill.name, _skill.start, _skill.duration);
    }
  }
}

void VS_activeSkillDisplay(int _index, String _name, float _start, float _duration) {
  float _elapsed = GAME_clock - _start;
  float _remain = _duration - _elapsed;
  fill(20, 50, 150);
  rect(SB_blockWindowWidth,(GAME_height * (18 - (2 * _index)) / 20) - GAME_width / 50, GAME_width - SB_blockWindowWidth, GAME_height / 10);
  fill(20, 200, 250);
  rect(SB_blockWindowWidth + (GAME_width - SB_blockWindowWidth) * (_elapsed / _duration),(GAME_height * (39 - (4 * _index)) / 40) - GAME_width / 50,(GAME_width - SB_blockWindowWidth) * (_remain / _duration), GAME_height / 40);
  fill(255);
  textAlign(LEFT);
  textFont(fontMd);
  text(_name + " : ( " + String.format("%.0f", Math.ceil(_remain / 1000)) + "秒 / " + String.format("%.0f", Math.ceil(_duration / 1000)) + "秒 )", SB_blockWindowWidth + GAME_width / 50,(GAME_height * (9 - _index) / 10) - GAME_width / 50 + GAME_height / 20);
}

class ActiveSkill { // スキル管理用のクラス
  String name;
  float start;
  float duration;
  ActiveSkill(String name, float start, float duration) {
    this.name = name;
    this.start = start;
    this.duration = duration;
  }
}

