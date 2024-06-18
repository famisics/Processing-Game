class Skill {
  String _skillId;
  String _skillName;
  String _skillNameJp;
  int _skillStartTime;
  boolean _isDisplayMonitor;
  int _skillDulation;
  String _skillTarget;
  String _skillActer;
  double _skillEnergy;
  
  // カットイン
  boolean _isCutin = false;
  boolean _isCutinSlideIn = true;
  boolean _isCutinSlideOut = false;
  int _cutinTime;
  float _cutinX = GAME_width;
  float _cutinDX = GAME_width / 20;
  int _cutinSizeX = GAME_width / 3;
  int _cutinSizeY = GAME_width / 6;
  PImage _cutinImage = loadImage("src/images/skill/demo.png");
  int _cutinImageMaskRad = GAME_width / 20;
  
  //* _skillData = {id, 発動対象, 継続時間(兼クールタイム), 必要エネルギー, スキルネーム(カットイン画像path), スキル日本語名, スキル日本語説明}
  Skill(String[] _skillData, String _acter, boolean _isDisplayMonitor) {
    this._skillId = _skillData[0];
    this._skillName = _skillData[4]; // 兼カットイン画像URL
    this._skillNameJp = _skillData[5];
    this._skillTarget = _skillData[1];
    this._skillActer = _acter;
    this._isDisplayMonitor = _isDisplayMonitor; // サイドバーの時間表示に表示するかどうか
    this._skillDulation = parseInt(_skillData[2]) * 1000;
    this._skillEnergy = Double.parseDouble(_skillData[3]);
    this._skillStartTime = VS_clock; // スキル時間を取得

    start();
  }
  
  void start() { //TODO: スキル、エフェクト画像の読み込みと表示 image1 = loadImage("hoge.png");
    // 必要エネルギーが足りるかどうか
    if (_skillActer.equals(DATA_USERNAME)) {
      if (_skillEnergy < SB_lastEnergy) {
        SB_lastEnergy -= _skillEnergy;
      } else {
        double _rem = _skillEnergy - SB_lastEnergy;
        VP_message("エネルギーが" + String.valueOf(_rem) + "足りません");
        end();
        return;
      }
    }
    cutin();
    // スキルごとの動作
    switch(_skillName) {
      case "shield":
        BS_isShield = true;
        break;
      case "extend" :
        SB_barSize = 160;
        break;
      case "contract" :
        SB_barSize = 40;
        break;
      case "slow" :
        SB_gameSpeed = 0.3;
        break;
      case "fast" :
        SB_gameSpeed = 2.0;
        break;
      case "division":
        ArrayList<Ball> newBalls = new ArrayList<>();
        synchronized(SB_balls) { // SB_ballsへのアクセスを同期
          for (Ball ball : SB_balls) {
            newBalls.add(new Ball(ball._x, ball._y, ball._dx * 0.8, ball._dy * -1, ball._size));
          }
        }
        SB_balls.addAll(newBalls); // 新しいボールを追加
        break;
      case "bomb" :
        for (int x = 0; x < 12; x++) {
          for (int y = 0; y < 10; y++) {
            println("x:" + x + " y:" + y + " SB_blocks[y][x]:" + SB_blocks[y][x]);
            if (SB_blocks[y][x] > 0) {
              float r = random(0, 1);
              if (r > 0.5) {
                int l = (int)Math.ceil(SB_blocks[y][x] - (SB_blocksLife / 2));
                if (l < 0) l = 0;
                SB_blocks[y][x] = l;
              }
            }
          }
        }
        break;
      case "mine1" :
        int _x = (int)Math.ceil(random(0, 12));
        int _y = (int)Math.ceil(random(0, 10));
        for (int x = 0; x < 12; x++) {
          SB_blocks[_y][x] = SB_blocksLife;
        }
        for (int y = 0; y < 10; y++) {
          SB_blocks[y][_x] = SB_blocksLife;
        }
        break;
      case "mine2" :
        for (int x = 0; x < 12; x++) {
          for (int y = 0; y < 10; y++) {
            float r = random(0, 1);
            if (r > 0.5) {
              int l = (int)Math.ceil(SB_blocks[y][x] + (SB_blocksLife / 2));
              if (l > SB_blocksLife) l = SB_blocksLife;
              SB_blocks[y][x] = l;
            }
          }
        }
        break;
      case "magic" :
        BS_inflationBoostRate = 10;
        break;
      default : break;
    }
  }
  void end() {
    // スキルごとの動作
    switch(_skillName) {
      case "shield":
        BS_isShield = false;
        break;
      case "extend" :
        SB_barSize = 80;
        break;
      case "contract" :
        SB_barSize = 80;
        break;
      case "slow" :
        SB_gameSpeed = 1.0;
        break;
      case "fast" :
        SB_gameSpeed = 1.0;
        break;
      case "division" : break;
      case "bomb" : break;
      case "mine1" : break;
      case "mine2" : break;
      case "magic" :
        BS_inflationBoostRate = 1.0;
        break;
      default : break;
    }
  }
  void update(int i) {
    // タイマーの更新
    if (VS_clock > _skillStartTime + _skillDulation) {
      end();
      return;
    }
    display(i);
    cutinUpdate();
    
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
  void display(int i) {
    float _elapsed = VS_clock - _skillStartTime;
    float _remain = _skillDulation - _elapsed;
    fill(20, 50, 150);
    rect(SB_blockWindowWidth,(GAME_height * (18 - (2 * i)) / 20) - GAME_width / 50, GAME_width - SB_blockWindowWidth, GAME_height / 10);
    fill(20, 200, 250);
    rect(SB_blockWindowWidth + (GAME_width - SB_blockWindowWidth) * (_elapsed / _skillDulation),(GAME_height * (39 - (4 * i)) / 40) - GAME_width / 50,(GAME_width - SB_blockWindowWidth) * (_remain / _skillDulation), GAME_height / 40);
    fill(255);
    textAlign(LEFT);
    textFont(fontMd);
    text(_skillNameJp + " : ( " + String.format("%.0f", Math.ceil(_remain / 1000)) + "秒 / " + String.format("%.0f", Math.ceil(_skillDulation / 1000)) + "秒 )", SB_blockWindowWidth + GAME_width / 50,(GAME_height * (9 - i) / 10) - GAME_width / 50 + GAME_height / 20);
  }
  
  //!カットイン
  
  //スキルカットイン画像は横2縦1比率
  void cutin() {
    if (_isCutin) {
      _cutinX = GAME_width;
      _isCutinSlideOut = false;
      _isCutinSlideIn = true;
      _cutinDX = GAME_width / 20;
    }
    _cutinImage = _createRoundedImage();
    _isCutin = true;
  }
  void cutinUpdate() {
    if (_isCutin) { // カットイン処理
      // slideIn
      if (_isCutinSlideIn) {
        _cutinX -= _cutinDX;
        _cutinDX -= float(GAME_width) / 225.0;
        if (_cutinDX < float(GAME_width) / 225.0) _cutinDX = float(GAME_width) / 225.0;
        if (_cutinX <= GAME_width * 2 / 3) {
          _cutinX = GAME_width * 2 / 3;
          _isCutinSlideIn = false;
          _cutinTime = millis();
        }
      }
      // slideOut開始
      if (!_isCutinSlideIn && !_isCutinSlideOut && millis() - _cutinTime > 3000) {
        _cutinDX = GAME_width / 20;
        _isCutinSlideOut = true;
      }
      // slideOut
      if (_isCutinSlideOut) {
        _cutinX += _cutinDX;
        _cutinDX -= float(GAME_width) / 225.0;
        if (_cutinDX < float(GAME_width) / 225.0) _cutinDX = float(GAME_width) / 225.0;
        if (_cutinX >= GAME_width) {
          _isCutinSlideOut = false;
          _isCutinSlideIn = true;
          _cutinDX = GAME_width / 20;
          _isCutin = false;
        }
      }
      image(_cutinImage, _cutinX,(_cutinSizeX) / 2, _cutinSizeX, _cutinSizeY);
    }
  }
  PImage _createRoundedImage() {
    PImage _rawImg = loadImage("src/images/skill/" + _skillName + ".png");
    PGraphics _pg = createGraphics(_rawImg.width, _rawImg.height);
    _pg.beginDraw();
    _pg.image(_rawImg, 0, 0);
    _pg.fill(0, 150);
    _pg.rect(0, _rawImg.height / 2, _rawImg.width, _rawImg.height / 2);
    _pg.fill(255); // テキストの色
    _pg.textAlign(CENTER, CENTER);
    _pg.textFont(createFont("src/fonts/kaiso.otf", GAME_width / 15));
    _pg.text(_skillName, _rawImg.width / 2, _rawImg.height * 5 / 6);
    if (_skillActer != "") _pg.text(_skillActer + "が発動", _rawImg.width / 2, _rawImg.height * 3 / 6);
    _pg.endDraw();
    
    PGraphics _mask = createGraphics(_rawImg.width, _rawImg.height);
    _mask.beginDraw();
    _mask.background(0, 0);
    _mask.noStroke();
    _mask.fill(255);
    _mask.rectMode(CORNER);
    _mask.beginShape();
    _mask.vertex(_cutinImageMaskRad, 0);
    _mask.vertex(_rawImg.width, 0); // 右上の角
    _mask.vertex(_rawImg.width, _rawImg.height); // 右下の角
    _mask.vertex(_cutinImageMaskRad, _rawImg.height);
    _mask.quadraticVertex(0, _rawImg.height, 0, _rawImg.height - _cutinImageMaskRad); // 左下の角を丸くする
    _mask.vertex(0, _cutinImageMaskRad);
    _mask.quadraticVertex(0, 0, _cutinImageMaskRad, 0); // 左上の角を丸くする
    _mask.endShape(CLOSE);
    _mask.endDraw();
    PImage _maskedImage = _pg.get();
    _maskedImage.mask(_mask);
    return _maskedImage;
  }
  boolean shouldRemove() {
      return VS_clock > _skillStartTime + _skillDulation;
  }
}
