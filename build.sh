#!/bin/sh
docker run \
  --rm \
  --privileged \
  -v ${PWD}:/build:ro \
  -v ${PWD}/packer_cache:/build/packer_cache \
  -v ${PWD}/output-arm-image:/build/output-arm-image \
  --mount type=bind,source="$HOME/.ssh/id_rsa.pub",target=/host-machine-files/id_rsa.pub,readonly \
  --mount type=bind,source="$(pwd)/dnsmasq.conf",target=/host-machine-files/dnsmasq.conf,readonly \
  packer-builder-arm build raspbian-dnsmasq.json
