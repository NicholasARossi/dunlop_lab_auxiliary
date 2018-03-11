#!/bin/bash

# rassembler.sh

# Copies all clist.mat files from subdirectories and places them into a folder called collected
# Name the higher levels folder in order to make sure it organizes them in a way you find appealing
# (ex 0,1,2 not wt, acrab, etc)

mkdir -p collected

DIRNAMES=$( find . -maxdepth 2 -type d | sort )
a=0
for dirname in $( echo $DIRNAMES )
do
    if [ -a ${dirname#*/}/clist.mat ]; then
    new=$(printf "%04d.mat" "$a")
    cp -f ${dirname#*/}/clist.mat collected/"$new"

    echo "Copied file ${dirname#*/}/clist.mat to collected/$new"
    let a=a+1
    fi
done