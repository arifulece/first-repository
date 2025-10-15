#!/bin/bash
user_file="/usr/local/bin/user_list.txt"
log_file="/var/log/user_managment.log"
default_pass="P@ssword123"

echo "====================================" >> $log_file
echo "User managemnt log - $(date)" >> $log_file
echo "====================================" >> $log_file

if [ ! -f $user_file ]; then
	echo "user list file not found" >> $log_file
	exit 1
fi

while read $user; do
	if id "$user" &> /dev/null; then
		echo " [SKIP] user '$user' already exits." >> $log_file
	else
		useradd -m "$user"
		echo "$user:$default_pass" | chpasswd
		chage -d 0 "$user"
		echo "[OK] user '$user' created successfully with default password." >> $log_file
	fi
done < $user_file

echo "user creation complete. check the log at $log_file"

