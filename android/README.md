# Android


**simple-mtpfs** and **mtp-tools** must be installed!


## [simple-mtpfs](https://software.opensuse.org/package/simple-mtpfs)

> SIMPLE-MTPFS (Simple Media Transfer Protocol FileSystem) is a file system for Linux (and other operating systems with a FUSE implementation, such as Mac OS X or FreeBSD) capable of operating on files on MTP devices attached via USB to local machine. On the local computer where the SIMPLE-MTPFS is mounted, the implementation makes use of the FUSE (Filesystem in Userspace) kernel module. The practical effect of this is that the end user can seamlessly interact with MTP device files.



## [mtp-tools](https://software.opensuse.org/package/mtp-tools)

> This package contains binaries that allow command line access to USB based media players based on the MTP (Media Transfer Protocol) authored by Microsoft. For graphical user interfaces use Amarok or Banshee.



## Allow Other

Running `simple-mtpfs _mountpoint/ -o allow_other` might cause the following error:

```
fusermount: option allow_other only allowed if 'user_allow_other' is set in /etc/fuse.conf
```


If that happens, `/etc/fuse.conf` must be updated like so:

```
# The file /etc/fuse.conf allows for the following parameters:
#
# user_allow_other - Using the allow_other mount option works fine as root, in
# order to have it work as user you need user_allow_other in /etc/fuse.conf as
# well. (This option allows users to use the allow_other option.) You need
# allow_other if you want users other than the owner to access a mounted fuse.
# This option must appear on a line by itself. There is no value, just the
# presence of the option.

user_allow_other


# mount_max = n - this option sets the maximum number of mounts.
# Currently (2014) it must be typed exactly as shown
# (with a single space before and after the equals sign).

#mount_max = 1000
```


## References

- [Linux fails to mount Android device in USB MSC mode](https://android.stackexchange.com/questions/52932/linux-fails-to-mount-android-device-in-usb-msc-mode)
- [How do I transfer files between Android and Linux over USB?](https://unix.stackexchange.com/questions/87762/how-do-i-transfer-files-between-android-and-linux-over-usb)
- [Mount Android phone file system on Linux manually](https://unix.stackexchange.com/questions/111870/mount-android-phone-file-system-on-linux-manually)
- [Mount /system and /data partition of an android phone in Windows/Linux](https://android.stackexchange.com/questions/110362/mount-system-and-data-partition-of-an-android-phone-in-windows-linux)
- [How to transfer files between Linux and Android in a fast and reliable way?](https://superuser.com/questions/1027722/how-to-transfer-files-between-linux-and-android-in-a-fast-and-reliable-way)
- [FUSE](https://www.kernel.org/doc/html/latest/filesystems/fuse.html)
- [fuse(8)](https://www.man7.org/linux/man-pages/man8/mount.fuse3.8.html)
- [fusermount - unmount FUSE filesystems](https://manpages.ubuntu.com/manpages/xenial/man1/fusermount.1.html)
- Debian
  - [jmtpfs](https://packages.debian.org/sid/jmtpfs)
  - [How to mount USB device using jmtpfs on Linux (Debian 9)?](https://unix.stackexchange.com/questions/466841/how-to-mount-usb-device-using-jmtpfs-on-linux-debian-9)
- ArchLinux
  - [Mobile phone](https://wiki.archlinux.org/title/Mobile_phone)
  - [Android](https://wiki.archlinux.org/title/Android)
  - [Media Transfer Protocol](https://wiki.archlinux.org/title/Media_Transfer_Protocol)
- Ubuntu
  - [How do I mount my Android phone?](https://askubuntu.com/questions/297766/how-do-i-mount-my-android-phone)
  - [Where are MTP mounted devices located in the filesystem?](https://askubuntu.com/questions/342319/where-are-mtp-mounted-devices-located-in-the-filesystem)
  - [How to transfer files from an Android phone to a Ubuntu PC by using a USB cable?](https://android.stackexchange.com/questions/66385/how-to-transfer-files-from-an-android-phone-to-a-ubuntu-pc-by-using-a-usb-cable)

