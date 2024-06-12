String SU_username = ""; 
String SU_usernameDisplay = "";
boolean SU_usernameFlag = true;

void SU_boot() {
  SU_username = "";
  SU_usernameDisplay = "-";
  SU_usernameFlag = true;
  noTint();
  image1 = loadImage("src/images/night.png");
}
void SU_update() {
  image(image1, 0, 0, GAME_width, GAME_height);
  textAlign(CENTER, CENTER);
  fill(100, 255, 200);
  textFont(SC_fontChannel);
  text(SU_usernameDisplay, GAME_width / 2, GAME_height / 2);
  fill(255);
  textFont(fontMd);
  text("ユーザー名(英数16文字まで)を入力し、Enterしてください\n\nESC : ホームに戻る　Backspace : 1字消し　Delete : 全字消し　Enter : 確定", GAME_width / 2, GAME_height * 3 / 4);
  actions("ユーザー名設定");
  navbar("ESC : ホームに戻る　Backspace : 1字消し　Delete : 全字消し　Enter : 確定","");
}

void SU_input(String _key) {
  if (_key.equals("bs")) {
    if (SU_username.length() > 0) {
      SU_username = SU_username.substring(0, SU_username.length() - 1);
    }
  } else if (_key.equals("del")) {
    SU_username = "";
  } else if (_key.equals("enter")) {
    if (SU_username.length()>0) {
      DATA_USERNAME = SU_username;
      cmode(1);
    } else {
      return;
    }
  } else {
    if (SU_username.length() < 16) SU_username += _key;
  }
  if (SU_username == "") {
    SU_usernameFlag = true;
  } else {
    SU_usernameFlag = false;
    SU_usernameDisplay = SU_username;
  }
  if (SU_usernameFlag) {
    SU_usernameDisplay = "-";
    SU_username = "";
  }
}
