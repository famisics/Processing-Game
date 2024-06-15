// スキルの個別のロジック
VU_activeSkills[][] = {
  {"name", "残り時間", "合計時間"}
}
// TODO:パネルの空きスペースにリストっぽく表示するようにする、メーターつき

VU_addActiveSkill(String name, float nokori, float total) {
  VU_activeSkills.push({name, nokori, total});
}
VU_activeSkillUpdate() {
  // TODO:終わったものは削除
}

// shield
boolean VU_isShield = false;
int VU_sheldTimer = 0;

void VU_shieldBoot() {
  VU_isShield = true;
  VU_sheldTimer = GAME_clock;
}
void VU_sheldUpdate() {
  if (VU_isShield) {
    VU_sheldTimer++;
    if (GAME_clock > VU_sheldTimer + (30 * 1000)) {
      VU_isShield = false;
      VU_sheldTimer = 0;
    }
  }
}
