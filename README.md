# My Linux Configuration

## 写在前面的话

接触Linux辗转已经六年有余，从Ubuntu16.04 到如今的22.04，界面依然是熟悉的样子。

期间最难搞定的不过就是软件安装，权限，换源，依赖问题。

中途转入Deepin怀抱，终于通过软件商店解决了这个痛点，加之类似Windows的操作界面，原生且好看的UI，一用就是三年。

无奈迫于Deepin内的软件源更新太慢，很多依赖已经满足不了开发的需求，最终还是妥协的回到Ubuntu。

用Ubuntu过程中经常遇到各种问题，依赖CSDN各种千篇一律、不明所以的回答，运气好时还还真就立竿见影，运气不好时反而会把环境搞崩溃。

虽然有时也还能继续使用，但是强迫症的我无法忍受那种不知何处隐藏的小问题，像是鞋子里面进去的小石子一样难受。

最近实验室的师兄安利了NixOS，但是粗略一看并不是开箱即用的东西。好吧，我承认我不是爱折腾的人，其实是不想离开舒适区，等到闲下来会认真研究的。

鉴于需要经常重装环境，所以希望写一个脚本自动将开发环境配置起来。

同时实验室已经形成了配置VIM的攀比之风，我也随波逐流加入了浩荡的队伍里面吧。


## 装机必备

### 更新与换源

```bash
# 先更新一下软件
sudo apt update
sudo apt upgrade
```

关于要不要换源这件事，目前默认的源是Ubuntu中国的Server，http://cn.archive.ubuntu.com/ubuntu/，速度还行。

就算要换源，也请不要按照博客上面的教程手动更改/etc/apt/source.list

这是新手弄崩系统的第一步

打开Software & Updates

Download from -> Other -> select best server

自动选择一个当前最匹配的源不香吗？

![SofeWare and Updates](./img/sourcelist.png)

改完以后再去看看 /etc/apt/source.list就自动更新了，当然旧的会被命名为sources.list.save保存起来


### 基础软件

#### vim

```bash
# 先安装个nvim凑合用，如果之前没有装过vim，neovim可以直接用vim命令，否则需要用nvim命令
sudo apt install neovim
```

#### git

```bash
sudo apt install git

git config --global user.name "your-name"

git config --global user.email your-email

# Conflict resolution merge 
git config pull.rebase false
git config --global core.editor vim

# Apply a token as password
# github -> settings -> developer settings -> personal access tokens -> Select Scopes (at least choose repo) -> generate new token
# your token would be like abc_defghijklmn123456789
# Use your token as password when it promt to input passsword

# or store token in a file
git config --global credential.helper  'store --file ~/.git-credentials'
git config --list
# https://zhuweipu: is the domain of your own github site.
echo "https://zhuweipu:your-token-here" >> ~/.git-credentials
```

#### 中文输入法

[Linux的输入法框架原理](https://zhuanlan.zhihu.com/p/384171267)

常见的中文输入法框架 ibus（gnome自带）、fcitx

常见的中文输入引擎[google-pinyin](https://wiki.archlinux.org/title/IBus_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))、sogou-pinyin、[rime](https://wiki.archlinux.org/title/Rime_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))

如果使用ibus 加上 rime
```bash
sudo apt install ibus-rime
```

如果使用fcitx 加上 fcitx-rime
```bash
# 默认还是4
sudo apt install fcitx
# 最新版本是5
sudo apt install fcitx-5

sudo apt install fcitx-rime
```
rime需要再安装输入方案(全拼、双拼)

Settings -> Manage Installed Languages -> keyboard input method system 切换输入法框架

ibus使用命令行 ibus-setup 启动配置

fcitx 使用 fcitx configuration 配置


sogou-pinyin 只支持fcitx，下载deb包安装
```bash
sudo apt install ./sogou.deb
```

#### 科学上网

SSR V2RAY

一个 V2Ray 进程可并发支持多个入站和出站协议，每个协议可独立工作。

官方有bash安装的教程[v2ray官网](https://www.v2ray.com/chapter_00/install.html)
```
bash <(curl -L -s https://install.direct/go.sh)
```

此脚本会自动安装以下文件：

- /usr/bin/v2ray/v2ray：V2Ray 程序；
- /usr/bin/v2ray/v2ctl：V2Ray 工具；
- /etc/v2ray/config.json：配置文件；
- /usr/bin/v2ray/geoip.dat：IP 数据文件
- /usr/bin/v2ray/geosite.dat：域名数据文件

 推荐预编译版本，解压任意地方即可，软件可设置路径

[v2ray-core prebuilt](https://github.com/v2ray/dist)

下载v2ray-linux-64.zip

使用v2ray协议节点的桌面工具和应用程序有 qv2ray(目前已经不更新)，clash、v2rayN、v2rayA

v2rayA使用浏览器web作为配置界面

[v2rayA](https://github.com/v2rayA/v2rayA)

预编译版本

[v2raya_linux_x64_1.5.7 prebuilt](https://github.com/v2rayA/v2rayA/releases)


```bash
sudo ./v2raya_linux_x64_1.5.7 --v2ray-bin ~/v2raya/v2ray-linux-64/v2ray --log-level trace
```

直接执行，参数--v2ray-bin 指定v2ray core的路径


配置

浏览器输入 127.0.0.1:2017

![v2raya配置](img/v2raya.png)

导入 节点连接或者订阅的v2ray地址

设置 -> 透明代理/系统代理选择 代理模式(全局、代理、关闭)

#### 开发必备

```bash
# GNU Make gcc g++ dpkg-dev libc6-dev，一般系统都是64位的
sudo apt install build-essential
```

##### 浏览器

喜欢用edge浏览器的侧边栏

```bash
sudo apt install microsoft-edge-stable
```

Chrome浏览器

```bash
sudo apt install google-chrome-stable
```

#### 一些软件安装的tips

一切软件都最好从源安装，如果不知道安装包，可以搜索。

比如搜索edge浏览器

```bash
sudo apt search edge | grep -2 browser
```

如果需要从deb包安装，有两种方式[dpkg和apt](https://blog.csdn.net/weixin_42565457/article/details/122689733)

使用 dpkg 时，已经解决掉了软件安装过程中的大量问题，但是当依赖关系不满足时，仍然需要手动解决，而 apt 能够自动解决依赖问题。

```bash
sudo dpkg -i xxx.deb

sudo apt install ./xxx.deb
```

通过deb包安装的软件会在 /etc/apt/sources.list.d安装第三方软件的源，然后因为单个软件的签名不通过导致apt update失败，整个系统的软件都无法更新

```
Err:6 https://packages.microsoft.com/repos/edge stable InRelease

  The following signatures couldn't be verified because the public key is not available: NO_PUBKEY EB3E94ADBE1229CF

W: GPG error: https://packages.microsoft.com/repos/edge stable InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY EB3E94ADBE1229CF

E: The repository 'https://packages.microsoft.com/repos/edge stable InRelease' is not signed.

N: Updating from such a repository can't be done securely, and is therefore disabled by default.
```

进入/etc/apt/sources.list.d找到软件对应的list删除即可

#### 源码安装软件

[源码安装](https://blog.csdn.net/weixin_42565457/article/details/122530444?spm=1001.2014.3001.5501)

![安装过程](img/source_install.png)

--prefix后面接的路径表示这个软件将要安装到哪个目录去，如果没有指定--prefix=/path这个参数，通常默认为/usr/local。本人推荐安装位置为 /usr/local/XXX，XXX为自己的实际目录，这样会方便以后的管理。

源码包安装方式的man文件默认保存在/usr/local/man或/usr/local/share/man中，如果你的安装路径自定义为如/usr/local/XXX，则man文件则一般是在/usr/local/XXX/share/man中。此时如果你想要通过man来查看你所安装软件的man手册，则需要自行修改man的路径配置文件（可能是man.config或者manpath.config）。需要在相应位置添加如下一行：

```
MANPATH    /usr/local/XXX/share/man
```

通过源码包安装的软件，当你想要卸载的时候，只需要把整个安装路径删除掉就行了，100%卸载，不会像windows那样经常会残留那多注册表之类的垃圾。

根据你的安装时候选择的安装路径，源码包的卸载又分为两种情况：
1）如果你安装时候指定的路径为： --prefix=/usr/local/XXX，那么卸载的时候只需要把XXX这个文件夹删除即可，因为该软件安装的所有文件都是放置在XXX这个文件夹。
2）但如果你进行源码包安装的时候没有指定位置(默认值一般为/usr/local/)，或指定的位置为–prefix=/usr/local，则这时候你安装软件生成的文件将分别存储在/usr/local/里面的bin、lib或ect等目录中，这时候卸载起来就相对麻烦一点了。


#### 一些小工具

**截图**

图片存储在Picture目录下
```bash
sudo apt install gnome-screenshot
gnome-screenshot -a
```

**自定义快捷键**

```bash
Settings -> Keyboard -> View and customize Shortcuts -> Custom Shortcuts
```

#### neovim

### VMware

#### VMware-Tools

vmware 在虚拟机和宿主机复制粘贴

```bash
sudo apt install open-vm-tools-desktop cloud-init
reboot
```

#### 共享主机代理

虚拟机设置 -> 网络适配器 -> 自定义 -> VMnet8 (NAT模式)

Ubuntu Setting -> Network-> proxy -> Manual -> HTTP proxy / HTTPs proxy 设置为 Windows中 VMnet8 IP地址，端口号为科学上网软件（如Clash）端口号

Clash设置 -> 主页 -> 允许局域网
