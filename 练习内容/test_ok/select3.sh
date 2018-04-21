#!/bin/bash

PS3="Please select a number:"

echo "Please chose a number, 1:run w, 2:run top, 3:run free, 4:quit"
echo 

select command in w top free quit
do
	case $command in
		w)
			w;exit
			;;
		top)
			top;exit
			;;
		free)
			free;exit
			;;
		quit)
			exit
			;;
		*)
			echo "Please input a number:(1-4).";exit
			;;
esac
done

