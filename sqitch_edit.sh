#! /usr/bin/env bash

FILES_TO_OPEN=''

for param in "$@"; do
	FILES_TO_OPEN.="revert/$1.sql deploy/$1.sql verify/$1.sql "
done

subl -n $FILES_TO_OPEN