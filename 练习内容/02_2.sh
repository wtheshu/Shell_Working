#!/bin/bash
Path="/root"
cd $Path && \
    ls | awk -F '_' '{print "mv "$0" "$1"_wang.HTML"}' | bash

