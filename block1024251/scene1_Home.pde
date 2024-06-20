// ホーム

float SH_alpha = 0; // 透明度の初期値
float SH_fontSize = 200; // フォントサイズの初期値
float SH_targetFontSize = 30; // 最終的なフォントサイズ
float SH_easing = 0.12; // イージングの係数

void SH_boot() {
  background(0);
  image1 = loadImage("src/images/home.png");
  SH_fontSize = GAME_width / 5;
  SH_targetFontSize = GAME_width / 10;
}
void SH_update() {
  SH_titleAnime();
  tint(100, 100);
  image(image1, 0, 0, GAME_width, GAME_height);
  noTint();
  textAlign(CENTER,CENTER);
  textFont(SH_fontTitle);
  textSize(SH_fontSize);
  fill(255, 0, 0, SH_alpha);
  text("地球再生計画", GAME_width / 2 + 10, GAME_height / 2 - (GAME_height / 6) + 10);
  fill(255, SH_alpha);
  text("地球再生計画", GAME_width / 2, GAME_height / 2 - (GAME_height / 6));
  fill(255);
  textFont(fontLg);
  text("スペースキーを押してください", GAME_width / 2, GAME_height / 2 + (GAME_height / 6));
  textFont(VP_fontScoreMd);
  textAlign(LEFT);
  text("ユーザー名 : " + DATA_USERNAME + " (nキーを押して変更)\n\n累計獲得エネルギー : " + doubleToJp(DATA_ENERGY), GAME_height / 10, GAME_height / 10);
  textFont(fontSm);
  fill(0, 255, 255);
  text("[デモが有効になっています] 以下のキーコンフィグが有効です\n\nホーム> Shift+R : データリセット　SPACE : ゲームを開始/チュートリアル(自動選択)　Enter : ゲームを開始　n : ユーザー名変更　t : チュートリアルを見る\n\n全てのシーン>　Shift+(1 : HOME　2 : Block　3 : Channel　4 : Start　 5 : Result　6 : Tutorial　7 : Username)　↑ : FPS+　↓ : FPS-　ESC : QUIT\n\nブロック崩し>　I : エネルギー倍率を増加　L : リスタート　P : ポーズ", GAME_width / 20, GAME_height * 3 / 4);
  rectMode(CORNER);
  navbar("","2024 (C) b1024251 Takumi Yamazaki");
}
void SH_titleAnime() { // タイトルのアニメーション
  if (SH_alpha < 255) {
    float _dalpha = (255 - SH_alpha) * SH_easing;
    SH_alpha += _dalpha;
    if (SH_alpha > 255) {
      SH_alpha = 255;
    }
  }
  if (SH_fontSize > SH_targetFontSize) {
    float _dFontSize = (SH_targetFontSize - SH_fontSize) * SH_easing;
    SH_fontSize += _dFontSize;
    if (SH_fontSize < SH_targetFontSize) {
      SH_fontSize = SH_targetFontSize;
    }
  }
}
