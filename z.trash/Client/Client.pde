import websockets.*;
PFont font;
String text = "なにか打て";

WebsocketClient client;
String host = "ws://localhost:8000"; // 8001-8003 まで建てられはする(追加可能)、どれにしようね

void setup() {
  size(600, 400);
  client = new WebsocketClient(this, host);
  font = createFont("Meiryo UI", 16);
  textFont(font);
}

void draw() {
  background(255);
  fill(0);
  text(text, 10, height / 2);
}

int i = 0;
void keyPressed() {
  String message = "score,"+i+"dev,fuyunyat";
  println(message);
  client.sendMessage(message);
  i++;
}

// メッセージを受信したときに自動的に呼び出される関数
void webSocketEvent(String msg){
  println(msg);
  text = msg;
}
