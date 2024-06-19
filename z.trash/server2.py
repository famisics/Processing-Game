import asyncio
import websockets

#動かない

# !-------- 設定 --------
PORT = 8000
HOST = "wss://proc.uiro.dev"
# !-------- 設定 --------

status_list = [False, True, False]  # client, local, public
public_ws = None

async def handle_client(websocket, path):
    status(0, True)

    async def relay_message():
        async for message in websocket:
            if public_ws and public_ws.open:
                print("[Client>WSS] 送信 -------:" + message)
                await public_ws.send(message)
            else:
                print("[ERROR] 公開サーバーに接続できません\n        サーバーの再起動をお試しください")

    async def forward_message():
        async for message in public_ws:
            if websocket.open:
                print("[WSS>Client] 受信", message)
                await websocket.send(message)

    client_to_server = asyncio.create_task(relay_message())
    server_to_client = asyncio.create_task(forward_message())

    await asyncio.wait([client_to_server, server_to_client], return_when=asyncio.FIRST_COMPLETED)

    status(0, False)

async def create_websocket():
    global public_ws
    while True:
        try:
            public_ws = await websockets.connect(HOST)
            status(2, True)
            break
        except Exception as e:
            status(2, False)
            print(f"公開サーバーへの接続に失敗しました: {e}\n再接続を試みます...\nCtrl + Cでサーバーを終了します")
            await asyncio.sleep(2)

    async def monitor_connection():
        global public_ws
        while True:
            if public_ws.closed:
                status(2, False)
                print("公開サーバーとの接続が切れました\n自動で再接続を試みます...\nCtrl + Cでサーバーを終了します")
                await asyncio.sleep(2)
                await create_websocket()
            await asyncio.sleep(2)

    asyncio.create_task(monitor_connection())

def status(n, s):
    global isOpended  # ここでglobalを宣言
    status_list[n] = s
    print(
        "\n\n\n\n\n\n\n\n--------サーバーの接続状況--------\n",
        "🌍️ 公開サーバー　　[接続済] ✅️\n" if status_list[2] else "🌍️ 公開サーバー　　[未接続] ❌️\n",
        "💻️ プロキシサーバー[利用可] ✅️\n" if status_list[1] else "💻️ プロキシサーバー[エラー] ❌️\n",
        "🎮️ クライアント　　[接続済] ✅️\n" if status_list[0] else "🎮️ クライアント　　[未接続] ❌️\n",
        "注: ここはプロキシサーバーです"
    )
    if status_list[1] and status_list[2]:
        print(
            "----------------------------------\n　　 ゲームを起動できます！✨️\n" +
            f"\n　server: ws://localhost:{PORT}\n" +
            "----------------------------------\n",
            "Ctrl + Cでサーバーを終了します"
        )
    else:
        print(
            "----------------------------------\n　　 ゲームを起動できません！❌️\n----------------------------------"
        )

async def main():
    print(
        "\n公開サーバーに接続されるまでお待ちください\n初めて接続する場合、最初の接続が成功するまでに1分程度かかる場合があります"
    )
    await create_websocket()
    server = await websockets.serve(handle_client, "0.0.0.0", PORT)
    async with server:
        await asyncio.Future()

if __name__ == "__main__":
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        print("\nProxy サーバーを終了します\n以下のメッセージは無視してください\n")
