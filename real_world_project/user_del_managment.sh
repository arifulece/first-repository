#!/bin/bash
user_file="/usr/local/bin/user_list.txt"
log_file="/var/log/user_del_managment.log"

echo "User Delete Managment Log - $(date)" >> $log_file
echo "===========================" >> $log_file

if [ ! -f $user_file ];then
	echo "user list file not found: $user_file"
	exit 1
fi

while read $user;do
	if id "$user" &> /dev/null; then
		echo "[skip] user '$user' already remove." >> $log_file
	else
		userdel -f "$user"
		echo "[ok] user '$user' successfully delete" >> $log_file
	fi
done < $user_file

echo "Thanks for successfully delete all user $log_file"
