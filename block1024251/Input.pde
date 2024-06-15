// 入力を受け付ける

void keyPressed() { // キー入力
  switch(GAME_MODE) { // ゲームモード限定の処理
    case 1 : // Home
      if (keyCode == 32 && !GAME_isTalkFinished) { // SPACE, 一時停止
        cmode(6);
      }
      break;
    case 2 : // Block
      if (keyCode == 32) SB_pause(); // SPACE, 一時停止
      if (key == '1') NET_recv("skill,1");
      if (key == '2') NET_recv("skill,2");
      if (key == '3') NET_recv("skill,3");
      if (key == '4') NET_recv("skill,4");
      if (key == '5') NET_recv("skill,5");
      if (key == '6') NET_recv("skill,6");
      if (key == '7') NET_recv("skill,7");
      if (key == '8') NET_recv("skill,8");
      if (key == '9') NET_recv("skill,9");
      if (key == '0') NET_recv("skill,0");
      if (key == 'i') SB_inflationRate *= 1.5;
      break;
    case 3 : // Channel
      if ((keyCode >= 48 && keyCode <= 57) || (keyCode >= 65 && keyCode <= 90) || (keyCode >= 96 && keyCode <= 105)) SC_input(str(key)); // 入力
      if (keyCode == DELETE) SC_input("del"); // DELETE, 全削除
      if (keyCode == BACKSPACE) SC_input("bs"); // BACKSPACE, 一文字削除
      break;
    case 4 : // -----
    
      break;
    case 5 : // Result
      
      break;
    case 6 : // Tutorial
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
  if (key == 'a') {
    // Button.add("explore", 100, 100, 100, 100, "neptune.png", this::buttonPressed1);
  }
  // モード切り替え(デモ用)
  if (keyEvent.isShiftDown()) {
    // 0のキーコードは48(参考)
    if (keyCode == 49) cmode(1);
    if (keyCode == 50) cmode(2);
    if (keyCode == 51) cmode(3);
    if (keyCode == 52) cmode(4);
    if (keyCode == 53) cmode(5);
    if (keyCode == 54) cmode(6);
    if (keyCode == 55) cmode(7);
    if (keyCode == 56) cmode(8);
    if (keyCode == 57) cmode(9);
  }
  if (keyCode == UP) cfps(true);
  if (keyCode == DOWN) cfps(false);
}


void cfps(boolean _isUp) { // FPS変更
  if (_isUp) {
    GAME_fpsIndex++;
  } else {
    GAME_fpsIndex--;
  }
  if (GAME_fpsIndex < 0) GAME_fpsIndex = 0;
  if (GAME_fpsIndex > 6) GAME_fpsIndex = 6;
  switch(GAME_fpsIndex) {
    case 0:
      frameRate(10);
      println("[fps] 10");
      break;
    case 1:
      frameRate(30);
      println("[fps] 30");
      break;
    case 2:
      frameRate(60);
      println("[fps] 60");
      break;
    case 3:
      frameRate(90);
      println("[fps] 90");
      break;
    case 4:
      frameRate(120);
      println("[fps] 120");
      break;
    case 5:
      frameRate(240);
      println("[fps] 240");
      break;
    case 6:
      frameRate(999);
      println("[fps] unlimited");
      break;
    default:
    break;
  }
}
