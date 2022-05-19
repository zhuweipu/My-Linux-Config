#! /bin/bash

sudo apt update
sudo apt upgrade

sudo apt install neovim

sudo apt install git
git config --global user.name "zhuweipu"
git config --global user.email 919478753@qq.com
git config --global core.editor vim
git config --global credential.helper  'store --file ~/.git-credentials'
git config --list
echo "https://zhuweipu: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@github.com" >> ~/.git-credentials


sudo apt install build-essential
