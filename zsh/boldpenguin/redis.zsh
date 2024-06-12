redis_start() {
  brew services start redis
}

redis_stop() {
  brew services stop redis
}

redis_ping() {
  redis-cli ping
}

redis_startup() {
  if [ "$(redis-cli ping)" != 'PONG' ]; then
      echo "Redis is not running. Starting Redis..."
      redis_start
      redis-cli flushall
    else
      echo "Redis is already running"
      redis-cli flushall
  fi
}

opensearch_startup() {
  if curl -XGET 'http://localhost:9200/_nodes/_all' > /dev/null 2>&1; then
    echo "OpenSearch is already running" && curl -X DELETE 'http://localhost:9200/_all'
  else
    echo "OpenSearch is not running. Starting OpenSearch..."
    brew services start opensearch
    echo "Waiting for OpenSearch to start..."
    sleep 30
    echo "Deleting all indices..."
    curl -X DELETE 'http://localhost:9200/_all'
    sleep 10
  fi
}

service_starter() {
  redis_startup
  opensearch_startup
}