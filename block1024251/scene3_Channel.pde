String SC_ch = ""; 
String SC_chDisplay = "";
boolean SC_chFlag = true;

void SC_boot() {
  SC_ch = "";
  SC_chDisplay = "-";
  SC_chFlag = true;
  noTint();
  image1 = loadImage("src/images/night.png");
  if(DATA_USERNAME.equals("")){
    cmode(7);
  }
}
void SC_update() {
  image(image1, 0, 0, GAME_width, GAME_height);
  textAlign(CENTER, CENTER);
  fill(100, 255, 200);
  textFont(SC_fontChannel);
  text(SC_chDisplay, GAME_width / 2, GAME_height / 2);
  fill(255);
  textFont(fontMd);
  text("12文字までのチャンネル名を入力し、Enterしてください\nわかりやすいので4桁の数字か英単語をおすすめします\n\nESC : トップに戻る　Backspace : 1字消し　Delete : 全字消し　Enter : 確定", GAME_width / 2, GAME_height * 3 / 4);
  actions("探索を開始");
  navbar("ESC : トップに戻る　Backspace : 1字消し　Delete : 全字消し　Enter : 確定","");
}

void SC_input(String _key) {
  if (_key.equals("bs")) {
    if (SC_ch.length() > 0) {
      SC_ch = SC_ch.substring(0, SC_ch.length() - 1);
    }
  } else if (_key.equals("del")) {
    SC_ch = "";
  } else if (_key.equals("enter")) {
    if (SC_ch.length()>0) {
      cmode(4);
    } else {
      return;
    }
  } else {
    if (SC_ch.length() < 12) SC_ch += _key;
  }
  if (SC_ch == "") {
    SC_chFlag = true;
  } else {
    SC_chFlag = false;
    SC_chDisplay = SC_ch;
  }
  if (SC_chFlag) {
    SC_chDisplay = "-";
    SC_ch = "";
  }
}
