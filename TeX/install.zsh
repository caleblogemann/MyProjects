#!/usr/bin/env zsh

# delete old link if exists
if [ -h "$HOME/.texmf" ]; then
    rm "$HOME/.texmf"
fi

# link texmf to TEXMFHOME 
TEX_ROOT=$(pwd);
ln -s "$TEX_ROOT/texmf" "$HOME/.texmf"
