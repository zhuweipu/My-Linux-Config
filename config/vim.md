

Ubuntu 22.04 apt get nvim version 0.6

nvim-tree requires nvim at least 0.7

so I need to install from source

## neovim 源码安装


[官方教程](https://github.com/neovim/neovim/wiki/Building-Neovim)

```bash
# prerequisites
sudo apt install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen

# download source
git clone --depth=1 https://github.com/neovim/neovim && cd neovim

# config and make
make CMAKE_BUILD_TYPE=Release

# install
sudo make install
```


```bash
vim ~/.bashrc


```


some problems

```
CMake Error at neovim/third-party/cmake/DownloadAndExtractFile.cmake:98 (message):
  error: downloading
  'https://www.leonerd.org.uk/code/libvterm/libvterm-0.1.4.tar.gz' failed

      status_code: 35
      status_string: "SSL connect error"
      log:   Trying 2a03:b0c0:1:d0::feb:5001:443...

  Connected to www.leonerd.org.uk (2a03:b0c0:1:d0::feb:5001) port 443 (#0)

  ALPN, offering h2

  ALPN, offering http/1.1

  TLSv1.0 (OUT), TLS header, Certificate Status (22):

  [5 bytes data]

  TLSv1.3 (OUT), TLS handshake, Client hello (1):

  [512 bytes data]

  TLSv1.0 (OUT), TLS header, Unknown (21):

  [5 bytes data]

  TLSv1.3 (OUT), TLS alert, decode error (562):

  [2 bytes data]

  error:0A000126:SSL routines::unexpected eof while reading

  Closing connection 0

  .....
  ninja: build stopped: subcommand failed.
```

开启代理后，服务器节点对于https的支持不好，导致网络问题，关闭代理编译即


```
Cmake error :generator: Ninja
```

版本不统一，之前编译过CMakeLists.txt后，产生了缓存文件CMakeCache.txt，

解决方案：删除CMakeCache.txt文件

```bash
rm -f `find -name CMakeCache.txt`
```

## Nerd font

```bash
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hasklig.zip
unzip Hasklig.zip -d ~/.fonts
fc-cache -fv
```

重启后设置终端字体为nerd

终端 -> Preferences -> unamed -> Custom font -> Hasklug Nerd Font

setup.lua
```
local servers = {
  ccls = require("lsp.config.ccls")
}
```
其余部分同lua.lua
```
local opts = {
  init_options = {
      -- 指定compile_command.json文件位置，默认为根目录
      -- compilationDatabaseDirectory = "build";
      index = {
        threads = 0;
      };
      clang = {
        excludeArgs = { "-frounding-math"} ;
      };
  },
}
```
