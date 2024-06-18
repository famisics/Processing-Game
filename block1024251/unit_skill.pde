class Skill {
  String _skillName;
  String _skillNameJp;
  int _skillStartTime; // TODO: ゲーム時間(ポーズ時停止)が必要
  int _skillDulation;
  String _skillActer;
  int _skillEnergy;
  
  Skill(String スキルネーム, String 日本語スキル名, String 発動対象, int 継続時間, int 必要エネルギー, ) {
    this._skillName = スキルネーム; // 兼カットイン画像URL
    this._skillNameJp = 日本語スキル名;
    this._skillActer = 発動対象;
    this._skillDulation = 継続時間;
    this._skillEnergy = 必要エネルギー;
    this._skillStartTime = 0;
  }
  
  void boot() {
    switch (_skillName) {
      case "shield":
        B_shield();
        break;
      case "extend":
        B_barExtend();
        break;
      case "contract":
        B_barContract();
        break;
      case "slow":
        B_speedDown();
        break;
      case "fast":
        B_speedUp();
        break;
      case "division":
        B_ballDivision();
        break;
      case "bomb":
        B_bomb();
        break;
      case "mine1":
        B_mine1();
        break;
      case "mine2":
        B_mine2();
        break;
      case "magic":
        B_inflationBoost();
        break;
      default:
        break;
    }
  }
  void update() {
    switch (_skillName) {
      case "shield":
        U_shield();
        break;
      case "extend":
        U_barExtend();
        break;
      case "contract":
        U_barContract();
        break;
      case "slow":
        U_speedDown();
        break;
      case "fast":
        U_speedUp();
        break;
      case "division":
        U_ballDivision();
        break;
      case "bomb":
        U_bomb();
        break;
      case "mine1":
        U_mine1();
        break;
      case "mine2":
        U_mine2();
        break;
      case "magic":
        U_inflationBoost();
        break;
      default:
        break;
    }
  }
  // boot
  void B_shield() {

  }
  void B_barExtend() {

  }
  void B_barContract() {

  }
  void B_speedDown() {

  }
  void B_speedUp() {

  }
  void B_ballDivision() {

  }
  void B_bomb() {

  }
  void B_mine1() {

  }
  void B_mine2() {

  }
  void B_inflationBoost() {

  }
  // update
  void U_shield() {

  }
  void U_barExtend() {

  }
  void U_barContract() {

  }
  void U_speedDown() {

  }
  void U_speedUp() {

  }
  void U_ballDivision() {

  }
  void U_bomb() {

  }
  void U_mine1() {

  }
  void U_mine2() {

  }
  void U_inflationBoost() {

  }
}
