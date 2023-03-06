#!/bin/bash

echo "This script will require root access, you may be asked to enter creds."

if [ $EUID != 0 ]; then
    sudo "$0" "$@"
    exit $?
fi

if [[ $1 == "--uninstall" || $1 == "uninstall" ]]; then
	if [[ -f /usr/local/bin/ec2_system_stats.sh ]]; then
		echo "> Installation found, uninstalling..."
		rm -rf /usr/local/bin/ec2_system_stats.sh
		if [[ $? == "0" ]]; then
			echo "> Successfully uninstalled!"
			exit 0
		else
			echo "> Something went wrong, exiting!"
			exit 1
		fi
	else
		echo "> Nothing to uninstall, exiting..."
		exit 1
	fi
fi

echo $PATH | grep -i "/usr/local/bin" &> /dev/null

if [[ $? == "0" ]]; then
	if [[ -f /usr/local/bin/ec2_system_stats.sh ]]; then
		echo "> It appears that ec2_system_stats is already installed."
		echo "> Would you like a clean install? [Y/n]"
		read ANSWER
		if [[ $ANSWER == "Y" || $ANSWER == "y" || $ANSWER == "yes" ]]; then
			cd /tmp
			echo "> Performing clean install..."
			rm /usr/local/bin/ec2_system_stats.sh &> /dev/null
			wget https://raw.githubusercontent.com/v-filip/ec2_system_stats.sh/main/ec2_system_stats.sh &> /dev/null
			chmod +x ec2_system_stats.sh &> /dev/null
			chown ${USER}:${USER} ec2_system_stats.sh &> /dev/null
			mv ec2_system_stats.sh /usr/local/bin/ &> /dev/null
			if [[ $? != "0" ]]; then
				echo "> Something went wrong, exiting..."
				exit 1
			else
				echo "> Successfully installed to /usr/local/bin/"
				exit 0
			fi
			else
				echo "> Exiting..."
				exit 0
		fi
	fi
	cd /tmp
	echo "> Installing ec2_system_stats to /usr/local/bin/..."
	wget https://raw.githubusercontent.com/v-filip/ec2_system_stats.sh/main/ec2_system_stats.sh &> /dev/null
	chmod +x ec2_system_stats.sh &> /dev/null
	chown ${USER}:${USER} ec2_system_stats.sh &> /dev/null
	mv ec2_system_stats.sh /usr/local/bin/ &> /dev/null
	if [[ $? != "0" ]]; then
		echo "> Something went wrong, exiting..."
		exit 1
	else
		echo "> Successfully installed to /usr/local/bin/"
	fi
	else
		echo "> /usr/local/bin/ it not in user path, consider adding it, exiting..."
		exit 1
fi
