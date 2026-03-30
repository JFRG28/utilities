#!/bin/bash

echo "How to use it: $0 <full_path_of_pom_file>"
echo "Example: $0 /d/dev-branches/microservices_spboot/accounts/"

# Validate the necessary arguments
if [ $# -lt 1 ]; then
    echo "Invalid input"
    exit 1
fi

path=$1

echo "Generation started for $path"
cd $path
rm -rf target/*
mvn clean install && mvn spring-boot:build-image
echo "Generation finished for $path"