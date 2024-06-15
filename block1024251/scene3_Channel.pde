String SC_ch = ""; 

void SC_boot() {
  SC_ch = "";
  image1 = loadImage("src/images/night.png");
}
void SC_update() {
  image(image1, 0, 0, GAME_width, GAME_height);
  textAlign(CENTER, CENTER);
  fill(255, 200, 200);
  textFont(fontXl);
  text("Channel", GAME_width / 2, GAME_height / 2 - (GAME_height / 6));
  textFont(VP_fontScore);
  text(SC_ch, GAME_width / 2, GAME_height / 2);
  textFont(fontMd);
  text("8文字までのチャンネル名を入力してください\nBackspaceで1字消し、Deleteで全字消しできます", GAME_width / 2, GAME_height / 2 + (GAME_height / 6));
}

void SC_input(String _key) {
  if (_key.equals("bs")) {
    if (SC_ch.length() > 0) {
      SC_ch = SC_ch.substring(0, SC_ch.length() - 1);
    }
  } else if (_key.equals("del")) {
    SC_ch = "";
  } else {
    if (SC_ch.length() < 8) SC_ch += _key;
  }
}
