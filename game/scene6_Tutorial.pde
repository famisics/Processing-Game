// チュートリアル

String[][] ST_Script = {
  {"地球再生計画へようこそ"} ,
  {"このゲームでは、スキルを駆使して他のプレイヤーと戦ったり、１人で何度もゲームをプレイしすることで、エネルギーという単位をインフレさせます"} ,
  {"地球を凌駕するほどのエネルギー 約320澗(かん) に達したとき、このゲームのクリアとします\n対応している数詞:(万, 億, 兆, 京, 垓, 秭, 穣, 溝, 澗)"} ,
  {"獲得したエネルギーはポイントの倍率に影響します\nエネルギーを貯蔵すればするほどレベルが上がり、エネルギーの獲得効率が上がります"} ,
  {"画面下部に主要な操作が書かれているので、参考にしてください\nそれでは、さっそくゲームに向かいましょう"}
};

int ST_ScriptIndex = 0;

void ST_boot() {
  ST_ScriptIndex = 0;
  String _t = "";
  if (DATA_isOutOfRange) {
    _t = "1";
  } else {
    _t = "0";
  }
  image1 = loadImage("src/images/home" + _t + ".png");
  image2 = loadImage("src/images/chara.png");
}
void ST_update() {
  tint(150, 25);
  image(image1, 0, 0, GAME_width, GAME_height);
  noTint();
  image(image2, GAME_width * 6 / 20, GAME_height * 1 / 15, GAME_width * 10 / 3 / 8, GAME_width * 10 * 4 / 9 / 8);
  fill(0, 150);
  rect(0, GAME_height * 2 / 3, GAME_width, GAME_height * 1 / 3);
  fill(255);
  textAlign(CENTER,CENTER);
  textFont(ST_fontTutorial);
  text(ST_Script[ST_ScriptIndex][0], 0, GAME_height * 2 / 3 - 25, GAME_width, GAME_height * 1 / 3);
  navbar("SPACE/Enter/f/→ : テキストを進める　← : テキストを戻る","Script: " + str(ST_ScriptIndex));
}
void ST_ScriptNext() {
  if (ST_ScriptIndex < ST_Script.length - 1) {
    ST_ScriptIndex++;
  } else {
    DATA_isTutorialFinished = true;
    cmode(3);
  }
}
void ST_ScriptPrev() {
  if (ST_ScriptIndex > 0) { 
    ST_ScriptIndex--;
  }
}
