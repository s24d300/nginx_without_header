#!/usr/bin/env sh

header_name=Date

if [[ "$(docker exec -ti nginx curl -I localhost | grep $header_name)" ]]; then
    echo "Header $header_name exists"
  else echo "Header $header_name not exists"
fi