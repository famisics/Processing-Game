// WebSocket通信制御

// 他クライアントからの受信イベントを処理
void NET_recv(String i) {
  String[] _data = split(i, ","); // データ構造 : [0] = イベント名, [1] = データ, [2] = 送信先チャンネル, [3] = ユーザーネーム
  if (_data[2].equals(NET_channel)) {
    switch(_data[0]) {
      case "skill" :
        println("[WS:skill] " + _data[3] + " activate ID:" + _data[1]);
        VS_skillRegister(_data[1], _data[3]);
        break;
      case "join" :
        println("[WS:join] " + _data[3] + " joined ch:" + _data[2]);
        SS_message(_data[3] + "がチャンネル" + NET_channel + "に参加しました");
        break;
      case "score" :
        println("[WS:join] " + _data[3] + " corrects " + _data[1] + " energy at ch:" + _data[2]);
        VP_scoreRecv(_data[1], _data[3]);
        break;
      case "start" :
        println("[WS:start] " + _data[3] + " starting ch:" + _data[2]);
        SB_startMessageText = _data[3] + "がチャンネル" + _data[2] + "のゲームを開始します！";
        cmode(2);
        break;
      default :
      println("[WS:RECV] (" + i + ") is rejected (event is not match)");
      break;
    }
  } else {
    println("[WS:RECV] (" + i + ") is rejected (channel is not match)");
  }
}

// websocketの送信イベント
void NET_send(String _event, String _data) { // データ構造 : イベント名,データ
  String _token = _event + "," + _data + "," + NET_channel + "," + DATA_USERNAME; // ユーザーネームと送信先チャンネルを付加
  if (NET_isNetworkEnable) {
    NET_client.sendMessage(_token);
    println("[WS:SEND] (" + _token + ") sending");
  } else {
    println("[WS:SEND] ws disabled by user settings");
  }
}

// websocketの受信イベント
void webSocketEvent(String i) {
  String[] _data = split(i, ":");
  switch(_data[0]) {
    case "SUCCESS" :
      println("[WS:SEND] (" + _data[1] + ") send success");
      break;
    case "DELIVER" :
      println("[WS:RECV] (" + _data[1] + ") recieve success");
      NET_recv(_data[1]);
      default :
      println("[WS:RECV] (" + i + ") is rejected (serverdata is not match)");
      break;
  }
}
