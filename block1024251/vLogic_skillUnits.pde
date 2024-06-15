// スキルの個別のロジック

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
    println("shield作動中");
    if (GAME_clock > VU_sheldTimer + (30 * 1000)) {
      VU_isShield = false;
      VU_sheldTimer = 0;
    }
  }
}
