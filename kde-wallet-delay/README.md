# KDE Wallet Delay


KDE Wallet takes too long to display the dialog box asking for your passphrase to unlock the OpenPGP secret key.

It's possible to fix this issue by adding `no-allow-external-cache` to the `gpg-agent.conf` file.

> This is the standard configuration file read by gpg-agent on startup. It may contain any valid long option; the leading two dashes may not be entered and the option may not be abbreviated. This file is also read after a SIGHUP however only a few options will actually have an effect. This default name may be changed on the command line (see option --options). You should backup this file.

You may edit it directly, or run:

```
echo no-allow-external-cache:0:1 | gpgconf --change-options gpg-agent
```


## Note

If you haven't generated GPG key pairs, then you can run `gpg --full-generate-key` to do so.

You can run `gpg --list-secret-keys --keyid-format=long` to list all known secret keys.


## References


- Bug Reports
  - [Kwallet unlock dialog very slow](https://bugs.archlinux.org/task/75650)
  - [KDE Wallet has become very slow to start](https://bbs.archlinux.org/viewtopic.php?id=278939)
  - [KDE slow start](https://bbs.archlinux.org/viewtopic.php?id=274868)
  - [Wallet system takes about 1 minute to start](https://bugs.kde.org/show_bug.cgi?id=458085)
- GnuPG
  - [Documentation](https://gnupg.org/documentation/index.html)
  - [Agent Configuration](https://gnupg.org/documentation/manuals/gnupg/Agent-Configuration.html)
  - [Configuration Files](https://www.gnupg.org/documentation/manuals/gnupg/GPG-Configuration.html)

