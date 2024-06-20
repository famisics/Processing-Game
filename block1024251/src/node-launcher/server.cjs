const { WebSocketServer, WebSocket } = require("ws");
const { exec } = require("child_process");

// !-------- 設定 --------
const port = 8001;
const host = "wss://proc.uiro.dev";
const exeFilePath = "block1024251.exe";
// !-------- 設定 --------

var isGameOpened = false;
let statusList = [false, false, false]; // client, local, public
const localWss = new WebSocketServer({ port: port }); // local
let publicWs = createWebSocket(); // 初回接続を確立

// クライアントとの通信
localWss.on("connection", (ws) => {
  status(0, true);

  ws.on("message", (message) => {
    if (publicWs.readyState === WebSocket.OPEN) {
      console.log("[Client>WSS]", "送信", "-------:" + message.toString());
      publicWs.send(message);
    } else {
      console.log(
        "公開サーバーに接続できなかったため、データは送信されませんでした"
      );
    }
  });

  publicWs.on("message", (message) => {
    if (ws.readyState === WebSocket.OPEN) {
      let _message = message.toString();
      console.log("[WSS>Client]", "受信", _message);
      ws.send(_message);
    }
  });

  ws.on("close", () => {
    status(0, false);
  });
});

// 公開サーバーとの通信
function createWebSocket() {
  const ws = new WebSocket(host);

  ws.on("open", () => {
    status(2, true);
  });

  ws.on("close", () => {
    status(2, false);
    console.log(
      "公開サーバーとの接続が切れました\n自動で再接続を試みます...\nCtrl + Cでサーバーを終了します"
    );
  });

  ws.on("error", () => {
    console.log(
      "公開サーバーが起動していないため、接続できません\n自動で再接続を試みます...\nCtrl + Cでサーバーを終了します"
    );
  });

  return ws;
}

// ステータス確認関数
function status(n, s) {
  statusList[n] = s;
  console.log(
    "\n\n--------サーバーの接続状況--------\n",
    statusList[2]
      ? "🌍️ 公開サーバー　　[接続済] ✅️\n"
      : "🌍️ 公開サーバー　　[未接続] ❌️\n",
    statusList[1]
      ? "💻️ プロキシサーバー[利用可] ✅️\n"
      : "💻️ プロキシサーバー[エラー] ❌️\n",
    statusList[0]
      ? "🎮️ クライアント　　[接続済] ✅️\n"
      : "🎮️ クライアント　　[未接続] ❌️\n",
    "注: ここはプロキシサーバーです"
  );
  if (statusList[1] && statusList[2]) {
    console.log(
      `----------------------------------\n　　 ゲームを起動できます！✨️\n\n　server: ws://localhost:${port}\n----------------------------------\nCtrl + Cでサーバーを終了します`
    );
    if (!isGameOpened) {
      exec(exeFilePath, (error, stdout, stderr) => {
        if (error) {
          console.error(`[ERROR] ${error}`);
          return;
        }
        console.log(stdout, stderr);
      });
      isGameOpened = true;
    }
  } else {
    console.log(
      "----------------------------------\n　　 ゲームを起動できません！❌️\n----------------------------------"
    );
  }
}

// 初期ステータス
statusList[1] = true;
console.log(
  "\n公開サーバーに接続されるまでお待ちください\n初めて接続する場合、最初の接続が成功するまでに1分程度かかる場合があります"
);

// 定期的な接続状態の確認と再接続の試行
setInterval(() => {
  if (publicWs.readyState === WebSocket.CLOSED) {
    publicWs = createWebSocket();
  }
}, 2000);
