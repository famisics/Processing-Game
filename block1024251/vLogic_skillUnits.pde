// それぞれのスキルのコード

// プロパシールド
boolean VU_isShield = false;
int VU_sheldTime = 0;
int VU_sheliDuration = 0;

void VU_shieldBoot(String duration) {
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

void VU_barExtendBoot(String duration) {
  VU_isBarExtend = true;
  VU_barExtendTime = GAME_clock;
  VU_barExtendDuration = parseInt(duration) * 1000;
  SB_barSize = 160;
}
void VU_barExtendUpdate() {
  if (VU_isBarExtend) {
    if (GAME_clock > VU_barExtendTime + VU_barExtendDuration) {
      SB_barSize = 80;
      VU_isBarExtend = false;
      VU_barExtendTime = 0;
    }
  }
}

// バー縮小
boolean VU_isBarContract = false;
int VU_barContractTime = 0;
int VU_barContractDuration = 0;

void VU_barContractBoot(String duration) {
  VU_isBarContract = true;
  VU_barContractTime = GAME_clock;
  VU_barContractDuration = parseInt(duration) * 1000;
  SB_barSize = 30;
}
void VU_barContractUpdate() {
  if (VU_isBarContract) {
    if (GAME_clock > VU_barContractTime + VU_barContractDuration) {
      SB_barSize = 80;
      VU_isBarContract = false;
      VU_barContractTime = 0;
    }
  }
}

// 時間減速
boolean VU_isTimeSlow = false;
int VU_timeSlowTime = 0;
int VU_timeSlowDuration = 0;

void VU_timeSlowBoot(String duration) {
  VU_isTimeSlow = true;
  VU_timeSlowTime = GAME_clock;
  VU_timeSlowDuration = parseInt(duration) * 1000;
  SB_gameSpeed = 0.3;
}
void VU_timeSlowUpdate() {
  if (VU_isTimeSlow) {
    if (GAME_clock > VU_timeSlowTime + VU_timeSlowDuration) {
      SB_gameSpeed = 1;
      VU_isTimeSlow = false;
      VU_timeSlowTime = 0;
    }
  }
}

// 時間加速
boolean VU_isTimeFast = false;
int VU_timeFastTime = 0;
int VU_timeFastDuration = 0;

void VU_timeFastBoot(String duration) {
  VU_isTimeFast = true;
  VU_timeFastTime = GAME_clock;
  VU_timeFastDuration = parseInt(duration) * 1000;
  SB_gameSpeed = 2;
}
void VU_timeFastUpdate() {
  if (VU_isTimeFast) {
    if (GAME_clock > VU_timeFastTime + VU_timeFastDuration) {
      SB_gameSpeed = 1;
      VU_isTimeFast = false;
      VU_timeFastTime = 0;
    }
  }
}

// ボールが2倍になる
int VU_ballDoubleTime = 0;
int VU_ballDoubleDuration = 0;

void VU_divisionBallBoot(String duration) {
  VU_ballDoubleTime = GAME_clock;
  VU_ballDoubleDuration = parseInt(duration) * 1000;
  for (int i = 0; i < SB_ballCount; i++) {
    SB_balls.get(i).division();
  }
}
