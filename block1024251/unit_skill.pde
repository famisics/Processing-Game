// シールド
boolean US_isShield = false;

class Skill {
  boolean _isFire = false;
  String _skillName;
  String _skillNameJp;
  int _skillStartTime; // TODO: ゲーム時間(ポーズ時停止)が必要
  int _skillDulation;
  String _skillTarget;
  String _skillActer;
  int _skillEnergy;
  
  // カットイン
  boolean VS_isCutin = false;
  boolean VS_isCutinSlideIn = true;
  boolean VS_isCutinSlideOut = false;
  int VS_cutinTime;
  float VS_cutinX = GAME_width;
  float VS_cutinDX = GAME_width / 20;
  int VS_cutinSizeX = GAME_width / 3;
  int VS_cutinSizeY = GAME_width / 6;
  PImage VS_cutinImage = loadImage("src/images/skill/demo.png");
  int VS_cutinImageMaskRad = GAME_width / 20;
  
  Skill(String スキルネーム, String 日本語スキル名, String 発動対象, int 継続時間秒, int 必要エネルギー, String 発動者) {
    this._skillName = スキルネーム; // 兼カットイン画像URL
    this._skillNameJp = 日本語スキル名;
    this._skillTarget = 発動対象;
    this._skillActer = 発動者;
    this._skillDulation = parseInt(継続時間秒) * 1000;
    this._skillEnergy = 必要エネルギー;
    this._skillStartTime = VS_clock; // スキル時間を取得
  }
  
  void boot() {
    // 発火する場所が相手か自分か
    if ((_skillActer.equals(DATA_USERNAME) && _skillTarget.equals("self")) || (!DATA_USERNAME.equals(DATA_USERNAME) && _skillTarget.equals("oppo"))) {
      start(); // 発火
    } else {
      if (_skillActer.equals(DATA_USERNAME)) {
        VP_message(_skillNameJp + "を発動しました");
      } else {
        VP_message(_acterName + "が" + _skillNameJp + "を発動しました");
      }
    }
  }
  void start() {
    _isFire = true;
    // スキルごとの動作
    switch(_skillName) {
      case "shield":
        US_isShield = true;
        break;
      case "extend" :
        SB_barSize = 160;
        break;
      case "contract" :
        SB_barSize = 40;
        break;
      case "slow" : break;
      case "fast" : break;
      case "division" : break;
      case "bomb" : break;
      case "mine1" : break;
      case "mine2" : break;
      case "magic" : break;
      default : break;
    }
  }
  void end() {
    _isFire = false;
    // スキルごとの動作
    switch(_skillName) {
      case "shield":
        US_isShield = false;
        break;
      case "extend" :
        SB_barSize = 80;
        break;
      case "contract" :
        SB_barSize = 80;
        break;
      case "slow" : break;
      case "fast" : break;
      case "division" : break;
      case "bomb" : break;
      case "mine1" : break;
      case "mine2" : break;
      case "magic" : break;
      default : break;
    }
    Skills.remove(this);
  }
  void update() {
    // タイマーの更新
    if (VS_clock > _skillStartTime + _skillDulation) {
      end();
      return;
    }
    
    // スキルごとの動作
    switch(_skillName) {
      case "shield" : break;
      case "extend" : break;
      case "contract" : break;
      case "slow" : break;
      case "fast" : break;
      case "division" : break;
      case "bomb" : break;
      case "mine1" : break;
      case "mine2" : break;
      case "magic" : break;
      default : break;
    }
  }
  
  //!カットイン
  
  //スキルカットイン画像は横2縦1比率
  void VS_cutin(String _imagePath, String _skillName, String _acterName) {
    if (VS_isCutin) {
      VS_cutinX = GAME_width;
      VS_isCutinSlideOut = false;
      VS_isCutinSlideIn = true;
      VS_cutinDX = GAME_width / 20;
    }
    VS_cutinImage = VS_createRoundedImage(_imagePath, _skillName, _acterName);
    VS_isCutin = true;
  }
  voidVS_cutinUpdate() {
    if (VS_isCutin) { // カットイン処理
      // slideIn
      if (VS_isCutinSlideIn) {
        VS_cutinX -= VS_cutinDX;
        VS_cutinDX -= float(GAME_width) / 225.0;
        if (VS_cutinDX < float(GAME_width) / 225.0) VS_cutinDX = float(GAME_width) / 225.0;
        if (VS_cutinX <= GAME_width * 2 / 3) {
          VS_cutinX = GAME_width * 2 / 3;
          VS_isCutinSlideIn = false;
          VS_cutinTime = millis();
        }
      }
      // slideOut開始
      if (!VS_isCutinSlideIn && !VS_isCutinSlideOut && millis() - VS_cutinTime > 3000) {
        VS_cutinDX = GAME_width / 20;
        VS_isCutinSlideOut = true;
      }
      // slideOut
      if (VS_isCutinSlideOut) {
        VS_cutinX += VS_cutinDX;
        VS_cutinDX -= float(GAME_width) / 225.0;
        if (VS_cutinDX < float(GAME_width) / 225.0) VS_cutinDX = float(GAME_width) / 225.0;
        if (VS_cutinX >= GAME_width) {
          VS_isCutinSlideOut = false;
          VS_isCutinSlideIn = true;
          VS_cutinDX = GAME_width / 20;
          VS_isCutin = false;
        }
      }
      image(VS_cutinImage, VS_cutinX,(VS_cutinSizeX) / 2, VS_cutinSizeX, VS_cutinSizeY);
    }
  }
  PImage VS_createRoundedImage(String _imagePath, String _skillName, String _acterName) {
    PImage _rawImg = loadImage("src/images/skill/" + _imagePath + ".png");
    PGraphics _pg = createGraphics(_rawImg.width, _rawImg.height);
    _pg.beginDraw();
    _pg.image(_rawImg, 0, 0);
    _pg.fill(0, 150);
    _pg.rect(0, _rawImg.height / 2, _rawImg.width, _rawImg.height / 2);
    _pg.fill(255); // テキストの色
    _pg.textAlign(CENTER, CENTER);
    _pg.textFont(createFont("src/fonts/kaiso.otf", GAME_width / 15));
    _pg.text(_skillName, _rawImg.width / 2, _rawImg.height * 5 / 6);
    if (_acterName != "") _pg.text(_acterName + "が発動", _rawImg.width / 2, _rawImg.height * 3 / 6);
    _pg.endDraw();
    
    PGraphics _mask = createGraphics(_rawImg.width, _rawImg.height);
    _mask.beginDraw();
    _mask.background(0, 0);
    _mask.noStroke();
    _mask.fill(255);
    _mask.rectMode(CORNER);
    _mask.beginShape();
    _mask.vertex(VS_cutinImageMaskRad, 0);
    _mask.vertex(_rawImg.width, 0); // 右上の角
    _mask.vertex(_rawImg.width, _rawImg.height); // 右下の角
    _mask.vertex(VS_cutinImageMaskRad, _rawImg.height);
    _mask.quadraticVertex(0, _rawImg.height, 0, _rawImg.height - VS_cutinImageMaskRad); // 左下の角を丸くする
    _mask.vertex(0, VS_cutinImageMaskRad);
    _mask.quadraticVertex(0, 0, VS_cutinImageMaskRad, 0); // 左上の角を丸くする
    _mask.endShape(CLOSE);
    _mask.endDraw();
    PImage _maskedImage = _pg.get();
    _maskedImage.mask(_mask);
    return _maskedImage;
  }
}
