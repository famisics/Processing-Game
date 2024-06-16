// それぞれのスキルのコード

// プロパシールド
boolean VU_isShield = false;
int VU_sheldTime = 0;
int VU_sheliDuration = 0;

void VU_shieldBoot(String duration, String name) {
  VU_isShield = true;
  VU_sheldTime = GAME_clock;
  VU_sheliDuration = parseInt(duration) * 1000;
}
void VU_sheldUpdate() {
  if (VU_isShield) {
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
  SB_barSize = 100;
}
void VU_barExtendUpdate() {
  if (VU_isBarExtend) {
    if (GAME_clock > VU_barExtendTime + VU_barExtendDuration) {
      SB_barSize = 50;
      VU_isBarExtend = false;
      VU_barExtendTime = 0;
    }
  }
}
