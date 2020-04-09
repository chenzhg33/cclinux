#! /bin/bash

basedir=$(cd $(dirname $0); pwd)
userfile=$HOME/.bashrc
envdir=$HOME/.env
content='# User specific aliases and functions
for f in $HOME/.env/*
do
    [[ -f $f ]] && . $f
done
'
key=$(echo "$content" | head -n 1)

cd $basedir
mkdir -p $envdir

for file in $basedir/env/*;
do
    cp $file $envdir
done
chmod -R a+x $envdir

if [[ -f $HOME/.profile ]]; then
    echo "userfile: $HOME/.profile exist"
    if ! grep -q "$key" $HOME/.profile; then
        echo "append content to $HOME/.profile"
        echo "$content" >> $HOME/.profile
    else
        echo "userfile: $HOME/.profile content exist"
    fi
fi

if echo $SHELL | grep -q zsh; then
    userfile=$HOME/.zshrc
fi

echo "userfile: $userfile"

if [[ -f $userfile ]]; then
    echo "userfile: $userfile exist"
    if ! grep -q "$key" $userfile; then
        echo "append content to $userfile"
        echo "$content" >> $userfile
    else
        echo "userfile: $userfile content exist"
    fi
fi

