// こっちは開始ボタンだけ
// 誰かスタート押せば全員に通達、それだけ

void SS_boot() {
  background(100, 100, 100);
  tint(200, 200);
  image1 = loadImage("src/images/world.png");
  image(image1, 0, 0, GAME_width, GAME_height);
  noTint();
  actions("戦闘を待機中");
  textAlign(CENTER, CENTER);  
  fill(255);
  textFont(createFont("src/fonts/smartfont.otf", GAME_width / 30));
  text("Press Enter to START GAME!", GAME_width / 2, GAME_height / 4);
  textFont(SC_fontChannel);
  fill(100, 255, 200);
  text(SC_ch, GAME_width / 2, GAME_height / 2);
  fill(255);
  textFont(fontLg);
  text("同じChannelの誰かがEnterを押すと\n全員の戦闘が開始されます", GAME_width / 2, GAME_height * 3 / 4);
  navbar("","");
}
void SS_update() {
}
