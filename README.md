# HTTPS の中間者攻撃と、その新手法についての研究

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

- [ ] 被害者側のハードルを低くする。
  > 制約ではないが、具体的には以下のようなもの。
  >
  > > 1.  被害者が行う操作の工数を少なくする。
  > > 2.  操作を簡単にする。(ex. ボタンを押す/簡単な情報を入力する)
  >
  > etc.

## これまでの案

## その他参考文献・サイト

- [～誰かの失敗を他山の石に～脆弱性事例に学ぶセキュアコーディング「SSL/TLS 証明書検証」編](https://www.jpcert.or.jp/present/2014/20141108SSLTLS-vul.pdf)
  > 2014 年
  >
  > 名前検証の不備により事例が書かれている。
- [New Tricks For Defeating SSL In Practice](https://blackhat.com/presentations/bh-europe-09/Marlinspike/blackhat-europe-2009-marlinspike-sslstrip-slides.pdf)
  > 2009 年
  >
  > blackhat で紹介された ssl-strip 攻撃を利用した mitm の手法が紹介されている。既に対策されている。
- [iOS 実機の SSL 通信をプロキシによって傍受したり改ざんする方法](https://qiita.com/yimajo/items/c67cb711851f747c35e5)
  > 2014 年 2 月 21 日
  >
  > `「OS XからiPhoneへこの証明書をメール送信し、iPhone側のメールクライアントから証明書を開くことでインストールすることが可能」`の部分から、証明書をスマホデバイスにインストールすることが可能であることが分かる。これをアプリの内部で実行できたりしないだろうか...。
- [HSTS による対策を回避可能な sslstrip 攻撃](https://www.sci.kanagawa-u.ac.jp/info/matsuo/pub/pdf/IPSJCSS2016107.pdf)

  > 2016 年 10 月 13 日
  >
  > 前提条件的に、今これを適用させるのは厳しい。

- [HSTS – A Trivial Response to sslstrip](https://www.secplicity.org/2019/11/05/hsts-a-trivial-response-to-sslstrip/)

  > 2019 年 11 月 5 日
  >
  > `HSTS`について書かれている比較的新しい記事。

- [TLS 復号化](https://wiki.wireshark.org/TLS)

  > 2020 年 5 月 20 日
  >
  > `Wireshark`の`TLS`復号について。

- [フリー Wi-Fi に接続したらサイトに接続できない場合の話](https://blog.anoncom.net/2020/08/what-happens-when-you-connect-to-free-Wi-Fi-and-cant-connect-to-the-web.html)

  > 2020 年 8 月 30 日
  >
  > 常時`https`通信だと`Captive Portal`できないという話。

- [SSL/TLS and captive portals](https://www.ssltrust.com/blog/ssl-tls-captive-portals)

  > 2021 年 11 月 1 日
  >
  > `SSL/TLS`と`Captive Portal`に関連する話題。

- [Command Injection](https://book.hacktricks.xyz/pentesting-web/command-injection)
  > 2021 年 7 月
  >
  > `Command Injection`攻撃に関する`Hack Trick`の記事。コマンドインジェクション攻撃の案は廃案になった。
