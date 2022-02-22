#!/bin/bash

red(){ echo -e "\033[31m\033[01m$1\033[0m";}
green(){ echo -e "\033[32m\033[01m$1\033[0m";}
yellow(){ echo -e "\033[33m\033[01m$1\033[0m";}
white(){ echo -e "\033[37m\033[01m$1\033[0m";}
readp(){ read -p "$(yellow "$1")" $2;}
red "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
white "           
 ░██   ░██     ░██   ░██     ░██   ░██    ░██     ░██      ░██ ██ ██ 
 ░██  ░██      ░██  ░██      ░██  ░██      ░██   ░██      ░██    ░░██             
 ░██ ██        ░██ ██        ░██ ██         ░██ ░██      ░██         
 ░██ ██        ░██ ██        ░██ ██           ░██        ░██    ░██ ██ 
 ░██ ░██       ░██ ░██       ░██ ░██          ░██         ░██    ░░██
 ░██  ░░██     ░██  ░░██     ░██  ░░██        ░██          ░██ ██ ██ "
red "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" 
yellow " 详细说明 https://github.com/kkkyg/vpsroot  YouTube频道：甬哥侃侃侃"       
[[ $EUID -ne 0 ]] && su='sudo' 
lsattr /etc/passwd /etc/shadow >/dev/null 2>&1
chattr -i /etc/passwd /etc/shadow >/dev/null 2>&1
chattr -a /etc/passwd /etc/shadow >/dev/null 2>&1
lsattr /etc/passwd /etc/shadow >/dev/null 2>&1
prl=`grep PermitRootLogin /etc/ssh/sshd_config`
pa=`grep PasswordAuthentication /etc/ssh/sshd_config`
if [[ -n $prl && -n $pa ]]; then
readp "自定义root密码:" mima
echo root:$mima | $su chpasswd root
$su sed -i 's/^#\?PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config;
$su sed -i 's/^#\?PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config;
$su service sshd restart
green "VPS当前用户名：root"
green "vps当前root密码：$mima"
else
red "当前vps不支持root账户或无法自定义root密码" && exit 1
fi
