#!/bin/bash
#
# copy-ssh-key.sh
#
# Description: copy 'vagrant' ssh public key to VirtualBox machine.
#
# Author: Danilo Dellaquila <ddellaquila@gmail.com>
#
# Copyright (c) 2016 Danilo Dellaquila. All Rights Reserved.
# Distributed under the MIT software license, see LICENSE file
# or http://www.opensource.org/licenses/mit-license.php.

ssh-copy-id                          \
    -o PubkeyAuthentication=no       \
    -i $HOME/.ssh/vagrant.id_rsa.pub \
    -p 2222                          \
    vagrant@127.0.0.1
