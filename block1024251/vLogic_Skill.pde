// スキル制御のロジック

PImage VS_cutinImage;
int VS_cutinImageMaskRad; // 角の丸みの半径
String[][] VS_skillTable;
boolean VS_isCutin = false;
boolean VS_isCutinSlideIn = true;
boolean VS_isCutinSlideOut = false;
int VS_cutinTime;
float VS_cutinX;
float VS_cutinDX;
int VS_cutinSizeX;
int VS_cutinSizeY;

// 有効なスキルのリスト
ArrayList<ActiveSkill> VS_activeSkills = new ArrayList<>();

void VS_boot() { // スキル一覧の読み込み
  String[] _csv = loadStrings("src/skills.csv");
  VS_skillTable = new String[_csv.length][];
  for (int i = 0; i < _csv.length; i++) {
    VS_skillTable[i] = split(_csv[i], ',');
  }
  VS_cutinX = GAME_width;
  VS_cutinDX = GAME_width / 20;
  VS_cutinSizeX = GAME_width / 3;
  VS_cutinSizeY = GAME_width / 6;
  VS_cutinImageMaskRad = GAME_width / 20;
  VS_cutinImage = loadImage("src/images/skill/demo.png");
  VU_boot();
}
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
void VS_skillSend(String _id) { // スキル送信
  for (int i = 1; i < VS_skillTable.length; i++) { // 0行目は説明なので飛ばす
    if (VS_skillTable[i][0].equals(_id)) {
      NET_send("skill",_id);
      break;
    }
  }
}
void VS_skillRecv(String _id, String _acterName) { // スキル受信
  for (int i = 1; i < VS_skillTable.length; i++) { // 0行目は説明なので飛ばす
    if (VS_skillTable[i][0].equals(_id)) {
      VS_skill(VS_skillTable[i], _acterName);
      break;
    }
  }
}
void VS_skill(String[] i, String _acterName) {
  if (i[1].equals("self")) {
    VS_self(i);
  } else if (i[1].equals("oppo")) {
    VS_oppo(i);
  } else if (i[1].equals("all")) {
    VS_self(i);
    VS_oppo(i);
  } else {
    println("[skill] 規定外のデータであるため破棄されました");
  }
}
void VS_oppo(String[] i) { // 相手側で発動するスキル
  if (!i[4].equals("")) VS_cutin(i[4], i[5], "");//TODO:なんとかする
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

// !カットイン

// スキルカットイン画像は横2縦1比率
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
void VS_cutinUpdate() {
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
  if(_acterName != "") _pg.text(_acterName+"が発動", _rawImg.width / 2, _rawImg.height * 3 / 6);
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
