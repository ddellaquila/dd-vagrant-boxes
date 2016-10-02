DD Vagrant Boxes
================


This repository contains few helper scripts that will help you to build
and store your Vagrant boxes.


How To Build Vagrant Boxes
--------------------------

### Create and setup a new virtual machine

First, you need to create a new VM in Virtualbox, for this example we
call it `fedora24`.

Then, add a port forwarding rule to the network adapter. Right click on the
virtual machine name, then select *Settings -> Network -> Adapter 1 ->
Advanced -> Port Forwarding -> Plus icon* and use the following
settings:

* Name: ssh
* Protocol: TCP
* Host IP: 127.0.0.1
* Host Port: 2222
* Guest IP: leave this field blank
* Guest Port: 22

You can now start the operating system installation, also you need to
make a user called `vagrant` as administrator.

When OS installation is completed, add `vagrant` user to sudoers to
enable password-less sudo and disable `requiretty`.  For that, you need
to login to the virtual machine, then add the following lines to
`/etc/sudoers` file.

```
vagrant ALL=(ALL) NOPASSWD: ALL
Defaults:vagrant !requiretty
```

Now, install Virtualbox Guest Additions and its dependencies, e.g. the
`kernel-devel` package in Fedora.

You also need to enable and start `sshd` service.

```
$ sudo systemctl enable sshd
$ sudo systemctl start sshd
```

Logout from the virtual machine and generate a new ssh key for
`vagrant` user on your local computer:

```
$ cd $HOME/.ssh
$ ssh-keygen -t rsa -C vagrant@localhost -f vagrant.id_rsa
```

Then, run `scripts/copy-ssh-key.sh` to add the `vagrant` ssh public key
to your VM. You can test the ssh key with:

```
$ ssh -i vagrant.id_rsa -p 2222 vagrant@127.0.0.1
```

Finally, power off the virtual machine as it is ready for creating Vagrant boxes.

### Create new Vagrant box

Generate a new Vagrantfile file:

```
$ scripts/generate-vagrantfile.sh fedora24 1.0
```

Build a new vagrant box:

```
$ scripts/build-box.sh fedora24 1.0
```

Generate a new json file:

```
$ scripts/generate-json.sh fedora24 1.0 "Fedora 24 base image."
```

Now, you can add the new box to your Vagrant:

```
$ scripts/add-vagrant-box.sh fedora24 1.0
```

Ok, it's time to test the new box:

```
$ cd tests
$ vagrant init fedora24
$ vagrant up
```


License
-------

This project is licensed under a MIT license. Please read the
[LICENSE](https://github.com/ddellaquila/dd-vagrant-boxes/blob/master/LICENSE) file.
