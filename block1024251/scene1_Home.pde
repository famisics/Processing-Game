// ホーム

float alpha = 0; // 透明度の初期値
float fontSize = 200; // フォントサイズの初期値
float targetFontSize = 30; // 最終的なフォントサイズ
float easing = 0.12; // イージングの係数

void SH_boot() {
  background(0);
  image1 = loadImage("src/images/start.png");
  fontSize = GAME_width / 5;
  targetFontSize = GAME_width / 10;
}
void SH_update() {
  SH_titleAnime();
  tint(100, 100);
  image(image1, 0, 0, GAME_width, GAME_height);
  noTint();
  textAlign(CENTER,CENTER);
  textFont(SH_fontTitle);
  textSize(fontSize);
  fill(255, 0, 0, alpha);
  text("地球再生計画", GAME_width / 2 + 10, GAME_height / 2 - (GAME_height / 6) + 10);
  fill(255, alpha);
  text("地球再生計画", GAME_width / 2, GAME_height / 2 - (GAME_height / 6));
  fill(255);
  textFont(fontLg);
  text("スペースキーを押してください", GAME_width / 2, GAME_height / 2 + (GAME_height / 6));
  textAlign(LEFT);
  text("ユーザー名 : " + DATA_USERNAME + " (nキーを押して変更)\n累計獲得エネルギー : " + doubleToJp(DATA_ENERGY), GAME_height / 10, GAME_height / 10);
  textFont(fontSm);
  fill(0, 255, 255);
  text("[デモが有効になっています] 以下のキーコンフィグが有効です\n\nホーム> n : ユーザー名変更　t : チュートリアルを見る　SPACE : 探索を開始/チュートリアル(自動選択)　Enter : 探索を開始\n\n全てのシーン>　Shift+(1 : HOME　2 : Block　3 : Channel　4 : Start　 5 : Result　6 : Tutorial　7 : Username　8 : 暗転)　↑ : FPS+　↓ : FPS-　ESC : QUIT\n\nブロック崩し>　I : エネルギー倍率を増加　L : リスタート　P : ポーズ", GAME_width / 20, GAME_height * 3 / 4);
  rectMode(CORNER);
  navbar("","2024 (C) b1024251 Takumi Yamazaki");
}
void SH_titleAnime() {
  // フェードイン効果（ease-out）
  if (alpha < 255) {
    float dAlpha = (255 - alpha) * easing; // 変化量を計算
    alpha += dAlpha; // アルファ値を更新
    // 最終的に255に近づける
    if (alpha > 255) {
      alpha = 255;
    }
  }
  // 縮小効果（ease-out）
  if (fontSize > targetFontSize) {
    float dFontSize = (targetFontSize - fontSize) * easing; // 変化量を計算
    fontSize += dFontSize; // フォントサイズを更新
    // 最終的に目標サイズに近づける
    if (fontSize < targetFontSize) {
      fontSize = targetFontSize;
    }
  }
}
