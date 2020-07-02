#!/bin/bash
sudo mkdir /mnt/remote-music
sudo mount -t nfs 192.168.1.218:/export/music /mnt/remote-music/
