String SC_ch = ""; 

void SC_boot() {
  SC_ch = "";
  image1 = loadImage("src/images/night.png");
}
void SC_update() {
  image(image1, 0, 0, GAME_width, GAME_height);
  textAlign(CENTER, CENTER);
  fill(100, 255, 200);
  textFont(SC_fontChannel);
  text(SC_ch, GAME_width / 2, GAME_height / 2);
  fill(255);
  textFont(fontMd);
  text("12文字までのチャンネル名を入力し、Enterしてください\nわかりやすいので4桁の数字か英単語をおすすめします\n\nBackspace : 1字消し　Delete : 全字消し　Enter : 確定", GAME_width / 2, GAME_height * 3 / 4);
  actions("戦闘を開始");
  navbar("Backspace : 1字消し　Delete : 全字消し　Enter : 確定","");
}

void SC_input(String _key) {
  if (_key.equals("bs")) {
    if (SC_ch.length() > 0) {
      SC_ch = SC_ch.substring(0, SC_ch.length() - 1);
    }
  } else if (_key.equals("del")) {
    SC_ch = "";
  } else if (_key.equals("enter")) {
    cmode(4);
  } else {
    if (SC_ch.length() < 12) SC_ch += _key;
  }
}
