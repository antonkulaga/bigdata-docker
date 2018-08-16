#!/usr/bin/env bash

mkdir /mnt/ramdisk
mount -t ramfs -o size=10G ramfs /mnt/ramdisk
chmod a+w /mnt/ramdisk
