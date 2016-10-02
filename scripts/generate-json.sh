#!/bin/bash
#
# generate-json.sh
#
# Description: generate JSON file for adding a vagrant box.
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
DESCRIPTION=$3

if [ $# -ne 3 ]; then
    echo "Usage: $0 <name> <version> <description>"
    exit 1
fi

cd $SCRIPT_DIR/../boxes

SHA256SUM=$(/usr/bin/sha256sum $NAME-v$VERSION.box | cut -d' ' -f1)

echo NAME=$NAME
echo VERSION=$VERSION
echo DESCRIPTION=$DESCRIPTION
echo SHA256SUM=$SHA256SUM

cat << EOF > $NAME-v$VERSION.json
{
    "name": "$NAME",
    "description": "$DESCRIPTION",
    "versions": [{
        "version": "$VERSION",
        "providers": [{
                "name": "virtualbox",
                "url": "file://$NAME-v$VERSION.box",
                "checksum_type": "sha256",
                "checksum": "$SHA256SUM"
        }]
    }]
}
EOF
echo File boxes/$NAME-v$VERSION.json created.
