#!/usr/bin/env bash

set -eu

gcloud compute instances create apache-test \
--boot-disk-size=10GB \
--image-family ubuntu-1604-lts \
--image-project=ubuntu-os-cloud \
--machine-type=g1-small \
--tags http-server \
--preemptible \
--restart-on-failure \
--zone=europe-west3-a \
--metadata-from-file startup-script=install-apache2.sh
