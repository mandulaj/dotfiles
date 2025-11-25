#! /bin/bash


THREASHOLD=${1:-3}
N_PARTS=${2:-5}


if [ "$THREASHOLD" == "-h" ]; then
	echo "ssss t n [-x] filename"
	echo "  -x : indicates that the file is binary and should be handled with xxd"
	exit
fi



if [ "$3" == "-x" ]; then
	FILE_NAME=${4}
	USE_XXD=true
else
	FILE_NAME=${3}
	USE_XXD=false
fi

if [ "$FILE_NAME" == "" ]; then
	echo "Please provide a file name"
	exit 1
fi

if [ "$USE_XXD" == "true" ]; then
	xxd -p $FILE_NAME | tr -d "\n" | ssss-split -w $FILE_NAME -Q -t $THREASHOLD -n $N_PARTS -x | split -d -l 1 - secret-$FILE_NAME-
else
	cat $FILE_NAME |  ssss-split -w $FILE_NAME -Q -t $THREASHOLD -n $N_PARTS | split -d -l 1 - secret-$FILE_NAME-
fi
