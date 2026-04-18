#!/usr/bin/env bash

# docker build . -t valet-tests-slimdeb:latest --progress plain
# docker tag valet-tests-slimdeb:latest noyacode/valet-tests-slimdeb:latest
# docker push noyacode/valet-tests-slimdeb:latest

docker run --rm -it --entrypoint /usr/local/bin/bash-5.0 noyacode/valet-tests-slimdeb:latest
docker run --rm -it --entrypoint /usr/local/bin/bash-5.1 noyacode/valet-tests-slimdeb:latest
docker run --rm -it --entrypoint /usr/local/bin/bash-5.2 noyacode/valet-tests-slimdeb:latest
docker run --rm -it --entrypoint /usr/local/bin/bash-5.3 noyacode/valet-tests-slimdeb:latest
