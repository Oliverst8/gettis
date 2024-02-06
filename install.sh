#!/bin/bash

if [ -d ~/bin ]; then
    echo "/bin exists."
else
    echo "Creating /bin directory..."
    mkdir ~/bin
fi

if [ -f ~/bin/gettis ]; then
    echo -n "gettis is already installed. Do you want to update? [Y/n] " 
    read answer
    if [ "$answer" != "${answer#[Yy]}" ] ;then
        echo "Updating gettis..."
    else
        echo "Not updating gettis."
        exit
    fi
else
    echo "Installing gettis..."
fi
./build.sh
cp -f ./build/gettis ~/bin/gettis


if ! grep -q "export PATH=\$PATH:~/bin" ~/.bashrc; then
    echo "# export ~/bin to PATH - required for gettis to run" >> ~/.bashrc
    echo "export PATH=\$PATH:~/bin" >> ~/.bashrc
fi

echo "Succesfully installed gettis"
