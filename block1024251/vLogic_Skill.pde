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
}
void VS_update() {
  VS_cutinUpdate(); // カットイン
}
void VS_skillSend(String _id) { // スキル送信
  NET_send("skill," + _id);
}
void VS_skillRecv(String _id) { // スキル受信
  for (int i = 1; i < VS_skillTable.length; i++) { // 0行目は説明なので飛ばす
    if (VS_skillTable[i][0].equals(_id)) {
      VS_skill(VS_skillTable[i]);
      break;
    }
  }
}
void VS_skill(String[] i) {
  if (i[1].equals("self")) {
    VS_self(i);
  } else if (i[1].equals("oppo")) {
    VS_oppo(i);
  } else if (i[1].equals("all")) {
    VS_self(i);
    VS_oppo(i);
  } else {
    println("[ERROR] 謎のスキルです");
  }
}
void VS_oppo(String[] i) { // 相手側で発動するスキル
  println("VS_oppo " + i[0] + "," + i[1] + "," + i[2] + "," + i[3] + "," + i[4] + "," + i[5] + "," + i[6]);
  if (!i[6].equals("")) VS_cutin(i[6]);
}
void VS_self(String[] i) { // 自分側で発動するスキル
  println("VS_self " + i[0] + "," + i[1] + "," + i[2] + "," + i[3] + "," + i[4] + "," + i[5] + "," + i[6]);
  if (!i[6].equals("")) VS_cutin(i[6]);
}

// スキルカットイン画像は横2縦1比率
void VS_cutin(String i) {
  if(VS_isCutin) {
    VS_cutinX = GAME_width;
    VS_isCutinSlideOut = false;
    VS_isCutinSlideIn = true;
    VS_cutinDX = GAME_width / 20;
  }
  VS_cutinImage = createRoundedImage(i);
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
PImage createRoundedImage(String i) {
  PImage _rawImg = loadImage("src/images/skill/" + i + ".png");
  PGraphics _pg = createGraphics(_rawImg.width, _rawImg.height);
  _pg.beginDraw();
  _pg.background(0, 0);
  _pg.noStroke();
  _pg.fill(255);
  _pg.rectMode(CORNER);
  _pg.beginShape();
  _pg.vertex(VS_cutinImageMaskRad, 0);
  _pg.vertex(_rawImg.width, 0); // 右上の角
  _pg.vertex(_rawImg.width, _rawImg.height); // 右下の角
  _pg.vertex(VS_cutinImageMaskRad, _rawImg.height);
  _pg.quadraticVertex(0, _rawImg.height, 0, _rawImg.height - VS_cutinImageMaskRad); // 左下の角を丸くする
  _pg.vertex(0, VS_cutinImageMaskRad);
  _pg.quadraticVertex(0, 0, VS_cutinImageMaskRad, 0); // 左上の角を丸くする
  _pg.endShape(CLOSE);
  _pg.endDraw();
  PImage _maskedImage = createImage(_rawImg.width, _rawImg.height, ARGB);
  _rawImg.mask(_pg);
  _maskedImage.copy(_rawImg, 0, 0, _rawImg.width, _rawImg.height, 0, 0, _rawImg.width, _rawImg.height);
  return _maskedImage;
}
