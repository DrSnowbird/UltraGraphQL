#!/bin/bash -x

trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT
HOST_hgql_1="http://localhost:8098/graphql"

# Color codes via https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux#5947802
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

function log() {
    # echo in color
    echo -e "${GREEN}${1}${NC}"
}

function rlog() {
    # echo in color
    echo -e "${RED}${1}${NC}"
}

PORT=8092
#HGGL_VERSION=3.0.1
HGGL_VERSION=2.0.0
CONFIGS_ROOT=./configs
SUBDIRS=`ls -d configs/*`
for subdir in ${SUBDIRS}; do
    log "Starting HGQL server for the ${subdir} Test"
    # log "Starting HGQL 2.0.0 endpoint in the background"
    log "Starting HGQL 3.0.1 endpoint in the background"
    CONFIG_FILE="`ls ${subdir}/*.json`"
    LOG_FILE=logs/$(basename ${subdir})/hgql_${HGGL_VERSION}.log
    if [ ! -s $(dirname ${LOG_FILE}) ]; then
        mkdir -p $(dirname ${LOG_FILE})
    fi
    #java -jar ./hypergraphql-2.0.0-exe.jar --config "configs/dbpedia/config_hgql_2.0.0.json" >> logs/dbpedia/hgql_2.0.0.log &
    java -jar ./hypergraphql-${HGGL_VERSION}-exe.jar --config ${CONFIG_FILE} >> ${LOG_FILE} &
    PORT=`cat ${CONFIG_FILE} | jq '.server.port' `
    log "Interface running at http://localhost:${PORT}/graphql"
    wait
done





