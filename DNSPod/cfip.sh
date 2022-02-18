#!/bin/bash
#请先去 DNSPod 后台增加一条A记录或AAAA记录然后填写以下参数：
sub_domain="你的主机记录 例do.baidu.com 前面这个“do”就是这个（不含主域名部分）若只有主域名则留空或删除该参数 "
domain="你的主域名"
#以下两项从控制台生成 https://console.dnspod.cn/account_id/token
account_id="ID"
token="Token"
#以上为需要手动填写的内容。
cd `dirname $BASH_SOURCE`
curl=`command -v curl 2> /dev/null`

function get_ip {
    if [ $sub_domain ] ; then
        name="$sub_domain.$domain"
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

function test_ipv4 {
    cd /root/CloudflareST && ./CloudflareST -tl 500 -sl 0.1 -p 0 -f ip.txt
}

function test_ipv6 {
    cd /root/CloudflareST && ./CloudflareST -p 0 -ipv6 -f ipv6.txt
}

function search_record { #查找ip对应的记录集id
    local link="https://dnsapi.cn/Record.List"
    local body="$headers&keyword=$IP&length=1"
    if [ $curl ] ; then
        response=`curl -fiks -X POST -d "$body" $link`
    else
        response=`wget -O- -q --method POST --body-data "$body" --no-check-certificate $link`
    fi
    #records=${recordset_id##*\"records\":\[\{\"id\":\"} #bash only
    #record_id=${records%%\"*} #bash only
    record_id=`echo "$response" | grep -o '"records":\[{"id":"[^"]*' | grep -o '[^"]*$'`
    record_line_id=`echo "$response" | grep -o '"line_id":"[^"]*' | grep -o '[^"]*$'`
    if [ ! $record_id ] ; then #空
        echo "No valid records with $ip. If it has been updated just now, please wait until it takes effect."
        exit 21
    fi
}

function get_best {
    #best=`sed -n 2p result.csv | grep -o '^[^,]*'`
    best=`sed -n 2p /root/CloudflareST/result.csv | cut -d, -f1`
    if [ ! $best ] ; then
        echo "Can not get the best Cloudflare IP"
        exit 31
    fi
    echo "Best Cloudflare IP: $best"
    if [ "$ip" == "$best" ] ; then
        exit
    fi
}

function update_ip {
    local body="$headers&record_id=$record_id&record_line_id=$record_line_id&value=$best"
    local link="https://dnsapi.cn/Record.Ddns"
    if [ $curl ] ; then
        response=`curl -fiks -X POST -d "$body" $link`
    else
        response=`wget -O- -q --method POST --body-data "$body" --no-check-certificate $link`
    fi
    if [ ! "$response" ] ; then
        echo "Update error"
        exit 41
    fi
    rm -f record.json
    echo "$response" > record.json
    echo "$response" | grep -o '"message":"[^"]*' | grep -o '[^"]*$'
}

get_ip
if [ $sub_domain ] ; then
    rr=$sub_domain
else
    rr="@"
fi
headers="login_token=$account_id,$token&lang=cn&format=json&domain=$domain&sub_domain=$rr"
echo
search_record
case $ip in 
*"."*)
    test_ipv4;;
*":"*)
    test_ipv6;;
*)
    exit 2;;
esac
echo
get_best
echo
update_ip
exit
