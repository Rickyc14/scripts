# Virtualization


## Packages

Install the following packages: **libguestfs**, **virt-manager**, **libvirt-client**, **virt-install**, etc.

It might be easier to just install the **kvm_server** and **kvm_tools** patterns.

```bash
sudo zypper install -t pattern PATTERN_NAME
```

Remember to _start_ or _enable_ `libvirtd`!

```bash
systemctl start libvirtd

# or

systemctl enable libvirtd
```



## Commands

#### Transferring files between guest and host

```bash
# List filesystems, partitions, and block devices
virt-filesystems --add opensusetumbleweed.qcow2 --all --long --human-readable


# Mount virtual machine filesystem
guestmount --add opensusetumbleweed.qcow2 --mount '/dev/sda2:/:subvol=@/home' --ro _mountpoint/

# Unmount guestmounted filesystem
guestunmount _mountpoint
```

#### `virsh` useful commands

`virsh` is a command-line interface tool for managing virtual machines through `libvirt`. It provides a wide range of commands to create, configure, manage, and monitor virtual machines and their resources.

```bash
# The basic structure of most virsh usage is:
#
#           virsh [OPTION]... <command> <domain> [ARG]...



# Get list of available domains
virsh list --all --name


# Create filesystem‐image
mkisofs -rlJ -o "${output_image_path}" "${directory_path}"

# Attach image
virsh attach-disk \
    --domain "${vm}" \
    --source "${output_image_path}" \
    --target sdb \
    --type cdrom \
    --mode readonly


# List all running (and not running, see --all flag) virtual machines
virsh list [--all]

# Start virtual machine
virsh start <VM_name_or_ID>

# Gracefully shuts down running virtual machine
virsh shutdown <VM_name_or_ID>

# Reboots virtual machine
virsh reboot <VM_name_or_ID>

# Provides detailed information about a specific virtual machine
virsh dominfo <VM_name_or_ID>
```



## Notes

#### Race conditions possible when shutting down the connection

> When guestunmount(1)/fusermount(1) exits, guestmount may still be running and cleaning up the mountpoint.
> The disk image will not be fully finalized.
>
> This means that scripts [...] have a nasty race condition

See `man guestmount`.


#### What is the difference between `qemu:///system` and `qemu:///session`? Which one should I use?

> All 'system' URIs (be it qemu, lxc, uml, ...) connect to the libvirtd daemon running as root which is launched at system startup. Virtual machines created and run using 'system' are usually launched as root, unless configured otherwise (for example in /etc/libvirt/qemu.conf).
>
> All 'session' URIs launch a libvirtd instance as your local user, and all VMs are run with local user permissions.
>
> You will definitely want to use qemu:///system if your VMs are acting as servers. VM autostart on host boot only works for 'system', and the root libvirtd instance has necessary permissions to use proper networkings via bridges or virtual networks. qemu:///system is generally what tools like virt-manager default to.
>
> qemu:///session has a serious drawback: since the libvirtd instance does not have sufficient privileges, the only out of the box network option is qemu's usermode networking, which has nonobvious limitations, so its usage is discouraged. More info on qemu networking options: http://people.gnome.org/~markmc/qemu-networking.html
>
> The benefit of qemu:///session is that permission issues vanish: disk images can easily be stored in $HOME, serial PTYs are owned by the user, etc.


#### libvirt configuration

> The libvirt daemon allows the administrator to choose the authentication mechanisms used for client connections on each network socket independently. This is primarily controlled via the libvirt daemon master config file in **/etc/libvirt/libvirtd.conf**. Each of the libvirt sockets can have its authentication mechanism configured independently. There is currently a choice of none, polkit and sasl.

> For user-session administration, daemon setup and configuration is not required; however, authorization is limited to local abilities; the front-end will launch a local instance of the libvirtd daemon.

> The easiest way to ensure your user has access to libvirt daemon is to add member to libvirt user group.
>
> Members of the libvirt group have passwordless access to the RW daemon socket by default.


Add a user to additional groups with usermod:

```bash
usermod -aG "${ADDITIONAL_GROUP}" "${USERNAME}"
```



## References

- libvirt
  - [libvirt Wiki](https://wiki.libvirt.org/)
  - [Connection authentication](https://libvirt.org/auth.html)
  - [Libvirt native C API and daemons (source code)](https://gitlab.com/libvirt/libvirt)
- QEMU
  - [Networking](https://wiki.qemu.org/Documentation/Networking)
  - [HelperNetworking](https://wiki.qemu.org/Features/HelperNetworking)
- openSUSE
  - [Leap 15.5 - Virtualization Guide](https://doc.opensuse.org/documentation/leap/virtualization/single-html/book-virtualization/)
  - [Configuring GPU Pass-Through for NVIDIA cards](https://doc.opensuse.org/documentation/leap/virtualization/html/book-virtualization/app-gpu-passthru.html)
  - [Setting up a KVM VM Host Server](https://doc.opensuse.org/documentation/leap/virtualization/html/book-virtualization/cha-qemu-host.html)
  - [libvirt daemons](https://doc.opensuse.org/documentation/leap/virtualization/html/book-virtualization/cha-libvirt-overview.html)
  - [Configuring virtual machines with Virtual Machine Manager](https://doc.opensuse.org/documentation/leap/virtualization/html/book-virtualization/cha-libvirt-config-gui.html)
  - [Preparing the VM Host Server](https://doc.opensuse.org/documentation/leap/virtualization/html/book-virtualization/cha-libvirt-host.html#libvirt-host-network)
- ArchWiki
  - [libvirt](https://wiki.archlinux.org/title/Libvirt)
  - [NetworkManager](https://wiki.archlinux.org/title/NetworkManager)
  - [Virt-manager](https://wiki.archlinux.org/title/Virt-manager)
  - [Creating bridge manually](https://wiki.archlinux.org/title/QEMU#Creating_bridge_manually)
  - [Group management](https://wiki.archlinux.org/title/Users_and_groups#Group_management)

