#!/usr/bin/env bash

set -eu

gcloud compute instances create apache-test \
--boot-disk-size=10GB \
--image-family apache2-test \
--machine-type=f1-micro \
--preemptible \
--tags http-server \
--restart-on-failure
