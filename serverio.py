import asyncio
import socketio
import websockets

# !-------- 設定 --------
PORT = 8001
HOST = "wss://proc.uiro.dev"
# !-------- 設定 --------

status_list = [False, True, False]  # client, local, public
public_ws = None

# Create a Socket.io server instance
sio = socketio.AsyncServer(async_mode='asgi')  # Choose 'asgi' or 'aiohttp' based on your server setup
app = socketio.ASGIApp(sio)

# Socket.io event handlers
@sio.event
async def connect(sid, environ):
    global public_ws
    print(f"Client {sid} connected to the server.")
    if public_ws is None or public_ws.closed:
        try:
            public_ws = await asyncio.create_task(connect_to_public_server())
            status(2, True)
        except Exception as e:
            status(2, False)
            print(f"Failed to connect to public server: {e}")
            return False

@sio.event
async def disconnect(sid):
    global public_ws
    print(f"Client {sid} disconnected.")
    if public_ws and public_ws.connected:
        await public_ws.disconnect()

@sio.event
async def client_to_server(sid, message):
    global public_ws
    if public_ws and public_ws.connected:
        print(f"[Client>WSS] Sending: {message}")
        await public_ws.send(message)

async def connect_to_public_server():
    while True:
        try:
            ws = await websockets.connect(HOST)
            return ws
        except Exception as e:
            print(f"Failed to connect to public server: {e}")
            await asyncio.sleep(2)

# Helper function to update server status
def status(n, s):
    global status_list
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
    await asyncio.gather(
        sio.start_background_task(connect_to_public_server),
        websockets.serve(handle_client, "0.0.0.0", PORT),
    )

if __name__ == "__main__":
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        print("\nProxy サーバーを終了します\n以下のメッセージは無視してください\n")
