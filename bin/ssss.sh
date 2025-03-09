#! /bin/bash

if [ "$1" == "-h" ]; then
	echo "ssss [-x] t n filename"
	exit
fi

if [ "$1" == "-x" ]; then
	xxd -p $4 | tr -d "\n" | ssss-split -w $4 -Q -t $2 -n $3 -x | split -l 1 - secret-$4
else
	cat $3 |  ssss-split -w $3 -Q -t $1 -n $2 | split -l 1 - secret-$3
fi
