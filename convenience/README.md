# Convenience


**Summary**:

- Archiving and compressing
- Hashing
- System
- Networking
- General
- find
- Multimedia
- KDE
- Functions
- References


<br><br>


## Archiving and compressing

`tar` **compression options**:

- `--bzip2`    Filter the archive through bzip2
- `--xz`       Filter the archive through xz
- `--lzip`     Filter the archive through lzip
- `--lzma`     Filter the archive through lzma
- `--lzop`     Filter the archive through lzop
- `--gunzip`   Filter the archive through gzip
- `--zstd`     Filter the archive through zstd


**Create archive**:

```bash
tar --create --verbose --gunzip --force-local --file="${OUTPUT}.tar.gz" --directory="${DIR}" "${SUB_DIR}"
```

```bash
OUTPUT="compressed_archive"
DIR_PATH="/path/to/directory"

tar --create \
    --verbose \
    --gunzip \
    --force-local \
    --file="${OUTPUT}.tar.gz" \
    --directory="$(dirname "${DIR_PATH}")" \
    "$(basename "${DIR_PATH}")"
```

The `--directory=DIR` option (`-C DIR`) changes to `DIR` before performing any operations. This option is order‐sensitive, i.e. it affects all options that follow.


```bash
DIR_PATH="/path/to/directory"
dirname "${DIR_PATH}"     # /path/to
basename "${DIR_PATH}"    # directory
```


```bash
tar --create \
    --backup=numbered \
    --force-local \
    --verbose --verbose --verbose \
    --bzip2 \
    --file=output.tar.bz2 \
    --directory="base_dir" \
    "dir_name" > archive.log
```


**archive and compress system**:

```bash
tar -cvpzf backup.tar.gz --exclude=/backup.tar.gz --one-file-system /
```


`zip` **command**:

```bash
zip -r FILE.zip FILE
```


<br><br>


## Hashing

```bash
find -type f -exec md5sum "{}" + > checklist.chk

find FOO -type f -exec md5sum {} \;  > FOO.md5

echo -n foobar | sha256sum

echo -n foobar | shasum -a 256

echo -n "foobar" | openssl dgst -sha256 # -md4, -md5, -ripemd160, -sha, -sha1, -sha224, -sha384, -sha512, -whirlpool
```

**Verify file checksum**:

```bash
if ! sha256sum --check --quiet --status "${FILE}"; then
    echo "Failed checksum verification!" 1>&2
    exit 1
fi
```


<br><br>


## System

```bash
sudo systemctl list-units --type=service --state=running
```



**openSUSE**:

```bash
sudo zypper search --installed-only --requires "${PACKAGE_NAME}"

sudo zypper info \
    --conflicts \
    --provides \
    --requires \
    --recommends \
    --supplements \
    "${PACKAGE_NAME}"
```


<br><br>


## Networking

**Connect to Network**:

```bash
nmcli --ask con up NETWORK_SSID
```


**Display available Wi-Fi access points**:

```bash
nmcli --pretty device wifi list
```


```bash
nmcli dev wifi connect <name> password <password>

sudo traceroute -T -p 443 8.8.8.8  # replace IP

netstat -nt

sudo netstat -tunlp

route -n

sudo traceroute --max-hops=90 --queries=10 --wait=20 google.com

tracepath -b youtube.com
```


**show or manipulate wireless devices and their configuration**:

```bash
iw dev wlo1 link
```


<br><br>


## General


```bash
awk 'NR>=98{print}NR==105{exit}' ./templates/layout.html


sed -n '98,104p;105q' ./templates/layout.html


grep --include=\*.html -rn . -e "logo"


grep -rl "Error at communicating with the API" ./ | xargs sed -i 's/Error at communicating with the API/API Communication Error/g'


grep --include=*.{html,po} -rinw . -e "Enter text here"


find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +


find . -path \"*/migrations/*.py\" -not -name \"__init__.py\" -delete


find . -path \"*/migrations/*.pyc\"  -delete
```

```bash
find "${SEARCH_PATH}" -type f \
    \( -size +100M -or -iregex ".*\.\(tar\|tar\.gz\|tgz\|tar\.bz2\|tar\.lz\|tar\.lrz\|tar\.lzo\|tar\.xz\|zip\|7z\)$" \) \
    -exec sha256sum {} \; | tee SHA256SUMS
```


```bash
while read file_path; do if grep -q 'find_string' "${file_path}"; then mv "${file_path}" DEST_DIR/; fi; done < <(find . -name "*.eml" -type f)
```


```bash
# Display date and time
date +"%nDate:%t%d / %B / %Y%t(%A)%nTime:%t%T%t%t(tz: %Z)"
```

**Check if two directories are the same**:

- `-r`, `--recursive`: recursively compare any subdirectories found
- `-q`, `--brief`: report only when files differ

```bash
diff -r -q /path/to/directory1 /path/to/directory2
```



```bash
# Fix PDF font
ps2pdf -sFONTPATH="." INPUT_FILE.pdf OUTPUT_FILE.pdf

# "convert" is a great tool to merge images and convert them into a PDF file
# https://imagemagick.org/script/license.php
convert Image-0001.png Image-0002.png Image-0003.png OUTPUT_FILE.pdf

# Or (do not add quotes)
convert $(ls -v Image-000*.png) OUTPUT_FILE.pdf
```

```bash
##
## find
##

find . -type f -mtime 0

find . -newermt "yesterday" -type f -exec cp -t ./2024-04-15/ {} +

find /path/to/search/ -type f -name "glob-to-find-files" | xargs cp -t /target/path/
find /PATH/TO/YOUR/FILES -name NAME.EXT -exec cp -rfp {} /DST_DIR \;
find . -mtime 1 -exec cp -t ~/test/ {} +
find . -ctime 15 -exec cp {} ../otherfolder \;


# To find all files modified in the last 24 hours (last full day) in a particular specific directory and its sub-directories
# The "-" before "1" is important, it means anything changed one day or less ago;
# A "+" before "1" would instead mean anything changed at least one day ago;
# while having nothing before the "1" would have meant it was changed exacted one day ago, no more, no less.
find /my/path -mtime -1 -ls

# last 2 hours
find . -mmin -120 -ls

# human-readable time units (-newerXY)
find <directory> -newermt "-24 hours" -ls
find <directory> -newermt "1 day ago" -ls
find <directory> -newermt "yesterday" -ls

find . -newermt "yesterday"
```



**Get the 10 latest files by time of last data modification**:

```bash
find . -type f -exec stat -c '%Y %n' {} \; | sort -nr | cut -d' ' -f2- | awk 'NR==1,NR==10 {print}'
```


**Find files in "/my/path" bigger than 2 gibibytes and sort them from largest to smallest**:

```bash
find /my/path -type f -size +2G -exec du -h {} + | sort -rh | awk '{print $1, $2}'
```


<br><br>


## Multimedia


**Convert video**:

```bash
ffmpeg  -i input_video.MP4 -lossless 1 output_video.webm
```


<br><br>


## KDE


```bash
echo "${KONSOLE_DBUS_SERVICE}"
echo "${KONSOLE_DBUS_WINDOW}"
echo "${KONSOLE_DBUS_SESSION}"

qdbus6 "${KONSOLE_DBUS_SERVICE}" "${KONSOLE_DBUS_WINDOW}"
qdbus6 "${KONSOLE_DBUS_SERVICE}" "${KONSOLE_DBUS_SESSION}"

qdbus6 "${KONSOLE_DBUS_SERVICE}" "${KONSOLE_DBUS_WINDOW}" sessionCount
qdbus6 "${KONSOLE_DBUS_SERVICE}" "${KONSOLE_DBUS_WINDOW}" currentSession
qdbus6 "${KONSOLE_DBUS_SERVICE}" "${KONSOLE_DBUS_SESSION}" processId
```


**Display clipboard history**:

```bash
qdbus-qt5 org.kde.klipper /klipper org.kde.klipper.klipper.getClipboardHistoryMenu
```


**Konsole**:

```
Ctrl + Shift + M ==> Show Menubar

Ctrl + ( == Ctrl + Shift + 9 ==> Split view left/right

Ctrl + ) == Ctrl + Shift + 0 ==> Split view top/bottom

Ctrl + Shift + [ ==> decrease view width

Ctrl + Shift + ] ==> increase view width

Ctrl + Alt + T ==> opens Konsole
```


<br><br>


## Functions

**Logging**:

```bash
log_error() {
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')] ERROR - $*" >&2
}

log_info() {
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')] INFO  - $*"
}
```

**File type**:

```bash
is_regular_file() {
    [ ! -L "${1}" ] && [ -f "${1}" ]
}

is_regular_dir() {
    [ ! -L "${1}" ] && [ -d "${1}" ]
}
```


<br><br>


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

