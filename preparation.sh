!#/bin/bash
set -e

sudo apt update
sudo apt upgrade -y
sudo apt install -y \
  ansible \
  openssh-client \
  git \
  curl \
  nano \
  python3 \
  python3-pip
  
ansible --version
ssh -V
python3 --version
git --version
