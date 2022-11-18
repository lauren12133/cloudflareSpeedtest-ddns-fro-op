# 声明
此项目是为了满足自己的需求在openwrt等基于BusyBox底层使用脚本，目的是优选IP后自动ddns到域名供某某使用，自己也只是懂点运行皮毛只更改了运行命令而已。。
# 优化 DNS Cloudflare IP
[CloudflareSpeedTest](https://github.com/XIU2/CloudflareSpeedTest) 脚本：查找最快 Cloudflare IP 并更新域名解析记录。


## 如何使用
不想写!还是给会的人用吧，不懂尽量别碰。。。提供下思路。。

1、下载XIU2/CloudflareSpeedTest脚本放入openwrt里，教程XIU2大佬的项目里很清晰。装在root目录下才可以使用本项目脚本，如果不想装root下，请自行更改脚本CloudflareST运行路径和result.csv生成路径。。。

2、下载本项目里的脚本文件，放在CloudflareSpeedTest脚本项目文件夹里，加个权限，运行即可。。

如需自动定时执行，请查阅 `cron` 相关知识。openwrt可以直接计划任务实现。

## 其他系统请去@CrazyBoyFeng 大佬里下载使用
bye！

## 捐赠与赞助  可以去赞助下@CrazyBoyFeng 大佬
* [支付宝](https://user-images.githubusercontent.com/1733254/110204402-bbcabc80-7ead-11eb-8bbc-9be2041214c2.png)
* [微信支付](https://user-images.githubusercontent.com/1733254/110204405-bd948000-7ead-11eb-9c8a-13094e252d7a.png)

付款代表您同意就捐赠与赞助事项与我[约定](https://gist.github.com/CrazyBoyFeng/a53994e5cfb129110c150fb6ea802a87#file-donationandsponsorshipagreement-md)。
