
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

### kafkacat 用法

```bash
brew install kafkacat
```

订阅一个主题

```bash
kafkacat -b 127.0.0.1:9092 -t sne
```

********************************************************************************************************************************************************************************************************
