# Convenience



## Archiving

```bash
# Create archive

# tar --create --verbose --gunzip --force-local --directory="${HOME}" --file="${1}.tar.gz" "${1}"
# tar --create --verbose --gunzip --force-local --file="${1}.tar.gz" --directory="${HOME}" "${dir}"

tar --create \
    --verbose \
    --gunzip \
    --force-local \
    --file="archive_output_file_name.tar.gz" \
    --directory="$(dirname "${FULL_PATH}")" \
    "$(basename "${FULL_PATH}")"
```


```bash
# The following is an exemplary command of how to archive your system
tar -cvpzf backup.tar.gz --exclude=/backup.tar.gz --one-file-system /
```


```bash
zip -r HomeLibZ.zip HomeLib
```


```bash
find -type f -exec md5sum "{}" + > checklist.chk

find FOO -type f -exec md5sum {} \;  > FOO.md5

echo -n foobar | sha256sum

echo -n foobar | shasum -a 256

echo -n "foobar" | openssl dgst -sha256 # -md4, -md5, -ripemd160, -sha, -sha1, -sha224, -sha384, -sha512, -whirlpool
```




## System

```bash
sudo systemctl list-units --type=service --state=running
```





## Networking

```bash
# Connect to Network
nmcli --ask con up NETWORK_SSID

# Display available Wi-Fi access points
nmcli --pretty device wifi list
```





## General

```bash
# Display date and time
date +"%nDate:%t%d / %B / %Y%t(%A)%nTime:%t%T%t%t(tz: %Z)"
```


```bash
awk 'NR>=98{print}NR==105{exit}' ./templates/layout.html


sed -n '98,104p;105q' ./templates/layout.html


grep --include=\*.html -rn . -e "logo"


grep -rl "Error at communicating with the API" ./ | xargs sed -i 's/Error at communicating with the API/API Communication Error/g'


grep --include=*.{html,po} -rinw . -e "Enter text here"


grep --include=urls.py -Porh \"path\(\'(\K.*?)'\" ./django


find . -path \"*/migrations/*.py\" -not -name \"__init__.py\" -delete


find . -path \"*/migrations/*.pyc\"  -delete


find "${SEARCH_PATH}" -type f \
    \( -size +100M -or -iregex ".*\.\(tar\|tar\.gz\|tgz\|tar\.bz2\|tar\.lz\|tar\.lrz\|tar\.lzo\|tar\.xz\|zip\|7z\)$" \) \
    -exec sha256sum {} \; | tee SHA256SUMS
```




## Multimedia

```bash
# convert video

ffmpeg  -i input_video.MP4 -lossless 1 output_video.webm
```





## KDE

```bash
# Display clipboard history

qdbus-qt5 org.kde.klipper /klipper org.kde.klipper.klipper.getClipboardHistoryMenu
```

#### Konsole

```
Ctrl + Shift + M ==> Show Menubar

Ctrl + ( == Ctrl + Shift + 9 ==> Split view left/right

Ctrl + ) == Ctrl + Shift + 0 ==> Split view top/bottom

Ctrl + Shift + [ ==> decrease view width

Ctrl + Shift + ] ==> increase view width

Ctrl + Alt + T ==> opens Konsole
```




## References

- [System Backup with TAR](https://help.ubuntu.com/community/BackupYourSystem/TAR)
- [Network configuration - Set the hostname](https://wiki.archlinux.org/title/Network_configuration#Set_the_hostname)
- [hostname(7)](https://www.man7.org/linux/man-pages/man7/hostname.7.html)
- [Back up and restore information in Firefox profiles](https://support.mozilla.org/en-US/kb/back-and-restore-information-firefox-profiles)
- [Profiles - Where Firefox stores your bookmarks, passwords and other user data](https://support.mozilla.org/en-US/kb/profiles-where-firefox-stores-user-data)
- [Export Firefox bookmarks to an HTML file to back up or transfer bookmarks](https://support.mozilla.org/en-US/kb/export-firefox-bookmarks-to-backup-or-transfer)
- [Restore bookmarks from backup or move them to another computer](https://support.mozilla.org/en-US/kb/restore-bookmarks-from-backup-or-move-them)
- [The Set Builtin](https://www.gnu.org/software/bash/manual/bash.html#The-Set-Builtin)
- [Making tar Archives More Reproducible](https://www.gnu.org/software/tar/manual/html_node/Reproducibility.html)

