// チュートリアル

String[][] ST_Script = {
  {"","地球再生計画へようこそ"} ,
  {"","このゲームでは、スキルを駆使して他のプレイヤーと戦ったり\n探索を繰り返してエネルギーを貯め、エネルギーをインフレさせていきます"} ,
  {"2","地球を凌駕するほどのエネルギーに達したとき、このゲームのクリアとします"} ,
  {"4","獲得したエネルギーはポイントの倍率に影響します\nエネルギーを貯蔵すればするほどレベルが上がり、エネルギーの獲得効率が上がります"} ,
  {"5","エネルギーの獲得効率は探索の勝敗に影響することはありませんが、実績として表示されます"} ,
  {"","画面下部に主要な操作が書かれているので、参考にしてください\nそれでは、さっそく探索に向かいましょう"}
};

int ST_ScriptIndex = 0;
int ST_AnimationIndex = 0;

void ST_boot() {
  background(0);
  ST_ScriptIndex = 0;
  ST_AnimationIndex = 0;
  image1 = loadImage("src/images/talk/welcome.png");
  image2 = loadImage("src/images/sekai.png");
}
void ST_update() {
  if (ST_AnimationIndex < 10) {
    ST_AnimationIndex++;
    tint(255, 50);
  }
  image(image1, 0, 0, GAME_width, GAME_height);
  noTint();
  image(image2, GAME_width - GAME_width / 100 * 30, GAME_height - GAME_width / 100 * 40 - GAME_height / 5, GAME_width / 100 * 30, GAME_width / 100 * 40);
  fill(70, 100, 100);
  rect(0, GAME_height * 3 / 5, GAME_width, GAME_height * 2 / 5);
  fill(255);
  textAlign(CENTER,CENTER);
  textFont(fontLg);
  text(ST_Script[ST_ScriptIndex][1], 0, GAME_height * 3 / 5 - 25, GAME_width, GAME_height * 2 / 5);
  navbar("SPACE/Enter/f/→ : テキストを進める　← : テキストを戻る","Script: " + str(ST_ScriptIndex));
}
void ST_ScriptNext() {
  if (ST_ScriptIndex < ST_Script.length - 1) {
    ST_ScriptIndex++;
  } else {
    GAME_isTalkFinished = true;
    cmode(3);
  }
}
void ST_ScriptPrev() {
  if (ST_ScriptIndex > 0) { 
    ST_ScriptIndex--;
  }
}
