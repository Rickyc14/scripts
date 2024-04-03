# Automount


The syntax of a /etc/fstab entry is:

```
[Device] [Mount Point] [File System Type] [Options] [Dump] [Pass]
```

- **device**: The device/partition (by /dev location or UUID) that contain a file system.
- **mount point**: The directory on your root file system (aka mount point) from which it will be possible to access the content of the device/partition (note: swap has no mount point). Mount points should not have spaces in the names.
- **file system type**: Type of file system.
- **options**: Mount options of access to the device/partition (see the man page for mount).
- **dump**: Enable or disable backing up of the device/partition (the command dump). This field is usually set to 0, which disables it.
- **pass num**: Controls the order in which fsck checks the device/partition for errors at boot time. The root device should be 1. Other partitions should be 2, or 0 to disable checking.


```
~$ cat /etc/fstab

UUID=c5a13e07-1cec-4e46-864b-9210e1d0a6c1  /                       btrfs  defaults                      0  0
UUID=c5a13e07-1cec-4e46-864b-9210e1d0a6c1  /var                    btrfs  subvol=/@/var                 0  0
UUID=c5a13e07-1cec-4e46-864b-9210e1d0a6c1  /usr/local              btrfs  subvol=/@/usr/local           0  0
UUID=c5a13e07-1cec-4e46-864b-9210e1d0a6c1  /srv                    btrfs  subvol=/@/srv                 0  0
UUID=c5a13e07-1cec-4e46-864b-9210e1d0a6c1  /root                   btrfs  subvol=/@/root                0  0
UUID=c5a13e07-1cec-4e46-864b-9210e1d0a6c1  /opt                    btrfs  subvol=/@/opt                 0  0
UUID=c5a13e07-1cec-4e46-864b-9210e1d0a6c1  /home                   btrfs  subvol=/@/home                0  0
UUID=c5a13e07-1cec-4e46-864b-9210e1d0a6c1  /boot/grub2/x86_64-efi  btrfs  subvol=/@/boot/grub2/x86_64-efi  0  0
UUID=c5a13e07-1cec-4e46-864b-9210e1d0a6c1  /boot/grub2/i386-pc     btrfs  subvol=/@/boot/grub2/i386-pc  0  0
UUID=61F8-3212                             /boot/efi               vfat   utf8                          0  2
UUID=7279f632-7df5-4ffb-918c-8c2e803351e5  swap                    swap   defaults                      0  0
UUID=c5a13e07-1cec-4e46-864b-9210e1d0a6c1  /.snapshots             btrfs  subvol=/@/.snapshots          0  0
UUID=40c22e44-fe9e-45ed-a4ae-7a6125948727  /drive/mountpoint       ext4   defaults                      0  2
```





```
~$ sudo blkid
/dev/nvme0n1p3: UUID="7279f632-7df5-4ffb-918c-8c2e803351e5" TYPE="swap" PARTUUID="7f3755d9-d3f7-4be3-9110-5595fa8490e0"
/dev/nvme0n1p1: UUID="61F8-3212" BLOCK_SIZE="512" TYPE="vfat" PARTUUID="45baef06-427c-4131-a037-9d44f69bcbb5"
/dev/nvme0n1p2: UUID="c5a13e07-1cec-4e46-864b-9210e1d0a6c1" UUID_SUB="b854dff4-5ce7-420b-8d9b-8b57d29bf59e" BLOCK_SIZE="4096" TYPE="btrfs" PARTUUID="c6088c3e-0183-4639-8b3e-428433342425"
/dev/sda: LABEL="R-Drive" UUID="40c22e44-fe9e-45ed-a4ae-7a6125948727" BLOCK_SIZE="4096" TYPE="ext4"
```



## References

- [Automatically Mount Partitions](https://help.ubuntu.com/community/AutomaticallyMountPartitions)
- [Mount](https://help.ubuntu.com/community/Mount)
- [Fstab](https://help.ubuntu.com/community/Fstab)
- [Using UUID](https://help.ubuntu.com/community/UsingUUID)
- [How to auto mount drives on startup?](https://askubuntu.com/questions/966706/17-10-how-to-auto-mount-drives-on-startup)
- [How do I auto mount my partition?](https://askubuntu.com/questions/305712/how-do-i-auto-mount-my-partition)
- [Linux Filesystems Explained](https://help.ubuntu.com/community/LinuxFilesystemsExplained)
