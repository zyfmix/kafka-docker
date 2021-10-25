
********************************************************************************************************************************************************************************************************

## Kafka 消息

```bash
BSP=test-www.baijiayun.com:59092
BSP=52.80.188.106:9092,52.80.249.76:9092,52.80.251.252:9092
```

* 创建 topic

```bash
docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --create --topic brtc-vcs-test --partitions 4 --replication-factor 2
```

* 删除 topic

```bash
docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --delete --topic brtc-vcs-test
```

* 查看 topics 列表

```bash
docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --list
```

* 查看 topic 详情

> brtc-vcs-test

```bash
docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic brtc-vcs-test
```

* 消费者

```bash
docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-console-consumer.sh --topic brtc-vcs-test --bootstrap-server=$BSP
```

* 消费组

```bash
docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-console-consumer.sh --topic brtc-vcs-test --bootstrap-server=$BSP --group brtc-vcs-group
```

* 生产者

```bash
docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic brtc-vcs-test
docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-console-producer.sh --topic brtc-vcs-test --bootstrap-server=$BSP
```

* 重置偏移量

```bash
docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --list
docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group brtc-vcs-group --describe
```

docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group brtc-vcs-group --reset-offsets --topic brtc-vcs-test --to-datetime 2021-04-09T11:00:00.000 --execute

********************************************************************************************************************************************************************************************************

### kafkacat 安装

MacOS

```bash
brew install kafkacat
```

源码编译安装

```bash
yum update -y && yum install gcc-c++ git librdkafka-devel -y
```

> 在 CentOS 上使用以上命令找不到官方安装包,于是使用以下方法源码编译安装 `librdkafka`

```bash
sudo yum install -y  openssl-devel cyrus-sasl
git clone git@github.com:edenhill/librdkafka.git
cd librdkafka
./configure --install-deps
make
sudo make install
```

开始编译

```bash
git clone https://github.com/edenhill/kafkacat
cd kafkacat && ./configure
make && make install
```

[](https://blog.yowko.com/centos-kafkacat/)

如果执行 `kafkacat` 命令报以下错误

> Error while loading shared libraries: librdkafka.so.1: cannot open shared object file: No such file or directory

则添加到 ld 配置库

```bash
echo "/usr/local/lib">> /etc/ld.so.conf
ldconfig 
```

[Error while loading shared libraries: librdkafka.so.1: cannot open shared object file: No such file or directory](https://github.com/edenhill/librdkafka/issues/466)

### 用法

订阅一个主题

```bash
kafkacat -b 127.0.0.1:9092 -t test
```

* 生产者 producer

```bash
kafkacat -P -b 127.0.0.1:9092 -t test
```

* 消费者 consumer

```bash
kafkacat -b 127.0.0.1:9092 -t test
```

* 查看 topics

```bash

```

kafkacat -b 182.92.226.149:9092,182.92.226.149:9093,182.92.226.149:9094 -G rtc-zyf-group vloud-collection-zyf

********************************************************************************************************************************************************************************************************
