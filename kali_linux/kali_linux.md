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
