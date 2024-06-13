void controlEvent(ControlEvent theEvent) {
  // home1ボタンが押された場合
  if (theEvent.isFrom("home1")) {
    cmode(2); 
    SH_button1.remove();
    SH_button2.remove();
  }
  if (theEvent.isFrom("home2")) {
    cmode(4);
    SH_button1.remove();
    SH_button2.remove();
  }
}

void keyPressed() { // キー入力
  println("[key]     " + key + "(" + keyCode + ")");
  switch(GAME_MODE) { // ゲームモード限定の処理
    case 1 : // Home
      if (keyCode == 32 && !GAME_isTalkFinished) { // SPACE, 一時停止
        cmode(6);
      }
      break;
    case 2 : // Block
      if (keyCode == 32) SB_pause(); // SPACE, 一時停止
      break;
    case 3 : // Status
      
      break;
    case 4 : // Fight
      
      break;
    case 5 : // Result
      
      break;
    case 6 : // Talk
      if (keyCode == LEFT) ST_ScriptPrev(); // シナリオ戻し
      if (keyCode == RIGHT) ST_ScriptNext(); // シナリオ進め
      if (keyCode == 32) ST_ScriptNext(); // SPACE, シナリオ進め
      if (keyCode == ENTER) ST_ScriptNext(); // ENTER, シナリオ進め
      if (key == 'f') ST_ScriptNext(); // f, シナリオ進め
      break;
    default:
    break;
  }
  if (keyCode == 27) exit(); // ESC, 終了
  // モード切り替え(デモ用)
  if (key == '1') cmode(1); // home
  if (key == '2') cmode(2); // block
  if (key == '3') cmode(3); // status
  if (key == '4') cmode(4); // fight(これはどうする)
  if (key == '5') cmode(5); // result
  if (key == '6') cmode(6); // talk
  if (key == '7') cmode(7);
  if (key == 'n') NET_send("join,takedataro");
}
