#!/bin/bash
php_versions=("8.0" "8.1" "8.2" "8.3" "8.4")

for php_version in ${php_versions[@]}; do
  image_tag=adbrosaci/php:$php_version
  docker build --build-arg PHP_VERSION=$php_version -t $image_tag .
  docker push $image_tag
done
