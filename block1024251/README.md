# 地球再生計画 クライアント (Processing)

1024251 山﨑拓己 (famisics / https://uiro.dev)

# 地球再生計画 プロキシサーバー (node.js)

node.js が必要です

server.jsの `const port = ****;` とblock1024251.pdeの ``

環境構築の際はそれぞれのディレクトリ上で以下のコマンドを実行してください

## 環境構築

```bash
# npm
npm install

# pnpm
pnpm install

# yarn
yarn install

# bun
bun install
```

## サーバー起動

```bash
# npm
npm start

# pnpm
pnpm start

# yarn
yarn start

# bun
bun start
```


## ゲームの起動前にnodeサーバーをスタートさせてください

付属のサーバーを立ち上げる！サーバーの立ち上げ方どうしよう、node/pnpm入れてもらうわけにいかないし  
node 持ち歩くで検索して.batで起動するようにできるらしい、これできたらつよい

ゲーム本体とサーバーをセットでzipして配るのが理想

使っていないとサーバーが落ちるので、それをどうしよう、使うときだけ課金もあり

famisics/Processing-Clientでクライアントだけ公開する必要がある

## 関連するリポジトリ/仕様

famisics/Processing-Client -> ゲーム本体 / クライアント(Processing)

famisics/Processing-Proxy -> プロキシサーバー(node.js/websocket)

famisics/Processing-Server -> 公開サーバー(node.js/express/websocket)

> 公開サーバーの詳細  
> host: wss://proc.uiro.dev
> インフラ: Cloudflare DNS(プロキシ) / Render(ホスティング)
> 本体の仕様: node.js(実行環境) / pnpm(パッケージマネージャー) / express(httpサーバー) / websocket(双方向通信)  
> プロキシ - 公開サーバーの通信はSSLに対応しています  
> DNSでddos対策されてます

## 詳細

マルチプレイ能力バトル系

能力
・時間停止
・相手の

チャージする
地球にENERGYを集めるモチーフ

必要のない計算、再描画が極力減るように意識している  
update(draw)とboot(setup)を分けるなど  
※Processingのdrawとsetupから区別するためにあえて別の名前を使っています

サーバーでマルチプレイが可能

## 開発環境

コメントはvscode拡張機能 `Better Comments` で分類されています

## 命名規則
グローバル変数/関数は`[プレフィックス]_camelCase`という形式で定義しています  
ローカル変数は`_*`という形式で定義しています(先頭アンダースコア)

- なし → 全体で共有するロジック
- S* → シーンロジック
- V* → ブロック崩しの依存ロジック

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
2024 © famisics(https://uiro.dev)

### やること

- [ ]  スコアボードが正しく動いているか
- [ ]  操作方法が正しく動いているか
- [ ]  スキルの送信と受信が正常か
- [ ]  ゲームの流れが正しいか
- [ ]  表記揺れがないか
- [ ]  すべてのスキルの動作は正常か
- [ ]  カットインとカットインのユーザー名表示は正常か
- [ ]  スキル発動に必要なポイントの検知と、ポイントが足りないという表示

## 制作が必要なもの

- [ ]  説明スライド
- [ ]  報告書
- [ ]  SE音
- [ ]  スコアボードをresultに表示する
