// WebSocket通信制御

// 他クライアントからの受信イベントを処理
void NET_recv(String i) {
  String[] _data = split(i, ",");
  switch(_data[0]) {
    case "message" :
      println("[message] " + _data[1]);
      break;
    case "skill" :
      println("[skill] " + _data[1]);
      VS_skillRecv(_data[1]);
      break;
    case "join" :
      println("[join] " + _data[1] + "が入室しました");
      break;
    case "leave" :
      println("[leave] " + _data[1] + "が退室しました");
      break;
    default :
    println("[WS:RECV] (" + i + ")は規定外のデータであるため破棄されました");
    break;
  }
}

// websocketの送信イベント
void NET_send(String i) {
  NET_CLIENT.sendMessage(i);
  println("[WS:SEND] (" + i + ")を送信中");
}

// websocketの受信イベント
void webSocketEvent(String i) {
  String[] _data = split(i, ":");
  switch(_data[0]) {
    case "SUCCESS" :
      println("[WS:SEND] (" + _data[1] + ")の送信に成功しました");
      NET_recv(_data[1]);
      // TODO:これなくす↑、相手に送ったやつだから
      break;
    case "DELIVER" :
      println("[WS:RECV] (" + _data[1] + ")を受信しました");
      NET_recv(_data[1]);
      default :
      println("[WS:RECV] (" + i + ")は規定外のデータであるため破棄されました");
      break;
  }
}
