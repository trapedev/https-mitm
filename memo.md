# メモ

## 前提条件

被害者は、

1. 偽 [`SSID`](https://e-words.jp/w/SSID.html) を有する無線 LAN アクセスポイント（以下、`AP`）を利用する。
2. [`https`](https://developer.mozilla.org/ja/docs/Glossary/https) 通信で任意のサイトを閲覧する。
3. 通信先を確認しない。
4. 主にスマホを利用している事を想定（勿論 PC も想定）

## 最終目的

以下の全てを満たす事が目標。

- [ ] `AP` を用いてクライアントとサーバとの通信に割り込み、そのパケットの傍受・改竄を行う。
- [ ] 被害者側のデバイスに警告を出さない。

## 考察

1. [前提条件](https://github.com/KeiTaylor0606/https-mitm/blob/main/memo.md#%E5%89%8D%E6%8F%90%E6%9D%A1%E4%BB%B6)の`2`より、`SSL/TLS`証明書の問題を突破/回避する必要があるが、[`HSTS`](https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Strict-Transport-Security)の普及により、既存の[`SSLStrip`](https://www.venafi.com/blog/what-are-ssl-stripping-attacks)ツールは無効となっている。
2. `SSL/TLS`証明書の問題の突破/回避は難しい。

   > 理由は以下の通り
   >
   > > 1. 中間者が正当な証明書を持っていたとしても、被害者のブラウザ側で[名前検証](https://tex2e.github.io/rfc-translater/html/rfc2818.html)を行うので、被害者の通信先と実際の通信先が異なる事が発覚し、被害者に警告が出る。
   > > 2. 証明書の公開鍵のみを変更しても、デジタル署名の検証で発覚してしまう。
   > > 3. 自己署名証明書の様な[`root`認証局](https://e-words.jp/w/%E3%83%AB%E3%83%BC%E3%83%88CA.html)の認証がないものは、警告が出る。
   >
   > etc.

   従って、証明書を突破/回避よりも、[`root`証明書](https://support.dnsimple.com/articles/what-is-ssl-root-certificate/)をインポート・登録させる、或いはアプリ等をインストールさせ、その`LAN`内での通信を半ば強制的にプロキシ経由させる方が現実的。

3. `root`証明書をインポートさせる方法として、現時点で考えているのは主に以下の 2 点。
   > 1. アプリをインストールさせると同時に、プロキシサーバーの`root`証明書をインポート・登録させる方法。これに関しては、近年「ANA」や「セブンイレブン」等の企業が、自身が提供している無線`LAN`に顧客が接続する際の条件の 1 つとして、自社アプリのインストールを設けている。従って、ユーザーにとってアプリのインストール自体はあまり抵抗がないのではとの事。
   > 2. [`Captive Portal`](https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/captivePortal)を用いて、「認証」と偽り該当の`root`証明書をインポート・登録させる方法。

## クリアすべき制約

- [ ] `SSL/TLS`証明書問題（一番重い）
  > 具体的には以下の様なもの。
  >
  > > 1.  真のサーバーの証明書に対して、攻撃者が偽造を仕掛ける余地はあるのか（これに関しては、ほぼ不可能として進めている）。
  > > 2.  攻撃者が[透過型プロキシ](https://milestone-of-se.nesuke.com/sv-advanced/server-software/transparent-proxy/)を利用して通信を傍受したとして、そのプロキシの`root`証明書をどの様にして被害者側のデバイスにインポート・登録させるか。
  >
  > etc.

## これまでの案
