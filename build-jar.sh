#!/bin/bash 

set -e

gradle clean build shadowJar

ls -al $(find ./build -name "*.jar")
