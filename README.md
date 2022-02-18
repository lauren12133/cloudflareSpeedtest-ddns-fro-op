# 声明
此项目是为了满足自己的需求在openwrt等基于BusyBox底层使用脚本，目的是优选IP后自动ddns到域名供某某使用，自己也只是懂点运行皮毛只更改了运行命令而已。。如有其他需求无法满足请谅解！！
# 优化 DNS Cloudflare IP
[CloudflareSpeedTest](https://github.com/XIU2/CloudflareSpeedTest) 脚本：查找最快 Cloudflare IP 并更新域名解析记录。


## 如何使用
登录你的 DNS 服务提供商，添加域名解析记录。  
_如果使用分地区按运营商线路解析功能，请注意不同线路的初始 IP 不能重复。_

1. 下载所用 DNS 服务提供商对应目录内的 `optimize-dns-cloudflare-ip.bash` 至 `CloudflareST` 所在目录。  
2. 修改 `optimize-dns-cloudflare-ip.bash`，按要求填写参数。  
3. 执行 `optimize-dns-cloudflare-ip.bash`。

如需自动定时执行，请查阅 `cron` 相关知识。

## 捐赠与赞助  可以去赞助下@CrazyBoyFeng 大佬
* [支付宝](https://user-images.githubusercontent.com/1733254/110204402-bbcabc80-7ead-11eb-8bbc-9be2041214c2.png)
* [微信支付](https://user-images.githubusercontent.com/1733254/110204405-bd948000-7ead-11eb-9c8a-13094e252d7a.png)

付款代表您同意就捐赠与赞助事项与我[约定](https://gist.github.com/CrazyBoyFeng/a53994e5cfb129110c150fb6ea802a87#file-donationandsponsorshipagreement-md)。
