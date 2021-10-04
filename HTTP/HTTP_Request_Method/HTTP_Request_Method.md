# HTTP リクエストメソッド

## GET

`GET`（参照）メソッドは、指定したリソースの表現をリクエストする。`GET`を使用するリクエストは、データの読み取りに限る。

## HEAD

`HEAD`メソッドは`GET`リクエストと同じレスポンスを求めるが、レスポンス本文はない（ヘッダーのみの要求）。

## POST

`POST`（新規作成）は指定したリソースに実体を送信する為に使用するメソッド。サーバー上の状態を変更したり、副作用が発生したりする事がよくある。

## PUT

`PUT`（更新）メソッドは対象リソースの現在の表現の全体を、リクエストのペイロードで置き換える。

## DELETE

`DELETE`（削除）メソッドは、指定したリソースを削除する。

## CONNECT

`CONNECT`メソッドは、対象リソースで識別されるサーバーとの間にトンネルを確立する（つまり、プロキシを通す）。

## OPTIONS

`OPTIONS`メソッドは、対象リソースの通信オプションを示すために使用する。

## TRACE

`TRACE`メソッドは、対象リソースへのパスに沿ってメッセージのループバックテストを実行する（つまり、どの様な経路で届いたかを示す）。

## PATCH

`PATCH`（一部更新）メソッドは、リソースを部分的に変更する為に使用する。

## 参考文献・サイト

- [HTTP リクエストメソッド](https://developer.mozilla.org/ja/docs/Web/HTTP/Methods)
- [HTTP リクエストメソッドまとめ](https://qiita.com/morikuma709/items/956d7c58908cb481d7e8)
- [【HTTP リクエストメソッドとは？】8 つ覚えよう。GET、POST、PUT、DELETE、HEAD、OPTIONS、CONNECT、TRAC について。](https://satoriku.com/request-method/)
