# HTTP セキュリティ

## コンテンツセキュリティポリシー（CSP）

クロスサイトスクリプティング（XSS）やデータインジェクション攻撃などのような、特定の種類の攻撃を検知し、影響を軽減する為に追加できるセキュリティレイヤー。

CSP を有効にするには、ウェブサーバーから`Content-Security-Policy`HTTP ヘッダーを返すように設定する必要がある。

他にも、`<meta>`要素を用いてポリシーを指定することも可能で、例えば：`<meta http-equiv="Content-Security-Policy" content="default-src 'self'; img-src https://*; chils-src 'none';">`

## 参考文献・サイト

- [コンテンツセキュリティポリシー (CSP)](https://developer.mozilla.org/ja/docs/Web/HTTP/CSP)
