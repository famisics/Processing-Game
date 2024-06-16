// スキルの個別のロジック
ArrayList<ActiveSkill> VU_activeSkills = new ArrayList<>();

// TODO:パネルの空きスペースにリストっぽく表示するようにする、メーターつき

void VU_addActiveSkill(String name, float start, float duration) {
  for (ActiveSkill skill : VU_activeSkills) {
    if (skill.name.equals(name)) {
      println("Skill " + name + " is already active");
      return; // 同じ名前のスキルが既に存在する場合は追加しない
    }
  }
  VU_activeSkills.add(new ActiveSkill(name, start, duration));
}

void VU_activeSkillUpdate() {
  Iterator<ActiveSkill> _i = VU_activeSkills.iterator();
  while(_i.hasNext()) {
    ActiveSkill _skill = _i.next();
    float end = _skill.start + _skill.duration;
    int _index = VU_activeSkills.indexOf(_skill);
    if (GAME_clock >= end) {
      _i.remove();
    } else {
      VU_activeSkillDisplay(_index, _skill.name, _skill.start, _skill.duration);
    }
  }
}

void VU_activeSkillDisplay(int _index, String _name, float _start, float _duration) {
  float _elapsed = GAME_clock - _start;
  float _remain = _duration - _elapsed;
  fill(20, 50, 150);
  rect(SB_blockWindowWidth,(GAME_height * (18 - (2 * _index)) / 20) - GAME_width / 50, GAME_width - SB_blockWindowWidth, GAME_height / 10);
  fill(20, 200, 250);
  rect(SB_blockWindowWidth + (GAME_width - SB_blockWindowWidth) * (_elapsed / _duration),(GAME_height * (39 - (4 * _index)) / 40) - GAME_width / 50,(GAME_width - SB_blockWindowWidth) * (_remain / _duration), GAME_height / 40);
  fill(255);
  textAlign(LEFT);
  textFont(fontMd);
  text(_name + " : ( " + _remain + "秒 / " + _duration + "秒 )", SB_blockWindowWidth + GAME_width / 50,(GAME_height * (9 - _index) / 10) - GAME_width / 50 + GAME_height / 20);
}

class ActiveSkill {
  String name;
  float start;
  float duration;
  ActiveSkill(String name, float start, float duration) {
    this.name = name;
    this.start = start;
    this.duration = duration;
  }
}


// プロパシールド
boolean VU_isShield = false;
int VU_sheldTime = 0;
int VU_sheliDuration = 0;

void VU_shieldBoot(String duration, String name) {
  VU_isShield = true;
  VU_sheldTime = GAME_clock;
  VU_sheliDuration = parseInt(duration) * 1000;
  VU_addActiveSkill(name, GAME_clock, VU_sheliDuration);
}
void VU_sheldUpdate() {
  if (VU_isShield) {
    VU_sheldTime++;
    if (GAME_clock > VU_sheldTime + VU_sheliDuration) {
      VU_isShield = false;
      VU_sheldTime = 0;
    }
  }
}

// バー拡張
boolean VU_isBarExtend = false;
int VU_barExtendTime = 0;
int VU_barExtendDuration = 0;

void VU_barExtendBoot(String duration, String name) {
  VU_isBarExtend = true;
  VU_barExtendTime = GAME_clock;
  VU_barExtendDuration = parseInt(duration) * 1000;
  VU_addActiveSkill(name, GAME_clock,VU_barExtendDuration);
  SB_barSize = 100;
}
void VU_barExtendUpdate() {
  if (VU_isBarExtend) {
    VU_barExtendTime++;
    if (GAME_clock > VU_barExtendTime + VU_barExtendDuration) {
      SB_barSize = 50;
      VU_isBarExtend = false;
      VU_barExtendTime = 0;
    }
  }
}
