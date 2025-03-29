# 地球再生計画 (CSK - Processing-Game)

[Githubリポジトリ - famisics/Processing-Game](https://github.com/famisics/Processing-Game)

## GitDiagram

![diagram](https://github.com/user-attachments/assets/50852248-c367-4269-8af5-402ceffd57e5)

## 注意

マルチプレイ用の公開サーバーに Render の Free プランを使用しています  
しばらくアクセスがない場合、サーバーがスピンアウトし、再接続に1分ほどかかります

## 概要

マルチプレイ能力バトルインフレ系ブロック崩しです

公開サーバーと接続して他のプレイヤーと対戦したり、サーバー機能を無効にして地道にゲームをインフレさせたりできます

## ディレクトリ

```text
/dist/ - プロダクト
/game/
  *.pde - ゲームのソースコード
  .src/
    .fonts/ - フォント
    .images/ - ゲーム内で使用した画像
    ./node-launcher/ - /dist 内にビルドしてある `launcher.exe` のソースコード
    ./sounds/ - ゲーム内のBGM, SE
    config.json - ユーザーデータの保存
    skills.csv - スキルの調整、テキストの変更ができます
/node-proxy/ - `launcher.exe` と同じ機能を持つnode.jsサーバー

```

## ゲームの開始方法

### Windows

1. Githubリポジトリ の Releases の 最新版 または WebDAV から、`CSK2-prod-windows-x64.zip` をダウンロードし、任意の場所で展開します

2. `./dist` 内の `launcher.exe` を起動してください

- サーバーとの接続が開始されます

- 接続に成功すると Processing のゲームをエクスポートした `game.exe` が起動します

- パブリックアクセスへの許可が必要と表示された場合は、同意していただける場合は同意してください  
  ( `launcher.exe` のソースコードを確認したい方は `./src/node-launcher/` をご覧ください)

- node.js / Java は同梱されています

### launcher.exe を使わない, (macOS, linux の場合)

プロキシサーバーの起動には node.js が必要です  
ダウンロード: https://nodejs.org/en/download/prebuilt-installer

1. `./node-proxy/` 内でコマンドプロンプトを開き、 `npm install` を実行します  
   (お好きなパッケージマネージャーを使用していただいてかまいません)

2. `./node-proxy/` 内で `npm run start` を実行します

3. サーバーが開始され、 `ゲームを起動できます！✨️` と表示されたことを確認してください

4. `./game.pde` を Processing IDE で実行してください

## サーバーに関する注意事項

公開サーバーの仕様上、他のプレイヤーがしばらくアクセスしていなかった場合、接続に 1 分程度かかる場合があります

`game.pde` 内の `NET_isNetworkEnable` が `true` の場合、ゲームの起動前に node サーバーをスタートさせてください

サーバーに接続できない場合は `NET_isNetworkEnable` を `false` にしてください

> 公開サーバーの詳細情報  
> ホスト: wss://proc.uiro.dev  
> 利用技術: Render / node.js / pnpm / express / websocket  
> プロキシ - 公開サーバー間の通信は SSL に対応しています

> プロキシサーバーでは、ポート`8081`を利用しています、変更する場合は `game.pde` と `server.cjs` の上部にあるポート設定を変更してください

## ゲーム内容の詳細

- マルチプレイ能力バトルインフレ系ブロック崩しです

- プレイ時間を考慮して、すぐにエンディングに到達できる程度のパラメーターにしています

- 公開サーバーに接続してオンラインでマルチプレイが可能です

- サーバー機能を無効にして１人で遊ぶこともできます

- エネルギーを大量に(１潤以上)集めると地球が再生されます

- スキル一覧はゲーム内、プロパティの設定は `./src/skills.csv` で管理されています (ゲームバランスが崩れるため変更しないでください)

- 必要のない計算、再描画が極力減るように意識しています  
  update(draw)と boot(setup)を分けるなど  
  ※Processing の draw と setup から区別するためにあえて別の名前を使っています

- コメントは vscode 拡張機能 `Better Comments` で分類されています

## 命名規則

グローバル変数/関数は`[プレフィックス]_camelCase`という形式で定義しています  
ローカル変数は`_camelCase`という形式で定義しています(先頭アンダースコア)

プレフィックス

- なし → 全体で共有するロジック
- S\* → シーンロジック
- V\* → ブロック崩しの依存ロジック

## アセット

### エフェクト

効果音ラボ

### BGM

かずち | ビーボルト  
かずち | Flutter  
かずち | 流幻  
かずち | 日没廃校

https://www.khaimmusic.com | New Morning

Ucchii0-うっちーぜろ- | たったそれだけの物語

### フォント

もじワク研究 | 廻想体 ネクスト ユーピー（B）

瀞ノグリッチ黒体

JetBrainsMono

## ライセンス

2024 © famisics (https://uiro.dev)
