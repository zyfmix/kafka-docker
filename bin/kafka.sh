#!/usr/bin/env bash

set -xe

# 运行耗时统计
runStartTs=$(date +%s)
echo "[执行开始][$(date '+%Y-%m-%d %H:%M:%S')]"

#RUNNER=${1:-"brtc-local"}
#RUNNER=${1:-"brtc-test"}
#RUNNER=${1:-"rtc-dev"}
RUNNER=${1:-"rtc-online"}

([ "$RUNNER" != "brtc-local" ] && [ "$RUNNER" != "brtc-test" ] && [ "$RUNNER" != "rtc-dev" ] && [ "$RUNNER" != "rtc-online" ] && [ "$RUNNER" != "reset" ]) && echo "参数[RUNNER: $RUNNER]不合法,目前仅支持[brtc-local,brtc-test,rtc-dev,rtc-online,reset]!" && exit

[ "$RUNNER" == "brtc-local" ] && {
  BSP=1.ucs.iirii.com:9092

  # Topics 列表
  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --list
}

[ "$RUNNER" == "brtc-test" ] && {
  BSP=52.80.188.106:9092,52.80.249.76:9092,52.80.251.252:9092

  #- "kafka01:52.80.188.106"
  #- "kafka02:52.80.249.76"
  #- "kafka03:52.80.251.252"

  # Topics 列表
  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --list

  # Topic 详情
  #  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic brtc-test-topic

  # 重置 offset
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group brtc-test-group --topic brtc-test-topic --reset-offsets --to-datetime 2021-04-09T09:00:00.000 --execute

  # 消费组列表
  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --list

  # 消费组详情
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group brtc-test-group --describe
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group brtc-tmp-group --describe

  # 消费组[brtc-test-group]
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server=$BSP --group brtc-test-group --topic brtc-test-topic

  # 消费组[brtc-tmp-group]
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server=$BSP --group brtc-tmp-group --topic brtc-test-topic

  # 生产者
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-console-producer.sh --bootstrap-server=$BSP --topic brtc-test-topic
}

[ "$RUNNER" == "rtc-dev" ] && {
  BSP=182.92.226.149:9092,182.92.226.149:9093,182.92.226.149:9094

  # Topics 列表
  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --list
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --create --topic rtc-message-zyf --partitions 32

  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic trtc-transfer-zyf
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic collection-zyf
  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic zyf-test-balancestrategyrange-a
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic zyf-test-balancestrategyrange-b
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic zyf-test-balancestrategyrange-c

  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group kafkajs-zyf-group --describe
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group kafkago-zyf-group --describe
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group kafkago-zyf-group --describe | grep zyf-test-balancestrategyrange-a

  # 重置 offset
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group rtc-zyf-group --topic trtc-transfer-zyf --reset-offsets --to-datetime 2021-05-01T09:00:00.000 --execute
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group rtc-zyf-group --topic collection-zyf --reset-offsets --to-datetime 2021-05-01T09:00:00.000 --execute

  # 消费组列表
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --list

  # 消费组详情
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group default --describe
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group rtc-zyf-group --describe

  # 消费组[rtc-zyf-group]
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server=$BSP --group rtc-zyf-group --topic collection-zyf

  # 消费组[rtc-zyf-group]
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server=$BSP --group rtc-zyf-group --topic trtc-transfer-zyf

  # 消费组[rtc-zyf-group]
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server=$BSP --group rtc-zyf-group --topic vcs-sn-event-zyf

  # 消费组[rtc-zyf-group]
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server=$BSP --group rtc-zyf-group --topic collection-trtc-zyf
}

#trtc-callback-dev
[ "$RUNNER" == "rtc-online" ] && {
  BSP=test-www.baijiayun.com:59092,test-www.baijiayun.com:59093,test-www.baijiayun.com:59094

  # Topics 列表
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --list
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --create --topic rtc-message-zyf --partitions 32

  # change topic (rtc-message-dev) replicas
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic rtc-message-dev
  #docker run --rm -v /Users/coam/Server/Run/kafka-docker/configs:/opt/kafka/configs -it wurstmeister/kafka /opt/kafka/bin/kafka-reassign-partitions.sh --bootstrap-server=$BSP --reassignment-json-file /opt/kafka/configs/rtc-message-dev.json --execute

  # change topic (rtc-message-beta) replicas
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic rtc-message-beta
  #docker run --rm -v /Users/coam/Server/Run/kafka-docker/configs:/opt/kafka/configs -it wurstmeister/kafka /opt/kafka/bin/kafka-reassign-partitions.sh --bootstrap-server=$BSP --reassignment-json-file /opt/kafka/configs/rtc-message-beta.json --execute

  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic collection-prod
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic collection-trtc-prod
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic online_brtc_action_event
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic online_brtc_stats_event

  # 和 online_brtc_stats_event
  # change topics replicas
  #for loop in "rtc-message-dev" "rtc-message-beta" "rtc-message-prod" "vcs-sn-event-dev" "vcs-sn-event-beta" "vcs-sn-event-prod"
  for loop in "online_brtc_stats_event"; do
    echo "Start Alert Topic Env:$loop"
    # [](https://blog.knoldus.com/devops-shorts-how-to-increase-the-replication-factor-for-a-kafka-topic/)
    #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic $loop
    #docker run --rm -v /Users/coam/Server/Run/kafka-docker/configs:/opt/kafka/configs -it wurstmeister/kafka /opt/kafka/bin/kafka-reassign-partitions.sh --bootstrap-server=$BSP --reassignment-json-file /opt/kafka/configs/$loop.json --execute
  done

  # 消费组列表
  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --list
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group vrcs-test --delete

  # Topic 详情
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic trtc-transfer-dev
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic trtc-transfer-zyf
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic collection-zyf
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic collection-dev
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic collection-trtc-dev
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic vcs-sn-event-zyf
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic vcs-sn-event-dev
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic vcs-sn-event-beta
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic vcs-sn-event
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic vcs-sn-change-dev
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic vcs-sn-change-beta
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic vcs-sn-change
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic rtc-message-zyf
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic rtc-message-dev
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic rtc-message-beta
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server=$BSP --describe --topic rtc-message-prod

  # 重置 offset
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group console --topic vcs-sn-event --reset-offsets --to-datetime 2021-08-04T01:00:00.000 --execute
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group rtc-zyf-group --topic trtc-transfer-dev --reset-offsets --to-datetime 2021-06-01T09:00:00.000 --execute
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group rtc-zyf-group --topic collection-zyf --reset-offsets --to-datetime 2021-05-01T09:00:00.000 --execute
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group rtc-zyf-group --topic collection-prod --reset-offsets --to-datetime 2021-06-20T09:00:00.000 --execute
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group rtc-zyf-group --topic collection-dev --reset-offsets --to-datetime 2021-05-16T09:00:00.000 --execute
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group rtc-zyf-group --topic collection-trtc-dev --reset-offsets --to-datetime 2021-06-20T09:00:00.000 --execute
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group rtc-zyf-group --topic collection-trtc-dev --reset-offsets --to-offset 126610 --execute
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group rtc-zyf-group --topic rtc-message-dev --reset-offsets --to-datetime 2021-05-01T09:00:00.000 --execute
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group rectifier --topic rtc-message-dev --reset-offsets --to-datetime 2021-05-01T09:00:00.000 --execute
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group rectifier-zyf --topic rtc-message-zyf --reset-offsets --to-datetime 2021-05-01T09:00:00.000 --execute
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group recs --topic rtc-message-dev --reset-offsets --to-datetime 2021-08-01T09:00:00.000 --execute
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group vrc-beta --topic rtc-message-beta --reset-offsets --to-datetime 2021-10-08T07:20:00.000 --execute

  # 消费组详情
  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group default --describe
  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group logstash --describe
  # console-sne
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group console --describe | grep vcs-sn-event
  # console-snc
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group console --describe | grep vcs-sn-change
  # rectifier-rtc-message
  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group rectifier --describe | grep rtc-message
  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group vrc-beta --describe | grep rtc-message-beta
  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group vrc-test --describe | grep rtc-message-dev
  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group vrc-local --describe
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group rtc-zyf-group --describe | grep rtc-message-dev
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group rtc-zyf-group --describe

  # 删除组 rectifier 曾消费过的主题 rtc-message-beta
  # [](https://stackoverflow.com/questions/63704988/how-to-remove-a-kafka-consumer-group-from-a-specific-topic)
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group rectifier --topic rtc-message-dev --delete-offsets

  # 调整分区数-增加
  #[Adding Partitions to a Topic in Apache Kafka](https://www.allprogrammingtutorials.com/tutorials/adding-partitions-to-topic-in-apache-kafka.php)
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --alter --zookeeper 39.102.102.178:2181 --topic vcs-sn-event --partitions 8
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-topics.sh --alter --zookeeper 39.102.102.178:2181 --topic vcs-sn-change --partitions 8

  # 消费组
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server=$BSP --group rtc-zyf-group --topic trtc-transfer-dev
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server=$BSP --group rtc-zyf-group --topic collection-prod | grep action
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server=$BSP --group rtc-zyf-group --topic collection-dev
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server=$BSP --group rtc-zyf-group --topic collection-trtc-dev
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server=$BSP --group rtc-zyf-group --topic rtc-message-dev
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server=$BSP --group rtc-zyf-group --topic rtc-message-zyf
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server=$BSP --group rtc-zyf-group --topic vcs-sn-event-zyf
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server=$BSP --group rtc-zyf-group --topic vcs-sn-change-zyf

  # 生产者
  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-console-producer.sh --bootstrap-server=$BSP --topic trtc-transfer-dev
}

[ "$RUNNER" == "reset" ] && {
  BSP=test-www.baijiayun.com:59092,test-www.baijiayun.com:59093,test-www.baijiayun.com:59094

  host=test-www.baijiayun.com
  password="s8n73b@2ps&6k"
  rc_auth="redis-cli -h $host -p 36379 -a $password -n 0 --no-auth-warning"
  $rc_auth del dev:vrc:meet:room:hash
  for key in $($rc_auth keys dev:vrc:meet:room:release:*:sets); do
    $rc_auth del $key
  done

  #docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group default --topic vcs-sn-event-zyf --reset-offsets --to-datetime 2021-05-01T09:00:00.000 --execute
  docker run --rm -it wurstmeister/kafka /opt/kafka/bin/kafka-consumer-groups.sh --bootstrap-server=$BSP --group rectifier-zyf --topic rtc-message-dev --reset-offsets --to-datetime 2021-05-01T09:00:00.000 --execute
}

# 运行耗时统计
runEndTs=$(date +%s)
runTotalTs=$((runEndTs - runStartTs))
echo "[运行耗时统计][runStartTs: $runStartTs][runEndTs: $runEndTs][runTotalTs: $runTotalTs]"

echo "[执行结束][$(date '+%Y-%m-%d %H:%M:%S')]"
