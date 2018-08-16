#!/bin/bash

cd ..
cd docker-os && git pull && ./build.sh && cd ..
cd docker-java && git pull  && chmod +x *.sh -R && ./build.sh && cd ..
cd docker-zookeeper && git pull  && chmod +x *.sh -R && ./build.sh && cd ..
cd docker-kafka-broker&& git pull  && chmod +x *.sh -R && ./build.sh && cd ..

cd aws-image-builder