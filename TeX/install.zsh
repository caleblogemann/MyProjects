#!/usr/bin/env zsh

# delete old link if exists
if [ -h "$HOME/Library/texmf" ]; then
    rm "$HOME/Library/texmf"
fi

# link texmf to TEXMFHOME 
TEX_ROOT=$(pwd);
ln -s "$TEX_ROOT/texmf" "$HOME/Library/texmf"
