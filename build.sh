#!/bin/bash

set -e 

cd ..
cd docker-os && git pull && ./build.sh && cd ..
cd docker-java && git pull  && chmod +x *.sh -R && ./build.sh && cd ..
cd docker-zookeeper && git pull  && chmod +x *.sh -R && ./build.sh && cd ..
cd docker-kafka-broker && git pull  && chmod +x *.sh -R && ./build.sh && cd ..
cd cdr-gen && git pull  && chmod +x *.sh -R && ./build.sh && cd ..
cd cdr-kafka-stream && git pull  && chmod +x *.sh -R && ./build.sh && cd ..
cd docker-debezium-connect && git pull  && chmod +x *.sh -R && ./build.sh && cd ..


cd aws-image-builder

docker stack deploy --compose-file docker-compose.yaml phone

URL=$(aws es describe-elasticsearch-domains --domain-names demo --region eu-central-1   | jq '.DomainStatusList[0].Endpoints.vpc' -r)
sed "s/URL/$URL/" connect.json.template   > connect.json
curl -XPOST http://127.0.0.1:8083/connectors -H "Content-Type: application/json" -d "@connect.json"
while [ $? -ne 0 ]; do
    URL=$(aws es describe-elasticsearch-domains --domain-names demo --region eu-central-1   | jq '.DomainStatusList[0].Endpoints.vpc' -r)
    sed "s/URL/$URL/" connect.json.template   > connect.json
	curl -XPOST http://127.0.0.1:8083/connectors -H "Content-Type: application/json" -d "@connect.json"    
done


