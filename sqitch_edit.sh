#! /usr/bin/env bash
##
# Should get directories and extensions from sqitch config.
##

IS_SQITCH_PROJECT=`sqitch config --local -l | wc | tr -d " "`
echo $IS_SQITCH_PROJECT

FILES_TO_OPEN=''

if [ $IS_SQITCH_PROJECT != 000 ]; then
	
	CURRENT_DIRECTORY=`pwd`
	echo $CURRENT_DIRECTORY
	
	for param in "$@"; do
		REVERT_FILE="$CURRENT_DIRECTORY/revert/$param.sql"
		echo $REVERT_FILE
		DEPLOY_FILE="$CURRENT_DIRECTORY/deploy/$param.sql"
		echo $DEPLOY_FILE
		VERIFY_FILE="$CURRENT_DIRECTORY/verify/$param.sql"
		echo $VERIFY_FILE
				
		if [ -f $REVERT_FILE ]; then
			echo $REVERT_FILE
			FILES_TO_OPEN="$FILES_TO_OPEN $REVERT_FILE"
		else
			echo "Deploy file for sqitch change $param does not exist."
			exit
		fi

		if [ -f $DEPLOY_FILE ]; then
			echo $DEPLOY_FILE
			FILES_TO_OPEN="$FILES_TO_OPEN $DEPLOY_FILE"
		else
			echo "Deploy file for sqitch change $param does not exist."
			exit
		fi

		if [ -f $VERIFY_FILE ]; then
			echo $VERIFY_FILE
			FILES_TO_OPEN="$FILES_TO_OPEN $VERIFY_FILE"
		else
			echo "Deploy file for sqitch change $param does not exist."
			exit
		fi

	done
else
		echo "This isn't a sqitch project directory . . . "
fi

echo $FILES_TO_OPEN
subl -n $FILES_TO_OPEN