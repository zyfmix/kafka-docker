#!/usr/bin/env bash

set -xe

RUNNER=${1:-"brtc-local"}
#RUNNER=${1:-"brtc-test"}
#RUNNER=${1:-"trtc-dev"}

([ "$RUNNER" != "brtc-local" ] && [ "$RUNNER" != "brtc-test" ] && [ "$RUNNER" != "trtc-dev" ]) && echo "参数[RUNNER: $RUNNER]不合法,目前仅支持[brtc-local,brtc-test,trtc-dev]!" && exit

[ "$RUNNER" == "brtc-local" ] && {
  BSP=127.0.0.1:9092

  # Topics 列表
  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --list
}

[ "$RUNNER" == "brtc-test" ] && {
  BSP=52.80.188.106:9092,52.80.249.76:9092,52.80.251.252:9092

  # Topics 列表
  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --list

  # Topic 详情
#  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic brtc-test-topic

  # 重置 offset
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group brtc-test-group --topic brtc-test-topic --reset-offsets --to-datetime 2021-04-09T09:00:00.000 --execute

  # 消费组列表
  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --list

  # 消费组详情
#  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group brtc-test-group --describe
#  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group brtc-tmp-group --describe

  # 消费组[brtc-test-group]
#  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server=$BSP --group brtc-test-group --topic brtc-test-topic

  # 消费组[brtc-tmp-group]
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server=$BSP --group brtc-tmp-group --topic brtc-test-topic

  # 生产者
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-console-producer.sh --bootstrap-server=$BSP --topic brtc-test-topic
}

[ "$RUNNER" == "trtc-dev" ] && {
  BSP=test-www.baijiayun.com:59092

  # Topics 列表
  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --list

  # Topic 详情
  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic trtc-transfer-dev

  # 重置 offset
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group trtc-dev-group --topic trtc-transfer-dev --reset-offsets --to-datetime 2021-04-07T09:00:00.000 --execute

  # 消费组列表
  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --list

  # 消费组详情
  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group default --describe
  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group logstash --describe
  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group trtc-dev-group --describe

  # 消费组[trtc-dev-group]
  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server=$BSP --group trtc-dev-group --topic trtc-transfer-dev

  # 生产者
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-console-producer.sh --bootstrap-server=$BSP --topic trtc-transfer-dev
}
