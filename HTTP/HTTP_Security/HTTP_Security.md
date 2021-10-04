# HTTP セキュリティ

## コンテンツセキュリティポリシー（CSP）

クロスサイトスクリプティング（XSS）やデータインジェクション攻撃などのような、特定の種類の攻撃を検知し、影響を軽減する為に追加できるセキュリティレイヤー。

CSP を有効にするには、ウェブサーバーから`Content-Security-Policy`HTTP ヘッダーを返すように設定する必要がある。

他にも、`<meta>`要素を用いてポリシーを指定することも可能で、例えば：`<meta http-equiv="Content-Security-Policy" content="default-src 'self'; img-src https://*; chils-src 'none';">`

## Strict-Transport-Security

ウェブサイトがブラウザ側に`HTTP`の代わりに`HTTPS`を用いて通信する様に指示する為のもの。レスポンスヘッダーの一種。

ディレクティブとしては以下の様なモノがある。

- `max-age=<expire-time>`
  > 秒単位でそのサイトに`HTTPS`だけで接続する事をブラウザが記憶する時間。
- `includeSubDomains`（省略可能）
  > 省略可能で、この非 kk 数が指定されると、この規則がサイトの図べ手のサブドメインにも適用される。
- `preload`（省略可能）
  > [詳細](https://hstspreload.org/)

## 参考文献・サイト

- [コンテンツセキュリティポリシー (CSP)](https://developer.mozilla.org/ja/docs/Web/HTTP/CSP)
- [Strict-Transport-Security](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Strict-Transport-Security)
