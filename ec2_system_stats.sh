#!/bin/bash

###Help

if [[ $1 == "-h" || $1 == "--help" || $1 == "help" ]]; then
	echo "-v --verbose"
	echo "    Prints more info!"
	exit 0
fi

###

### Deps

echo ">Checking dependencies..."
sudo apt-show-versions --version &> /dev/null 
if [[ $? != "0" ]]; then
	sudo apt install apt-show-versions -y &> /dev/null
	echo ">Installing apt-show-versions..."
	if [[ $? == "0" ]]; then
		echo ">apt-show-versions successfully insatlled!"
	else
		echo ">Something went wrong, exiting..."
		exit 1
	fi
fi

sudo apt-show-versions | grep -i sysstat &> /dev/null
if [[ $? != "0" ]]; then
	sudo apt install sysstat -y &> /dev/null
	if [[ $? == "0" ]]; then
		echo ">iostat installed!"
	else
		echo ">Something went wrong, exiting..."
		exit 1
	fi
fi

sudo apt-show-versions | grep -i awk &> /dev/null
if [[ $? != "0" ]]; then
	sudo apt install awk -y &> /dev/null
	if [[ $? == "0" ]]; then
		echo ">awk installed!"
	else
		echo "Something went wrong, exiting..."
		exit 1
	fi
fi

echo ">All dependencies satisifed!"

###Colors

YELLOW="\e[1;33m"
CYAN="\e[1;36m"
RED="\e[31m"
ENDCOLOR="\e[0m"
L_GREEN="\e[92m"
GREEN="\e[32m"

###

###Main
CURRENT_DATE=$(date "+%D %T")
UPTIME=$(uptime --pretty | cut -b 4-30)
RAM_TOTAL=$(free -h | awk '/Mem/ {print $2}')
RAM_USED=$(free -h | awk '/Mem/ {print $3}')
DISK_TOTAL=$(df -h | awk '/nvme0n1p1/ {print $2}' | head -1)
DISK_USED=$(df -h | awk '/nvme0n1p1/ {print $3}' | head -1)
CPU_CORES=$(iostat | awk '/Linux/ {print $6}' | cut -b 2-5)
CPU_IDLE=$(iostat | head -4 | tail -1 | awk '{print $6}' | cut -d. -f 1)
((CPU_USAGE=100 - $CPU_IDLE))
FIREWALL_STATUS=$(sudo ufw status | awk '/Status/ {print $2}')
SSHD_STATUS=$(systemctl status sshd | awk '/Active/ {print $2}')
FAIL2BAN_STATUS=$(systemctl status fail2ban | awk '/Active/ {print $2}')
WEBSERVER_STATUS=$(systemctl status apache2 | awk '/Active/ {print $2}')
###

###VERBOSE
if [[ $1 == "-v" || $1 == "--verbose" ]]; then
	VERBOSE_EXTRA_LINES=$(echo -e "${YELLOW}--------------------------------${ENDCOLOR}")
	VERBOSE_MOVE_DATE_CLOCK=$(echo "                ")
	VERBOSE_CPU_USR=$(iostat | head -4 | tail -1 | awk '{print $1}')
	VERBOSE_CPU_SYS=$(iostat | head -4 | tail -1 | awk '{print $3}')
	VERBOSE_CPU_PARSED=$(echo "(usr: ${VERBOSE_CPU_USR}% | sys: ${VERBOSE_CPU_SYS}%)")
	VERBOSE_RAM_SWAP_TOTAL=$(free -h | awk '/Swap/ {print $2}')
	VERBOSE_RAM_SWAP_USED=$(free -h | awk '/Swap/ {print $3}')
	VERBOSE_RAM_SWAP_FINAL=$(echo "(swap: ${VERBOSE_RAM_SWAP_USED}/${VERBOSE_RAM_SWAP_TOTAL})" )
	VERBOSE_DISK_READ=$(iostat -h | awk '/nvme/ {print $5}')
	VERBOSE_DISK_WRITTEN=$(iostat -h | awk '/nvme/ {print $6}')
	VERBOSE_DISK_PARSED=$(echo "(read: ${VERBOSE_DISK_READ} | written: ${VERBOSE_DISK_WRITTEN})")
	VERBOSE_UFW=$(sudo ufw status | awk '! /v6/ {print $0}' | awk '/ALLOW/ {print $1}' | cut -d/ -f1)
	VERBOSE_UFW=$(echo ${VERBOSE_UFW})
	VERBOSE_UFW=$(echo "(${VERBOSE_UFW})")
	VERBOSE_UFW_V=$(sudo apt-show-versions | awk '/ufw/ {print $3}')
	VERBOSE_UFW_V=$(echo "[${VERBOSE_UFW_V}] ")
	VERBOSE_SSHD_PORT=$(cat /etc/ssh/sshd_config | awk '/Port/ {print $2}' | head -1)
	VERBOSE_SSHD_ROOT=$(cat /etc/ssh/sshd_config | awk '/PermitRootLogin/ {print $2}' | head -1)
	VERBOSE_SSHD_PASSWD=$(cat /etc/ssh/sshd_config | awk '/PasswordAuth/ {print $2}' | head -1)
	VERBOSE_SSHD_PARSED=$(echo "(port ${VERBOSE_SSHD_PORT} | rootlogin ${VERBOSE_SSHD_ROOT} | passwdauth ${VERBOSE_SSHD_PASSWD})")
	VERBOSE_SSHD_V=$(sudo apt-show-versions | awk '/openssh-server/ {print $3}')
	VERBOSE_SSHD_V=$(echo "[${VERBOSE_SSHD_V}] ")
	VERBOSE_FAIL2BAN=$(sudo fail2ban-client status sshd | awk '/Currently banned/ {print $4}')
	VERBOSE_FAIL2BAN_2=$(sudo fail2ban-client status sshd | awk '/Total banned/ {print $4}')
	VERBOSE_FAIL2BAN_PARSED=$(echo "(currently banned: ${VERBOSE_FAIL2BAN} | total banned: ${VERBOSE_FAIL2BAN_2})")
	VERBOSE_FAIL2BAN_V=$(sudo apt-show-versions | awk '/fail2ban/ {print $3}')
	VERBOSE_FAIL2BAN_V=$(echo "[${VERBOSE_FAIL2BAN_V}] ")
	VERBOSE_WEBSERVER_LOG=$(cat /etc/apache2/apache2.conf | awk '/LogLevel/ {print $2}' | tail -1)
	VERBOSE_WEBSERVER_PARSED=$(echo "(loglevel ${VERBOSE_WEBSERVER_LOG})")
	VERBOSE_WEBSERVER_V=$(sudo apt-show-versions | awk '/apache2/ {print $3}' | head -1)
	VERBOSE_WEBSERVER_V=$(echo "[${VERBOSE_WEBSERVER_V}] ")
fi
###	

echo -e "${YELLOW}-------------------------------------${ENDCOLOR}${VERBOSE_EXTRA_LINES}"
echo -e "          ${VERBOSE_MOVE_DATE_CLOCK}${L_GREEN}$CURRENT_DATE${ENDCOLOR}"
echo -e "${YELLOW}-------------------------------------${ENDCOLOR}${VERBOSE_EXTRA_LINES}"
echo -e "${CYAN}UPTIME:${ENDCOLOR} $UPTIME"
echo -e "${CYAN}CPU(${CPU_CORES}c):${ENDCOLOR} ${CPU_USAGE}% ${GREEN}${VERBOSE_CPU_PARSED}${ENDCOLOR}"
echo -e "${CYAN}RAM:${ENDCOLOR} ${RAM_USED}/${RAM_TOTAL} ${GREEN}${VERBOSE_RAM_SWAP_FINAL}${ENDCOLOR}"
echo -e "${CYAN}DISK:${ENDCOLOR} ${DISK_USED}/${DISK_TOTAL} ${GREEN}${VERBOSE_DISK_PARSED}${ENDCOLOR}"
echo -e "${YELLOW}-------------------------------------${ENDCOLOR}${VERBOSE_EXTRA_LINES}"
echo -e "${CYAN}ufw:${ENDCOLOR} $FIREWALL_STATUS ${L_GREEN}${VERBOSE_UFW_V}${ENDCOLOR}${GREEN}${VERBOSE_UFW}${ENDCOLOR}"
echo -e "${CYAN}SSHd:${ENDCOLOR} $SSHD_STATUS ${L_GREEN}${VERBOSE_SSHD_V}${ENDCOLOR}${GREEN}${VERBOSE_SSHD_PARSED}${ENDCOLOR}"
echo -e "${CYAN}fail2ban:${ENDCOLOR} $FAIL2BAN_STATUS ${L_GREEN}${VERBOSE_FAIL2BAN_V}${ENDCOLOR}${GREEN}${VERBOSE_FAIL2BAN_PARSED}${ENDCOLOR}"
echo -e "${CYAN}apache:${ENDCOLOR} $WEBSERVER_STATUS ${L_GREEN}${VERBOSE_WEBSERVER_V}${ENDCOLOR}${GREEN}${VERBOSE_WEBSERVER_PARSED}${ENDCOLOR}"
echo -e "${YELLOW}-------------------------------------${ENDCOLOR}${VERBOSE_EXTRA_LINES}"
