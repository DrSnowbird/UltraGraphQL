#!/bin/bash -x

###################################################
#### **** Container HOST information ****
###################################################
SED_MAC_FIX="''"
CP_OPTION="--backup=numbered"
HOST_IP=127.0.0.1
HOST_NAME=localhost
function get_HOST_IP() {
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        # Linux ...
        HOST_NAME=`hostname -f`
        HOST_IP=`ip route get 1|grep via | awk '{print $7}'`
        SED_MAC_FIX=
        echo -e ">>>> HOST_IP: ${HOST_IP}"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
        HOST_NAME=`hostname -f`
        HOST_IP=`ifconfig | grep "inet " | grep -Fv 127.0.0.1 | grep -Fv 192.168 | awk '{print $2}'`
        CP_OPTION=
    else
        HOST_NAME=`hostname -f`
        echo "**** Unknown/unsupported HOST OS type: $OSTYPE"
        echo ">>>> Use defaults: HOST_IP=$HOST_IP ; HOST_NAME=$HOST_NAME"
    fi
    echo ">>> HOST_IP=${HOST_IP}"
    echo ">>> HOST_NAME=${HOST_NAME}"
}
get_HOST_IP
HOST_IP=${HOST_IP:-127.0.0.1}
HOST_NAME=${HOST_NAME:-localhost}

echo -e ">>> HOST_IP: ${HOST_IP}"
echo -e ">>> HOST_NAME: ${HOST_NAME}"

sed -i "s/0\.0\.0\.0/${HOST_IP}/g" config.json

java -jar ../../build/libs/ultragraphql-1.1.4-exe.jar --config config.json
