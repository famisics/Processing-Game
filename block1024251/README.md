# 地球再生計画 クライアント (Processing)

1024251 山﨑拓己 (famisics / https://uiro.dev)

## ゲームの起動前にnodeサーバーをスタートさせてください

付属のサーバーを立ち上げる！サーバーの立ち上げ方どうしよう、node/pnpm入れてもらうわけにいかないし  
node 持ち歩くで検索して.batで起動するようにできるらしい、これできたらつよい

ゲーム本体とサーバーをセットでzipして配るのが理想

使っていないとサーバーが落ちるので、それをどうしよう、使うときだけ課金もあり

famisics/Processing-Clientでクライアントだけ公開する必要がある

## 関連するリポジトリ/仕様

famisics/Processing-Client -> ゲーム本体 / クライアント(Processing)

famisics/Processing-Localserver -> プロキシサーバー(node.js/websocket)

famisics/Processing-Server -> 公開サーバー(node.js/express/websocket)

> 公開サーバーの詳細  
> ホスティング: Cloudflare DNS(プロキシ) / Render(ホスティング)
> サーバー本体: node.js(実行環境) / pnpm(パッケージマネージャー) / express(httpサーバー) / websocket(双方向通信)  
> プロキシ - 公開サーバーの通信はSSLに対応しています  
> DNSでddos対策されてます

## 詳細

マルチプレイ能力バトル系

能力
・時間停止
・相手の

チャージする
地球にENERGYを集めるモチーフ

必要のない計算、再描画が極力減るように意識している (drawとbootを分けるなど)

サーバーでマルチプレイが可能

## 開発環境
vscode, processing-java
コメントは`Better Comments`で分類されています

## 命名
グローバル変数/関数は`[FLAG]_camelCase`という形式で定義しています

## アセット
効果音ラボ
「無料ベクター 惑星リアルな透明セット」著作者：macrovector／出典：Freepik

## ライセンス
2024 © famisics(https://uiro.dev)

ソロプレイ 通貨を貯める
マルチ 数人でCRTDMGを使って増やす time osoku mode
現在通過順位
ローカルにはuseridだけ保存
