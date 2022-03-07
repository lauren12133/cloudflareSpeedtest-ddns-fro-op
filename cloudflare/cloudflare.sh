#!/bin/bash

# CHANGE THESE
auth_email="123456789@qq.com"
auth_key="sadsafsdfsdfsdfsdfsdfefacdd5" # found in cloudflare account settings
zone_name="a.com" #主域名
record_name="ddns.a.com" #DDNS解析域名
#以上为需要手动填写的内容。
cd `dirname $BASH_SOURCE`
curl=`command -v curl 2> /dev/null`


#获取测试IP
function get_ip {
    if [ $record_name ] ; then
        name="$record_name.$domain"
    else
        name=$domain
    fi
    echo "Domain name: $name"
    ip=`ping -c 1 $name | head -1 | grep -o ' ([^)]*' | grep -o '[^ (]*$'`
    if [ ! $ip ] ; then
        echo "Can not get the IP of $name"
        exit 1
    fi
    echo "Current IP: $ip"
}


#测试ipv4
function test_ipv4 {
    cd /root/CloudflareST && ./CloudflareST -tl 500 -sl 0.1 -p 0 -f ip.txt
}
#测试ipv6
function test_ipv6 {
    cd /root/CloudflareST && ./CloudflareST -p 0 -ipv6 -f ipv6.txt
}




