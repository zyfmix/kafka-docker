
********************************************************************************************************************************************************************************************************

## Kafka 消息队列

```bash
docker-compose up
docker-compose down
```

## 常见问题

* 基于alpine构建镜像报错temporary error (try again later)？

描述：通过alpine构建其他的镜像报错，报临时文件不可用，但是，通过浏览器是直接可以下载到tar包的。

```bash
ERROR: http://mirror.yandex.ru/mirrors/alpine/v3.5/main: temporary error (try again later)
WARNING: Ignoring APKINDEX.3033a77c.tar.gz: No such file or directory
fetch http://mirror.yandex.ru/mirrors/alpine/v3.5/community/x86_64/APKINDEX.tar.gz
ERROR: http://mirror.yandex.ru/mirrors/alpine/v3.5/community: temporary error (try again later)
WARNING: Ignoring APKINDEX.073ff569.tar.gz: No such file or directory
```

解决：通过本地的网络进行构建,问题得到解决。

[command]
```bash
docker build -t kafka:0.0.1 . --network=host
```

[docker-compose.yaml]
```yaml
version: '3.4'
services:
  kafka:
    build:
      context: .
      network: host
```

[基于alpine构建镜像报错temporary error (try again later)？](https://www.cnblogs.com/chuanzhang053/p/12779332.html)

********************************************************************************************************************************************************************************************************
