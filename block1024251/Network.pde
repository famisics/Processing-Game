// WebSocket通信制御

// 他クライアントからの受信イベントを処理
void NET_recv(String i) {
  String[] _data = split(i, ","); // データ構造 : [0] = イベント名, [1] = 内容, [2] = 送信先チャンネル, [3] = ユーザーネーム
  if (_data[2] == NET_channel) {
    switch(_data[0]) {
      case "skill" :
        println("[WS:skill] " + _data[3] + "がスキルID" + _data[1] + "を発動しました");
        VS_skillRecv(_data[1]);
        break;
      case "join" :
        println("[WS:join] " + _data[3] + "が" + _data[2] + "に参加しました");
        break;
      case "start" :
        println("[WS:start] " + _data[3] + "が" + _data[2] + "のゲームを開始します！");
        break;
      default :
      println("[WS:RECV] (" + i + ")は規定外のデータであるため破棄されました");
      break;
    }
  }
}

// websocketの送信イベント
void NET_send(String _event, String _data) { // データ構造 : イベント名,データ
  String _token = _event + "," + _data + "," + NET_channel + "," + DATA_USERNAME; // ユーザーネームと送信先チャンネルを付加
  if (NET_isNetworkEnable) {
    NET_CLIENT.sendMessage(i);
    println("[WS:SEND] (" + i + ")を送信中");
  } else {
    println("[WS:SEND] ネットワークが無効になっています");
    
  }
}

// websocketの受信イベント
void webSocketEvent(String i) {
  String[] _data = split(i, ":");
  switch(_data[0]) {
    case "SUCCESS" :
      println("[WS:SEND] (" + _data[1] + ")の送信に成功しました");
      break;
    case "DELIVER" :
      println("[WS:RECV] (" + _data[1] + ")を受信しました");
      NET_recv(_data[1]);
      default :
      println("[WS:RECV] (" + i + ")は規定外のデータであるため破棄されました");
      break;
  }
}
