#!/bin/bash
USER_FILE="users.txt"
TEMPLATE_USER_DIR=/home/rmed000
DEBUG=false

if [[ ! -d $TEMPLATE_USER_DIR ]]; then
	printf 'Error: Template dir %s does not exist.\n' $TEMPLATE_USER_DIR
	exit 1
fi

while IFS=$'\t' read -r USERNAME PASSWORD || [[ -n $USERNAME ]]
do
	# Deal with new line at the end of the file
	if [[ -z "$USERNAME" ]]; then
		continue
	fi

	# Skip existing users
	USER_EXISTS=$(id -u $USERNAME > /dev/null 2>&1; echo $?)
    	if [[ "$USER_EXISTS" -eq "0" ]]; then
		printf '# User %s exists, skipping\n' $USERNAME
		continue
	fi

	printf '# Create user %s with password %s\n' $USERNAME $PASSWORD

	# Start useradd command
	CMD="useradd --shell /bin/bash -g users -p \$(openssl passwd -1 $PASSWORD)"

	# Add home dir
	HOME_DIR="/home/$USERNAME"
	if [ ! -d "$HOME_DIR" ]; then
		CMD=`printf '%s --create-home -k /home/train000' "$CMD"`
	fi

	# Sudo users rmed001 through rmed009 (to be used by instructors)
	if [[ $USERNAME =~ ^rmed00[1-9] ]]; then
    		CMD=`printf '%s %s' "$CMD" "-G sudo"`
    	fi

	CMD=`printf '%s %s' "$CMD" "$USERNAME"`
	
	if $DEBUG; then
		printf 'RUN: %s\n' "$CMD"
	fi

	eval $CMD

done < $USER_FILE
