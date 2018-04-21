#!/bin/bash
CMD="ping -W 2 -c 2"
Ip="10.0.0."
for n in $(seq 254)
do
    {
        $CMD $Ip$n &> /dev/null
        if [ $? -eq 0  ]; then
            echo "$Ip$n is ok"
        fi
    }&
done
