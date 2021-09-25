# **VirtualBox のネットワークアダプターについて**

## **各ネットワークの説明**

### **内部ネットワーク**

### **NAT**

そもそも NAT とは`Network Address Translation`の略で、「ネットワークアドレス変換」ともいう。LAN に接続された端末からインターネットに接続する際に、「プライベート IP アドレス」を自動的に外部ネットワークで接続できる「グローバル IP アドレス」に変換する機能のこと（[引用](https://www.otsuka-shokai.co.jp/words/nat.html)）。
![NATの概要図](images/2021-09-26-00-13-39.png)

VirtualBox の場合、「NAT」の設定は以下の様な構成を表す。
![VBのNAT設定の概要図](images/2021-09-25-19-05-20.png)
特徴は以下の通り。

1. 内部 ⇒ 外部の通信がメイン
2. VM 毎に NAT 接続が作られるので、VM 同士の通信は不可

## **参考文献・サイト**

- [VirtualBox のネットワークアダプタまとめ](https://qiita.com/pitao/items/0f9475e4c0e230911eb7)
  > ばり参考になる。一番分かりやすい。
- [VirtualBox のネットワーク設定を絵で説明する](https://qiita.com/feifo/items/0fde474005589afcff68)
  > これもいい感じに分かりやすい。
