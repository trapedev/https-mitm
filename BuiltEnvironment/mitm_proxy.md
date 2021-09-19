# mitmproxy の環境構築

## 使用環境

- Ubuntu 18.04
- Oracle Virtual Box
- Windows 10

## 手順

### Ubuntu 側

1. 基本的に構築手順は同じだが、「ネットワーク」の設定に関しては「ブリッジアダプター」にする。これは、ホスト OS から仮想マシンに接続できるようにする為である。
2. [このサイト](https://qiita.com/pro_matuzaki/items/cceaead10a0a567e5bf9)に従って構築する（たまに pip コマンドがみつからないなんて言われるので、その時は[このサイト](https://www.bioerrorlog.work/entry/install-pip-pip3-ubuntu)を参考にしてみるとよい）。
3. Ubuntu を起動して、コマンドプロンプトで`$ mitmproxy`と打つ（これで、mitmproxy が起動する）。
4. コマンドプロンプトで`$ ip a`と打って、マシンの IP アドレスを確認しておく。

### PC 及びブラウザ側

1. Window 画面より「ファイル名を指定して実行」と検索し、名前の欄に「ms-settings:network-proxy」と入力して「OK」を押す。
2. 表示された画面より、「手動プロキシ セットアップ」を「オン」にして、「アドレス」に仮想マシンの IP アドレスを、「ポート」に`8080`を指定して「保存」する。
3. 上記の設定が完了したら、'''http://mitm.it/'''にアクセスして、該当する証明書をインストールする。
4. 証明書のインストール手順については[このサイト](https://self-development.info/%E3%80%90%E6%82%AA%E7%94%A8%E5%8E%B3%E7%A6%81%E3%80%91mitmproxy%E3%82%92%E4%BD%BF%E3%81%88%E3%81%B0ssl%E9%80%9A%E4%BF%A1%E3%81%A7%E3%82%82%E5%82%8D%E5%8F%97%E3%81%A7%E3%81%8D%E3%82%8B/)を参照。

## 参考文献・サイト

- [iOS 実機の SSL 通信をプロキシによって傍受したり改ざんする方法](https://qiita.com/yimajo/items/c67cb711851f747c35e5)
- [mitmproxy で OSX 上に透過型プロクシを立てる方法](https://gist.github.com/ykst/6fbdfe81d75a0a690559f2a405aec6a6)
- [【2019 年 12 月版】mitmproxy でアプリの通信内容を確認したい](https://qiita.com/pro_matuzaki/items/cceaead10a0a567e5bf9)
- [Ubuntu で pip/pip3 がインストールできないときの対処法|Python](https://www.bioerrorlog.work/entry/install-pip-pip3-ubuntu)
- [【悪用厳禁】mitmproxy を使えば SSL 通信でも傍受できる](https://self-development.info/%E3%80%90%E6%82%AA%E7%94%A8%E5%8E%B3%E7%A6%81%E3%80%91mitmproxy%E3%82%92%E4%BD%BF%E3%81%88%E3%81%B0ssl%E9%80%9A%E4%BF%A1%E3%81%A7%E3%82%82%E5%82%8D%E5%8F%97%E3%81%A7%E3%81%8D%E3%82%8B/)
