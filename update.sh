#!/bin/bash
git pull

chmod +x *.sh
./build.sh
git reset --hard origin/master