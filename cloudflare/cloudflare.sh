#!/bin/bash

#确保已安装curl
#参数
#Cloudflare API调用地址（默认官网）
CLOUDFLARE_API="https://api.cloudflare.com"
#根域名zone id
ZONE_ID="zone id" 
#要使用ddns的域名
DOMAIN="domain"
#Cloudflare账号的API Key
API_KEY="api key"
#Cloudflare账号的注册邮箱
EMAIL="email"

#获取域名IP
function get_ip {
    if [ $DOMAIN ] ; then
        name=$domain
    echo "Domain name: $name"
    ip=`ping -c 1 $DOMAIN | head -1 | grep -o ' ([^)]*' | grep -o '[^ (]*$'`
    if [ ! $ip ] ; then
        echo "Can not get the IP of $name"
        exit 1
    fi
    echo "Current IP: $ip"
    fi
}

#使用API得到返回参数
function get_api {
RESULT=$(curl -s --insecure -X GET "$CLOUDFLARE_API/client/v4/zones/$ZONE_ID/dns_records?type=A&name=$DOMAIN&page=1&per_page=20&order=type&direction=desc&match=all" -H "X-Auth-Email: $EMAIL" -H "X-Auth-Key: $API_KEY" -H "Content-Type: application/json")
}

#判断域名或zone id是否出错
function check_zoneid {
if [ "$(echo $RESULT | awk -F ':' '{print $2}'| awk -F ',' '{print $1}')" = "[]" ];then
   echo "Requested domain not exist or incorrect zone id"
   exit 
 else
SUB_DOMAIN_ID=$(echo $RESULT | awk -F '"' '{print $6}')
fi
}


#测试ipv4
function test_ipv4 {
    cd /root/CloudflareST && ./CloudflareST -tl 500 -sl 0.1 -p 0 -f ip.txt
}
#测试ipv6
function test_ipv6 {
    cd /root/CloudflareST && ./CloudflareST -p 0 -ipv6 -f ipv6.txt
}

#获取优选IP
function get_best {
    #best=`sed -n 2p result.csv | grep -o '^[^,]*'`
    best=`sed -n 2p /root/CloudflareST/result.csv | cut -d, -f1`
    if [ ! $best ] ; then
        echo "Can not get the best Cloudflare IP"
        exit
    fi
    echo "Best Cloudflare IP: $best"
    if [ "$ip" == "$best" ] ; then
        exit
    fi
}

#修改域名A记录为本机ip地址
function updateip {
curl --insecure -X PUT "$CLOUDFLARE_API/client/v4/zones/$ZONE_ID/dns_records/$SUB_DOMAIN_ID" -H "X-Auth-Email: $EMAIL" -H "X-Auth-Key: $API_KEY" -H "Content-Type: application/json" --data '{"type":"A","name":"'$DOMAIN'","content":"'104.22.142.189'","ttl":120, "proxied":false}' 
}

echo
get_api
check_zoneid
#test_ipv4
#test_ipv6
exit 2
esac
echo
get_best
echo
updateip
exit
