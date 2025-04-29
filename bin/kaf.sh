#!/usr/bin/env bash

set -xe

# 运行耗时统计
runStartTs=$(date +%s)
echo "[执行开始][$(date '+%Y-%m-%d %H:%M:%S')]"

#RUNNER=${1:-"brtc-local"}
#RUNNER=${1:-"brtc-test"}
#RUNNER=${1:-"rtc-dev"}
#RUNNER=${1:-"rtc-online"}
RUNNER=${1:-"rtc-test"}
#RUNNER=${1:-"msms-test"}
#RUNNER=${1:-"msms-online"}

([ "$RUNNER" != "brtc-local" ] && [ "$RUNNER" != "brtc-test" ] && [ "$RUNNER" != "rtc-online" ] && [ "$RUNNER" != "rtc-test" ] && [ "$RUNNER" != "rtc-aliyun" ] && [ "$RUNNER" != "msms-test" ] && [ "$RUNNER" != "msms-online" ] && [ "$RUNNER" != "reset" ]) && echo "参数[RUNNER: $RUNNER]不合法,目前仅支持[brtc-local,brtc-test,rtc-dev,rtc-online,reset]!" && exit

[ "$RUNNER" == "rtc-online" ] && {
  #BSP=test-www.baijiayun.com:59092,test-www.baijiayun.com:59093,test-www.baijiayun.com:59094
  BSP=172.17.1.18:9092,172.17.1.19:9092,172.17.1.20:9092,172.17.0.105:9092,172.17.0.106:9092

  kaf -b $BSP topics

  kaf -b $BSP group describe logstash

  kaf -b $BSP topic describe test-vconsole-event
  kaf -b $BSP topic describe beta-vconsole-event
  kaf -b $BSP topic describe online-vconsole-event

  kaf -b $BSP group describe test-vconsole-change
  kaf -b $BSP group describe beta-vconsole-change
  kaf -b $BSP group describe online-vconsole-change

  kaf -b $BSP group describe rectifier
  kaf -b $BSP group describe vrc-beta
  kaf -b $BSP group describe vrc-test

  kaf -b $BSP group describe test-kafka-muti-cdn-event
  kaf -b $BSP group describe beta-kafka-muti-cdn-event
  kaf -b $BSP group describe online-kafka-muti-cdn-event
}

[ "$RUNNER" == "rtc-test" ] && {
  BSP=172.17.0.39:9092,172.17.0.40:9092,172.17.0.41:9092

  kaf -b $BSP topics

  kaf -b $BSP group describe logstash

  kaf topic create rtc-message-local -p 12 -r 2
  kaf topic create vcs-sn-event-local -p 3 -r 2
  kaf topic create vcs-sn-change-local -p 3 -r 2
  kaf topic create collection-local -p 4 -r 2
  kaf topic create collection-trtc-local -p 4 -r 2
  kaf topic create cdn-pull-local -p 3 -r 2

  kaf topic create rtc-message-dev -p 12 -r 2
  kaf topic create vcs-sn-event-dev -p 3 -r 2
  kaf topic create vcs-sn-change-dev -p 3 -r 2
  kaf topic create collection-dev -p 4 -r 2
  kaf topic create collection-trtc-dev -p 4 -r 2
  kaf topic create cdn-pull-dev -p 3 -r 2

  kaf topic create rtc-message-test -p 32 -r 2
  kaf topic create vcs-sn-event-test -p 3 -r 2
  kaf topic create vcs-sn-change-test -p 3 -r 2
  kaf topic create collection-test -p 4 -r 2
  kaf topic create collection-trtc-test -p 4 -r 2
  kaf topic create cdn-pull-test -p 3 -r 2

  kaf topic create local-vcollections-player-report -p 3 -r 2
  kaf topic create dev-vcollections-player-report -p 3 -r 2
  kaf topic create test-vcollections-player-report -p 3 -r 2

  kaf topic create local-vcollections-blive-report -p 3 -r 2
  kaf topic create dev-vcollections-blive-report -p 3 -r 2
  kaf topic create test-vcollections-blive-report -p 3 -r 2

  kaf topic create test-rtc-bmcu-message -p 12 -r 2
  kaf topic create dev-rtc-bmcu-message -p 12 -r 2
  kaf topic create local-rtc-bmcu-message -p 12 -r 2

  kaf topic create test-rtc-bmcu-notify -p 12 -r 2
  kaf topic create dev-rtc-bmcu-notify -p 12 -r 2
  kaf topic create local-rtc-bmcu-notify -p 12 -r 2

  #kaf -b $BSP topic describe vcs-sn-event-local
  #kaf -b $BSP topic describe vcs-sn-event-dev
  #kaf -b $BSP topic describe vcs-sn-event-test

  #kaf -b $BSP topic describe vcs-sn-change-local
  #kaf -b $BSP topic describe vcs-sn-change-dev
  #kaf -b $BSP topic describe vcs-sn-change-test

  #kaf -b $BSP topic describe rtc-message-local
  #kaf -b $BSP topic describe rtc-message-dev
  #kaf -b $BSP topic describe rtc-message-test

  kaf -b $BSP group describe vrc-test
}

# 运行耗时统计
runEndTs=$(date +%s)
runTotalTs=$((runEndTs - runStartTs))
echo "[运行耗时统计][runStartTs: $runStartTs][runEndTs: $runEndTs][runTotalTs: $runTotalTs]"

echo "[执行结束][$(date '+%Y-%m-%d %H:%M:%S')]"
