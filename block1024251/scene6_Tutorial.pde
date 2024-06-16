// チュートリアル

String[][] ST_Script = {
  {"","地球再生計画へようこそ"} ,
  {"","あなたは地球の探索者に任命されました"} ,
  {"","これから何をするべきなのか、私が説明します"} ,
  {"2","ホーム画面はこの画像のように操作します"} ,
  {"3","ゲーム画面はこの画像のように操作します"} ,
  {"4","獲得したエネルギーはポイントの倍率に影響します\nエネルギーを貯蔵すればするほどレベルが上がり、エネルギーの獲得効率が上がります\nこの倍率が探索の勝敗に影響することはありません"} ,
  {"5","探索や探索で得たエネルギーは貯蔵され、実績として表示されます"} ,
  {"","それでは、さっそく探索や探索に向かいましょう"}
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
  rect(0, GAME_height * 4 / 5, GAME_width, GAME_height / 5);
  fill(255);
  textAlign(CENTER,CENTER);
  textFont(fontMd);
  text(ST_Script[ST_ScriptIndex][1], 0, GAME_height * 4 / 5 - 25, GAME_width, GAME_height / 5);
  navbar("","Script: " + str(ST_ScriptIndex));
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
