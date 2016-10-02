#!/bin/bash
#
# generate-vagrantfile.sh
#
# Description: generate a Vagrantfile for a vagrant box.
#
# Author: Danilo Dellaquila <ddellaquila@gmail.com>
#
# Copyright (c) 2016 Danilo Dellaquila. All Rights Reserved.
# Distributed under the MIT software license, see LICENSE file
# or http://www.opensource.org/licenses/mit-license.php.

# Variables
SCRIPT_DIR=`dirname $0`
NAME=$1
VERSION=$2

if [ $# -ne 2 ]; then
    echo "Usage: $0 <name> <version>"
    exit 1
fi

cd $SCRIPT_DIR/../boxes

echo NAME=$NAME
echo VERSION=$VERSION

cat << EOF > $NAME-v$VERSION.Vagrantfile
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "${NAME}"
  config.vm.box_version = "${VERSION}"
  config.vm.box_check_update = false

  # SSH configuration
  config.ssh.username = "vagrant"
  config.ssh.private_key_path = File.join(File.expand_path(File.dirname(__FILE__)), "vagrant.id_rsa")

end
EOF
echo File boxes/$NAME-v$VERSION.Vagrantfile created.
