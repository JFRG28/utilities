#!/bin/bash

# Verify Docker daemon active
if ! docker info > /dev/null 2>&1; then
    echo "Error: Docker is not running. Please, initiate it before to continue."
    exit 1
fi

echo "Initializing Docker containers: rabbitmq, accountsdb, loansdb, cardsdb, pacoredis"
docker run -d -it --rm --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:4-management
docker run -p 3306:3306 --name accountsdb -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=accountsdb -d mysql --port=3306
docker run -p 3307:3307 --name loansdb -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=loansdb -d mysql --port=3307
docker run -p 3308:3308 --name cardsdb -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=cardsdb -d mysql --port=3308
docker run -p 6379:6379 --name pacoredis -d redis
echo "Docker containers initialized: rabbitmq, accountsdb, loansdb, cardsdb, pacoredis"
