#!#!/usr/bin/env zsh
# link texmf to TEXMFHOME 
TEX_ROOT=$(pwd);
ln -s "$TEX_ROOT/texmf" "$HOME/.texmf"
