#!/usr/bin/env bash

set -e

# 自动寻找 compose 文件
COMPOSE_FILE=""
if [[ -f "docker-compose.yml" ]]; then
  COMPOSE_FILE="docker-compose.yml"
elif [[ -f "docker-compose.yaml" ]]; then
  COMPOSE_FILE="docker-compose.yaml"
else
  echo "❌ 未找到 docker-compose 文件"
  exit 1
fi

echo "📌 使用 compose 文件: $COMPOSE_FILE"

echo "⬇️ 拉取最新镜像..."
docker compose -f "$COMPOSE_FILE" pull

echo "🔄 重建并更新容器..."
docker compose -f "$COMPOSE_FILE" up -d --remove-orphans

echo "🧹 清理无用镜像..."
docker image prune -f

echo "✅ 更新完成！"