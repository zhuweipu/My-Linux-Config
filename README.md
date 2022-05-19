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

[SofeWare and Updates](./img/sourcelist.png)

改完以后再去看看 /etc/apt/source.list就自动更新了，当然旧的会被命名为sources.list.save保存起来
