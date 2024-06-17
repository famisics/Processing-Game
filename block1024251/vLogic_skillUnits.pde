// それぞれのスキルのコード

void VU_boot() {
  // TODO:すべての値を初期化
}

// プロパシールド
boolean VU_isShield = false;
int VU_sheldTime = 0;
int VU_sheliDuration = 0;

void VU_shieldBoot(String _duration) {
  VU_isShield = true;
  VU_sheldTime = GAME_clock;
  VU_sheliDuration = parseInt(_duration) * 1000;
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

void VU_barExtendBoot(String _duration) {
  VU_isBarExtend = true;
  VU_barExtendTime = GAME_clock;
  VU_barExtendDuration = parseInt(_duration) * 1000;
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

void VU_barContractBoot(String _duration) {
  VU_isBarContract = true;
  VU_barContractTime = GAME_clock;
  VU_barContractDuration = parseInt(_duration) * 1000;
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

void VU_timeSlowBoot(String _duration) {
  VU_isTimeSlow = true;
  VU_timeSlowTime = GAME_clock;
  VU_timeSlowDuration = parseInt(_duration) * 1000;
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

void VU_timeFastBoot(String _duration) {
  VU_isTimeFast = true;
  VU_timeFastTime = GAME_clock;
  VU_timeFastDuration = parseInt(_duration) * 1000;
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

void VU_divisionBallBoot(String _duration) {
  VU_ballDoubleTime = GAME_clock;
  VU_ballDoubleDuration = parseInt(_duration) * 1000;
  for (int i = 0; i < SB_ballCount; i++) {
    SB_balls.get(i).division();
  }
}

// 支援砲撃
void VU_bomb() {
  // image1 = loadImage("bomb.png"); //TODO: 爆撃画像の読み込みと表示
  for (int x = 0; x < 12; x++) {
    for (int y = 0; y < 10; y++) {
      VU_bombBlock(x,y);
    }
  }
}

void VU_bombBlock(int x, int y) {
  if (SB_blocks[x][y] > 0) {
    float r = random(0, 1);
    if (r > 0.5) {
      int l = (int)Math.ceil(SB_blocks[x][y] - (SB_blocksLife / 2));
      if (r < 0) r = 0;
      SB_blocks[x][y] = l;
    }
  }
}

// 追加任務Lv1

void VU_mine1Boot() {

}

// 追加任務Lv2
void VU_mine2Boot() {

}

// インフレゲー？
double VU_inflationBoostRate = 1;
int VU_inflationBoostTime = 0;
int VU_inflationBoostDuration = 0;

void VU_inflationBoostBoot(double _rate, String _duration) {
  VU_inflationBoostTime = GAME_clock;
  VU_inflationBoostDuration = parseInt(_duration) * 1000;
  VU_inflationBoostRate = _rate;
}
