#!/bin/sh -e

# shellcheck disable=SC1091
source "/usr/bin/versions.sh"

FILENAME="kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz"
FILEPATH="${KAFKA_VERSION}/${FILENAME}"

retry=0

while [ $retry -le 5  ]; do
  url=$(curl --stderr /dev/null "https://www.apache.org/dyn/closer.cgi?path=/kafka/${FILEPATH}&as_json=1" | jq -r '"\(.preferred)\(.path_info)"')

  # Test to see if the suggested mirror has this version, currently pre 2.1.1 versions
  # do not appear to be actively mirrored. This may also be useful if closer.cgi is down.
  if [[ ! $(curl -s -f -I "${url}") ]]; then
      echo "Mirror does not have desired version, downloading direct from Apache"
      url="https://archive.apache.org/dist/kafka/${FILEPATH}"
  fi
  echo "Downloading Kafka from $url"

  cd /tmp
  wget "${url}" -O "/tmp/${FILENAME}" &&
  wget "https://www.apache.org/dist/kafka/KEYS" -O /tmp/KEYS &&
  wget "https://www.apache.org/dist/kafka/${FILEPATH}.asc" -O  "/tmp/${FILENAME}.asc" &&
  wget "https://www.apache.org/dist/kafka/${FILEPATH}.sha512" -O "/tmp/${FILENAME}.sha512" &&
  gpg --import KEYS && gpg --verify "${FILENAME}.asc" &&
  gpg --print-md sha512 "${FILENAME}" | diff "${FILENAME}.sha512" - && exit 0 || retry=$(( retry + 1 ))
done

# retries exceeded
exit 1


