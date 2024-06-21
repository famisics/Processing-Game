// 入力を受け付ける

void keyPressed() { // キー入力
  // *ローカルキーコンフィグ
  switch(GAME_MODE) { // ゲームモード限定の処理
    case 1 : // Home
      if (keyCode == 32 && !DATA_isTutorialFinished) { // SPACE, 一時停止
        cmode(6);
      } else if (keyCode == 32 && DATA_isTutorialFinished) { // SPACE, チャンネル選択へ
        cmode(3);
      }
      if (keyCode == ENTER) cmode(3); // ENTER, チャンネル選択へ //!デモ用
      if (key == 'n') cmode(7); // ユーザー名変更 //!デモ用
      if (key == 't') cmode(6); // チュートリアル //!デモ用
      if (key == 'S' || (keyCode == SHIFT && key == 's')) {
      }
      
      if (keyEvent.isShiftDown() && keyCode == 82) { // データリセット //!デモ用
        GAME_alertText = "データがリセットされました";
        GAME_isAlert = true;
        DATA_isOutOfRange = false;
        DATA_USERNAME = "";
        DATA_ENERGY = 0;
        SB_lastEnergy = 0;
        DATA_isTutorialFinished = false;
        save();
      }
      break;
    case 2 : // Block
      if (key == '1') VS_skillRegister("1", DATA_USERNAME);
      if (key == '2') VS_skillRegister("2", DATA_USERNAME);
      if (key == '3') VS_skillRegister("3", DATA_USERNAME);
      if (key == '4') VS_skillRegister("4", DATA_USERNAME);
      if (key == '5') VS_skillRegister("5", DATA_USERNAME);
      if (key == '6') VS_skillRegister("6", DATA_USERNAME);
      if (key == '7') VS_skillRegister("7", DATA_USERNAME);
      if (key == '8') VS_skillRegister("8", DATA_USERNAME);
      if (key == '9') VS_skillRegister("9", DATA_USERNAME);
      if (key == '0') VS_skillRegister("0", DATA_USERNAME);
      if (key == 'i') SB_inflationRateTemporary += SB_inflationRateTemporary; // インフレ倍率をあげる(2倍) //!デモ用
      if (key == 'l') cmode(2); // リセット //!デモ用
      if (key == 'p') SB_pause(); // SPACE, ポーズ //!デモ用
      break;
    case 3 : // Channel
      if ((keyCode >= 48 && keyCode <= 57) || (keyCode >= 65 && keyCode <= 90) || (keyCode >= 96 && keyCode <= 105)) SC_input(str(key)); // 入力
      if (keyCode == DELETE) SC_input("del"); // DELETE, 全字削除
      if (keyCode == BACKSPACE) SC_input("bs"); // BACKSPACE, 一字削除
      if (keyCode == ENTER) SC_input("enter"); // ENTER, 確定
      break;
    case 4 : // Start
      if (keyCode == 32 && !SS_isSpace) { // ENTER, ゲーム開始, 3秒以上長押しで実行, 時間の判定ロジックはscene4にあります
        SS_isSpace = true;
        SS_startTime = GAME_clock;
      }
      break;
    case 5 : // Result
      if (keyCode == 32) cmode(1); // SPACE, 復帰
      break;
    case 6 : // Tutorial
      if (keyCode == LEFT) ST_ScriptPrev(); // シナリオ戻し
      if (keyCode == RIGHT) ST_ScriptNext(); // シナリオ進め
      if (keyCode == 32) ST_ScriptNext(); // SPACE, シナリオ進め
      if (keyCode == ENTER) ST_ScriptNext(); // ENTER, シナリオ進め
      if (key == 'f') ST_ScriptNext(); // f, シナリオ進め
      break;
    case 7 : // Username
      if ((keyCode >= 48 && keyCode <= 57) || (keyCode >= 65 && keyCode <= 90) || (keyCode >= 96 && keyCode <= 105)) SU_input(str(key)); // 入力
      if (keyCode == DELETE) SU_input("del"); // DELETE, 全字削除
      if (keyCode == BACKSPACE) SU_input("bs"); // BACKSPACE, 一字削除
      if (keyCode == ENTER) SU_input("enter"); // ENTER, 確定
      break;
    case 8 : // 暗転
      if (keyCode == 32) cmode(1); // SPACE, 復帰
      break;
    default:
    break;
  }
  // *グローバルキーコンフィグ
  if (keyCode == 27) { // ESCキー
    
    if (GAME_MODE == 1) {
      exit();
    } else if (GAME_MODE == 4) {
      cmode(3);
      key = 0;
    } else {
      cmode(1);
      key = 0;
    }
  }
  if (keyCode == UP) cfps(true);
  if (keyCode == DOWN) cfps(false);
  // モード切り替え //!(デモ用)
  if (keyEvent.isShiftDown()) {
    // 0のキーコードは48(参考)
    if (keyCode == 49) cmode(1);
    if (keyCode == 50) cmode(2);
    if (keyCode == 51) cmode(3);
    if (keyCode == 52) cmode(4);
    if (keyCode == 53) cmode(5);
    if (keyCode == 54) cmode(6);
    if (keyCode == 55) cmode(7);
  }
}
void keyReleased() {
  if (GAME_MODE == 4 && keyCode == 32) SS_isSpace = false;
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
