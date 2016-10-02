#!/bin/bash
#
# add-vagrant-box.sh
#
# Description: add a box to your vagrant.
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
vagrant box add -c $NAME-v$VERSION.json
