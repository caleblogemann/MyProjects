#!/usr/bin/env zsh

# delete old link if exists
if [ -h "$HOME/Documents/MATLAB" ]; then
    rm "$HOME/Documents/MATLAB"
fi

# link texmf to TEXMFHOME 
MATLAB_ROOT=$(pwd);
ln -s "$MATLAB_ROOT/MATLAB" "$HOME/Documents/MATLAB"
