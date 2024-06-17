String SC_channelDisplay = "";
boolean SC_channelFlag = true;

void SC_boot() {
  NET_channel = "";
  SC_channelDisplay = "-";
  SC_channelFlag = true;
  noTint();
  image1 = loadImage("src/images/night.png");
  if (DATA_USERNAME.equals("")) {
    cmode(7);
  }
}
void SC_update() {
  image(image1, 0, 0, GAME_width, GAME_height);
  textAlign(CENTER, CENTER);
  fill(100, 255, 200);
  textFont(SC_fontChannel);
  text(SC_channelDisplay, GAME_width / 2, GAME_height / 2);
  fill(255);
  textFont(fontMd);
  text("12文字までのチャンネル名を入力し、Enterしてください\nわかりやすいので4桁の数字か英単語をおすすめします\n\nESC : トップに戻る　Backspace : 1字消し　Delete : 全字消し　Enter : 確定", GAME_width / 2, GAME_height * 3 / 4);
  actions("ゲームを開始");
  navbar("ESC : トップに戻る　Backspace : 1字消し　Delete : 全字消し　Enter : 確定","");
}

void SC_input(String _key) {
  if (_key.equals("bs")) {
    if (NET_channel.length() > 0) {
      NET_channel = NET_channel.substring(0, NET_channel.length() - 1);
    }
  } else if (_key.equals("del")) {
    NET_channel = "";
  } else if (_key.equals("enter")) {
    if (NET_channel.length()>0) {
      cmode(4);
    } else {
      return;
    }
  } else {
    if (NET_channel.length() < 12) NET_channel += _key;
  }
  if (NET_channel == "") {
    SC_channelFlag = true;
  } else {
    SC_channelFlag = false;
    SC_channelDisplay = NET_channel;
  }
  if (SC_channelFlag) {
    SC_channelDisplay = "-";
    NET_channel = "";
  }
}
