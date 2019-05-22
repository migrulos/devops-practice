#!/usr/bin/env bash

set -eu

yum -y update
yum -y install httpd
systemctl enable httpd
cat <<EOF > /var/www/html/index.html
<html><body><h1>Hello World</h1>
<p>This page was created from a simple startup script!</p>
</body></html>
EOF
