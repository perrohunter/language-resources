default: start-services

test:
	vegeta attack -targets=targets.txt -rate=10 -duration=5s | vegeta report

start-services:
	docker run --name docker-php -p 4001:80 perrohunter/docker-php &
	docker run --name docker-ruby -p 4002:4567 perrohunter/docker-ruby ruby app.rb -o 0.0.0.0 &
	docker run --name docker-nodejs -p 4003:3000 perrohunter/docker-nodejs &
	docker run --name docker-python-quart -p 4004:5001 perrohunter/docker-python-quart &
	docker run --name docker-java -p 4005:8080 perrohunter/docker-java &
	docker run --name docker-go -p 4006:8080 perrohunter/docker-go &

pull-images:
	docker pull perrohunter/docker-php
	docker pull perrohunter/docker-ruby
	docker pull perrohunter/docker-nodejs
	docker pull perrohunter/docker-python-quart
	docker pull perrohunter/docker-java
	docker pull perrohunter/docker-go

rm-services:
	docker stop docker-php
	docker rm docker-php
	docker stop docker-ruby
	docker rm docker-ruby
	docker stop docker-nodejs
	docker rm docker-nodejs
	docker stop docker-python-quart
	docker rm docker-python-quart
	docker stop docker-java
	docker rm docker-java
	docker stop docker-go
	docker rm docker-go

test-services:
	echo "GET http://localhost:4001/" | vegeta attack -rate 100 -duration=5s | vegeta report
	echo "GET http://localhost:4002/" | vegeta attack -rate 100 -duration=5s | vegeta report
	echo "GET http://localhost:4003/" | vegeta attack -rate 100 -duration=5s | vegeta report
	echo "GET http://localhost:4004/" | vegeta attack -rate 100 -duration=5s | vegeta report
	echo "GET http://localhost:4005/" | vegeta attack -rate 100 -duration=5s | vegeta report
	echo "GET http://localhost:4006/" | vegeta attack -rate 100 -duration=5s | vegeta report