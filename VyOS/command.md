# VyOS のコマンド関連

## DNAT の設定

DNAT の設定は`set nat destination rule <ルール番号> <設定>`で行う。
具体的な設定値と説明は以下の通り。

- `destination address`
  > 受信する IP アドレスを指定
- `destination port`
  > 受信するポート番号を指定
- `inbound-interface`
  > 受信するインターフェイスを指定
- `protocol`
  > プロトコルを指定
- `translation address`
  > 転送する IP アドレスを指定
- `translation port`
  > 転送するポート番号を指定

## 参考文献・サイト

- [VyOS コマンドまとめ](https://qiita.com/tnan1102/items/95cda5b6a8141980577c)
- [VyOS](https://qiita.com/fururun02/items/6a02851fa21a9d461994)
- [VyOS でプライベート IP の自宅ネットワークにリモートアクセスしたい！(環境構築編)](https://qiita.com/shin-ch13/items/3094785d6234c47da911)
- [VyOS のコマンド一覧](https://ichibariki.com/entry/2018/06/16/220219#delete-1)
