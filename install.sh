#!/usr/bin/env bash
# -*- coding: utf-8 -*-
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

# 错误退出
Error() {
  test -n "$1" && echo "Error: $1" 1>&2
  \rm -rf "${@:2}"
  exit 1
}
# 必须root权限运行
if [ "$(id -u)" -ne 0 ]; then
  Error "Error: You must be root to run this script!"
fi
# 检查防火墙
Check_Firewall() {
  if ! systemctl list-units --type=service | grep firewalld.service | grep -v grep; then
    # 设置开机防火墙
    if ! systemctl enable firewalld.service; then
      Error "开机启动防火墙失败"
    fi
    # 设置启动防火墙
    if ! systemctl start firewalld; then
      Error "启动防火墙失败"
    fi
  fi
}
# 添加端口号
Firewall_Enable() {
  Check_Firewall
  for port in "$@"; do
    if ! firewall-cmd --zone=public --list-ports | grep -q "$port"; then
      firewall-cmd --zone=public --add-port="$port" --permanent
    fi
  done
  firewall-cmd --reload
}

# 默认下载镜像源
Mirror="https://github.com/kuangxianwei/botadmin/archive/master.zip"

# app 名称
AppName="botadmin"

# app 安装目录
AppDir="/data/$AppName"

# app 程序完整路径
App="$AppDir/$AppName"

# 参数 mirror=cn 则下载国内的镜像
# 直接指定 mirror=https://github.com/kuangxianwei/botadmin/archive/master.zip
# 默认是Github下载
for param in "$@"; do
  if [[ "$param" =~ ^mirror= ]]; then
    case "${param#*=}" in
    [cC][nN])
      Mirror="http://auth.nfivf.com:9090/mirror/master.zip"
      ;;
    http://* | https://*)
      Mirror="${param#*=}"
      ;;
    esac
  fi
done

# 进入到安装目录
test -d /data || mkdir /data
if ! cd /data; then
  Error "进入/data 失败"
fi

# 添加chromium 安装缺失的依赖库
Install_Chromium() {
  echo "添加chromium 安装缺失的依赖库"
  if ! yum install -y pango.x86_64 libXcomposite.x86_64 libXcursor.x86_64 libXdamage.x86_64 libXext.x86_64 libXi.x86_64 libXtst.x86_64 cups-libs.x86_64 libXScrnSaver.x86_64 libXrandr.x86_64 GConf2.x86_64 alsa-lib.x86_64 atk.x86_64 gtk3.x86_64 \
    ipa-gothic-fonts xorg-x11-fonts-100dpi xorg-x11-fonts-75dpi xorg-x11-utils xorg-x11-fonts-cyrillic xorg-x11-fonts-Type1 xorg-x11-fonts-misc; then
    Error "安装Chromium依赖库失败"
  fi
}

# 下载程序
Download_Botadmin() {
  if test ! -d botadmin; then
    if test ! -f botadmin-master.zip; then
      \rm -rf botadmin-master.zip
      if ! wget -cO botadmin-master.zip "$Mirror"; then
        Error "下载失败" botadmin-master.zip
      fi
    fi
    if ! command -v unzip; then
      yum -y install unzip || exit 1
    fi
    if ! unzip -o botadmin-master.zip; then
      Error "botadmin-master.zip下载失败" botadmin-master.zip
    fi
    \mv botadmin-master botadmin || exit 1
    \rm -rf botadmin-master.zip
  fi
}

# 写入开机启动
Write_botadmin_init() {
  # 写入init.d 开机启动本程序
  cat >"/etc/init.d/$AppName" <<EOF
#!/bin/bash
#
# $AppName - this script starts and stops the $AppName daemon
#
# chkconfig:   - 85 15
# description: BotAdmin system
# processname: $AppName
# Url http://www.botadmin.cn
# Last Updated 2020.06.01

# Source function library.
. /etc/rc.d/init.d/functions

# Source networking configuration.
. /etc/sysconfig/network

# Check that networking is up.
[ "\$NETWORKING" = "no" ] && exit 0

# 锁文件
lockfile=/var/lock/subsys/$AppName
cd $AppDir || exit 0

start() {
  echo -n "Starting $AppName: "
  $App &
  echo_success
  retval=\$?
  echo
  [ \$retval -eq 0 ] && touch \$lockfile
  return \$retval
}
stop() {
  echo -n "Stopping $AppName: "
  killproc $AppName >/dev/null 2>&1
  echo_success
  retval=\$?
  echo
  [ \$retval -eq 0 ] && rm -f \$lockfile
  return \$retval
}

restart() {
  stop
  start
}

uninstall() {
  stop
  rm -fr $AppDir
  rm -f /etc/rc.d/init.d/$AppName
}

rh_status() {
  status $AppName
}

rh_status_q() {
  rh_status >/dev/null 2>&1
}

case "\$1" in
start)
  rh_status_q && exit 0
  \$1
  ;;
stop)
  rh_status_q || exit 0
  \$1
  ;;
restart)
  \$1
  ;;
status)
  rh_status
  ;;
uninstall)
  \$1
  ;;
*)
  echo "Usage: \$0 {start|stop|status|restart}"
  exit 2
  ;;
esac
EOF
  chown root:root -R $AppDir
  chmod +x $App
  chmod +x /etc/init.d/$AppName
  test -d $AppDir/data || mkdir -p $AppDir/data
  # systemctl服务
  cat >/etc/systemd/system/$AppName.service <<EOF
[Unit]
Description=$AppName Server
After=network.target syslog.target

[Service]
Type=forking
ExecStart=/etc/init.d/$AppName start
ExecStop=/etc/init.d/$AppName stop
ExecReload=/etc/init.d/$AppName restart
Restart=no
PrivateTmp=false

[Install]
WantedBy=multi-user.target
EOF
  systemctl daemon-reload
}

# 添加chromium 安装缺失的依赖库
Install_Chromium

# 下载解压程序
Download_Botadmin

#写入脚本#
Write_botadmin_init

#赋权限#
cd "$AppDir" || exit 1
test -d ./data/contact || mkdir -p ./data/contact
chmod -R 0755 ./data
echo "open_basedir=$AppDir/data/contact:/tmp/:/proc/" >./data/contact/.user.ini
chattr +i ./data/contact/.user.ini
command -v bzip2 || {
  yum -y install bzip2 || exit 1
}
Check_Firewall
Firewall_Enable 8080/tcp
systemctl enable $AppName.service
systemctl start $AppName
echo "$AppName 安装成功"
echo "http://ip:8080"
