# JetBrains


## Telemetry

Turn data collection on/off by going to

```
File > Settings > Appearance & Behavior > System Settings > Data Sharing
```


## Toolbox App - Installation

1. Download the tarball .tar.gz from the Toolbox App web page.

2. Extract the tarball to a directory that supports file execution. Example:


```bash
sudo tar -xzf jetbrains-toolbox-1.17.7391.tar.gz -C /opt
```

3. Execute the jetbrains-toolbox binary from the extracted directory to run the Toolbox App.

4. After you run the Toolbox App for the first time, it will automatically add the Toolbox App icon Toolbox App icon to the main menu.


## Toolbox App - System requirements (Linux: 64-bit x86, glibc 2.17)

#### Version: 2.0.4, Released: September 17, 2023

Toolbox App is packaged in [AppImage](https://appimage.org/) and requires [FUSE](https://libfuse.github.io/doxygen/) to run. See AppImage Wiki for details.
The following packages must be present:

```
libfuse2 libxi6 libxrender1 libxtst6 mesa-utils libfontconfig libgtk-3-bin tar
```


## References

- [JetBrains Toolbox App](https://www.jetbrains.com/toolbox-app/)
- [Installer for jetbrains toolbox](https://github.com/nagygergo/jetbrains-toolbox-install/tree/master)
- [jetbrains-toolbox.sh](https://github.com/nagygergo/jetbrains-toolbox-install/blob/master/jetbrains-toolbox.sh)
- [Installing JetBrains ToolBox on Ubuntu](https://dev.to/janetmutua/installing-jetbrains-toolbox-on-ubuntu-527f)
- [How to install JetBrains ToolBox in Ubuntu 22.04 LTS?](https://askubuntu.com/questions/1410885/how-to-install-jetbrains-toolbox-in-ubuntu-22-04-lts)
- [Standalone installation](https://www.jetbrains.com/help/pycharm/installation-guide.html#standalone)
- [Install using the Toolbox App](https://www.jetbrains.com/help/pycharm/installation-guide.html#toolbox)
- [AppImageKit](https://github.com/AppImage/appimagekit)
- [AppImage - docs](https://docs.appimage.org/introduction/index.html)
- [libfuse](https://github.com/libfuse/libfuse)
- [FUSE](https://wiki.archlinux.org/title/FUSE)
- [Filesystem in Userspace](https://en.wikipedia.org/wiki/Filesystem_in_Userspace)
