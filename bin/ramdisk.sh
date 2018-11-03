#!/usr/bin/env bash

mkdir /data/underStorage
mkdir /mnt/ramdisk
mount -t ramfs -o size=10G ramfs /mnt/ramdisk
chmod a+w /mnt/ramdisk
