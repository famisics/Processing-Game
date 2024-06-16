String SU_ch = ""; 
String SU_chDisplay = "";
boolean SU_chFlag = true;

void SU_boot() {
  SU_ch = "";
  SU_chDisplay = "-";
  SU_chFlag = true;
  noTint();
  image1 = loadImage("src/images/night.png");
}
void SU_update() {
  image(image1, 0, 0, GAME_width, GAME_height);
  textAlign(CENTER, CENTER);
  fill(100, 255, 200);
  textFont(SC_fontChannel);
  text(SU_chDisplay, GAME_width / 2, GAME_height / 2);
  fill(255);
  textFont(fontMd);
  text("ユーザー名(英数16文字まで)を入力し、Enterしてください\n\nESC : トップに戻る　Backspace : 1字消し　Delete : 全字消し　Enter : 確定", GAME_width / 2, GAME_height * 3 / 4);
  actions("ユーザー名設定");
  navbar("ESC : トップに戻る　Backspace : 1字消し　Delete : 全字消し　Enter : 確定","");
}

void SU_input(String _key) {
  if (_key.equals("bs")) {
    if (SU_ch.length() > 0) {
      SU_ch = SU_ch.substring(0, SU_ch.length() - 1);
    }
  } else if (_key.equals("del")) {
    SU_ch = "";
  } else if (_key.equals("enter")) {
    if (SU_ch.length()>0) {
      DATA_USERNAME = SU_ch;
      cmode(1);
    } else {
      return;
    }
  } else {
    if (SU_ch.length() < 16) SU_ch += _key;
  }
  if (SU_ch == "") {
    SU_chFlag = true;
  } else {
    SU_chFlag = false;
    SU_chDisplay = SU_ch;
  }
  if (SU_chFlag) {
    SU_chDisplay = "-";
    SU_ch = "";
  }
}
