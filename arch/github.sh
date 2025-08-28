#!/bin/bash

mkdir -p ~/.ssh
cd ~/.ssh || exit

ssh-keygen -t ed25519 -C "engsw.thiago@gmail.com" -N "" -f id_ed25519

cd -