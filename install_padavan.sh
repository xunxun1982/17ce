#!/bin/sh
echo "begin install k2 17ce"
if [ $# == 1 ]; then
	echo "17CE user name -->$1"
	echo "if the user name is error ,ctrl +c exit"
	sleep 3
else 
	echo "please use the cmd-->"
	echo "     ./install.sh   xxx@xxx.com"
	exit 1
fi
echo 
echo 
echo "By Dandan!"
echo "mjyhj update!And use myself!"
rm -rf /etc/storage/17ce
rm -rf /tmp/17ce
rm  -rf 17ce*
cd /tmp
wget -O 17ce_padavan.sh http://git.oschina.net/mjyhj/K2_17ce/raw/master/17ce_padavan.sh
chmod +x  /tmp/17ce_padavan.sh
mkdir /etc/storage/17ce
cp install_padavan.sh /etc/storage/17ce/install_padavan.sh
chmod +x  /etc/storage/17ce/install_padavan.sh
if grep -wq "install_padavan.sh" /etc/storage/post_wan_script.sh; then
  /tmp/17ce_padavan.sh yiqice@qq.com
else
  echo "/etc/storage/17ce/install_padavan.sh  yiqice@qq.com">>/etc/storage/post_wan_script.sh
  /tmp/17ce_padavan.sh yiqice@qq.com
fi