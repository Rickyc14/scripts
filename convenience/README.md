# Convenience


**Summary**:

- Archiving and compressing
- GNU find
- Hashing
- System
- Networking
- General
- Multimedia
- KDE
- Functions
- Git
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

**List all files in the zip archive without actually extracting them**:

```bash
files=$(unzip -Z -1 "$archive")

unzip -p "$archive" "$file" | sha256sum | awk '{print $1}'

unzip -p archive.zip | sha256sum

tar -xzvf archive.tar.gz --to-command='sha256sum'

tar -xOzf archive.tar.gz | sha256sum
tar -xOjf archive.tar.bz2 | sha256sum

tar -xzvf archive.tar.gz --to-command='sh -c "sha256sum > /dev/stdout; echo $TAR_FILENAME"'
```


<br><br>


## GNU find


**Important: remember to "protect" the braces and semicolon (or plus sign) when executing a command (i.e., `-exec` or `-execdir`) as shown below.**


From `find(1)` EXAMPLES section:

```
   Executing a command for each file
       •      Run file on every file in or below the current directory.

                  $ find . -type f -exec file '{}' \;

              Notice that the braces are enclosed in single quote marks
              to protect them from interpretation as shell script
              punctuation.  The semicolon is similarly protected by the
              use of a backslash, though single quotes could have been
              used in that case also.

       In many cases, one might prefer the `-exec ... +` or better the
       `-execdir ... +` syntax for performance and security reasons.
```

**Using `exec`**


**Find and sort the 10 latest files in the current directory by time of last data modification**:

```bash
find . -type f -exec stat -c '%Y %n' '{}' \; | sort -nr | cut -d' ' -f2- | awk 'NR==1,NR==10 {print}'
```


**Find files in `/search/path` bigger than 2 gibibytes and sort them from largest to smallest**:

```bash
find /search/path -type f -size +2G -exec du -h '{}' '+' | sort -rh
```

**Find and copy files that have been modified in the last 24 hours**:

```bash
find /search/path -newermt "yesterday" -type f -exec cp --target-directory=DIRECTORY '{}' '+'
```


**Find files by age.**

- **`-amin n`**: Finds files accessed exactly, less than, or more than `n` minutes ago.
- **`-anewer reference`**: Finds files accessed more recently than the reference file's last modification time.
- **`-atime n`**: Finds files accessed exactly, less than, or more than `n*24` hours ago, ignoring fractional days.
- **`-cmin n`**: Finds files with status changes exactly, less than, or more than `n` minutes ago.
- **`-cnewer reference`**: Finds files with status changes more recent than the reference file's last modification time.
- **`-ctime n`**: Finds files with status changes exactly, less than, or more than `n*24` hours ago, with rounding rules similar to `-atime`.
- **`-mmin n`**: Checks if a file's data was modified exactly, less than, or more than `n` minutes ago.
- **`-mtime n`**: Checks if a file's data was modified exactly, less than, or more than `n*24` hours ago. Refer to `-atime` comments for details on rounding effects.
- **`-newer reference`**: Time of the last data modification of the current file is more recent than that of the last data modification of the reference file.
- **`-newerXY reference`**: Succeeds if timestamp `X` of the file being considered is newer than timestamp `Y` of the file reference, where `X` and `Y` represent different time attributes:
  - `a`: Access time
  - `B`: Birth time
  - `c`: Inode status change time
  - `m`: Modification time
  - `t`: Direct time interpretation
  - Note:
    - Some combinations of `XY` are invalid or unsupported.
    - Using an unsupported or invalid combination results in a fatal error.
    - Time specifications follow the `-d` option format of GNU date.
    - Birth time checks may result in errors if birth times are indeterminable or unsupported.


```bash
# Files that have been modified in the last twenty-four hours.
find . -mtime 0 -type f

# Files that have been modified in the last two hours.
find . -mmin -120 -ls

# Use `-ls` to list current file in `ls -dils` format on standard output.
find . -mtime 0 -type f -ls

# Find files that have been last modified exactly 2 days ago.
find /search/path -mtime 2

# Find files that have been modified within the last 5 days.
find /search/path -mtime -5

# Find files that have had their status changed within the last 30 days.
find . -ctime -30

# Find files that have been modified in the last 24 hours using a more human-readable approach.
find . -newermt "yesterday" -type f

# Find files that have been modified within the last 2 days.
find /search/path/ -newermt "2 days ago" -ls
find /search/path/ -newermt "-48 hours" -ls
```


**Find and delete empty directories in current working directory**:

```bash
find . -type d -empty -delete
```



```bash
# .NET / C#

find . -type d \( -name "bin" -or -name "obj" -or -name "node_modules" -or -name ".idea" -or -name "x64" \) -exec rm -rf '{}' '+'

find . -type d \( -path "*/client/.angular" -or -path "*/client/dist" \) -exec rm -rf '{}' '+'

find . -type d -empty -delete

find . -name ".vs" -type d
```


**find all files with the same name**

```bash

find -type f -print0 | awk -F/ 'BEGIN { RS="\0" } { n=$NF } k[n]==1 { print p[n]; } k[n] { print $0 } { p[n]=$0; k[n]++ }'



# Using GNU find:

find /some/path -type f -printf '%f\n' | sort | uniq -c



# Using POSIX find:

find /some/path -type f | sed 's~^.*/~~' | sort | uniq -c

find "$@" '!' -type d -print0 | xargs -0 basename -za | sort -z | uniq -cz | sort -nzr | tr '\0' '\n'
```


```bash
# The `-name` test comes before the `-type` test in order to avoid having to call stat(2) on every file.
find . -name "*.pdf" -type f
```



<br><br>


## Hashing

```bash
find -type f -exec md5sum '{}' + > checklist.chk

find FOO -type f -exec md5sum '{}' \;  > FOO.md5

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
fdupes -r -d -N .
```


```bash
fdupes --noprompt \
       --delete \
       --log="${LOG_FILE}" \
       --recurse \
       --size \
       --time \
       --minsize="$(numfmt --from=iec 100M)" \
       "${BASE_DIR}"
```




```bash
# Print text between specific line numbers
sed -n '10,44p' filename


sed -n '185,235p' file.txt


du -sch ./* | sort -h
```





```bash
awk 'NR>=98{print}NR==105{exit}' ./templates/layout.html


sed -n '98,104p;105q' ./templates/layout.html


grep --include=\*.html -rn . -e "logo"


grep -rl "Error at communicating with the API" ./ | xargs sed -i 's/Error at communicating with the API/API Communication Error/g'


grep --include=*.{html,po} -rinw . -e "Enter text here"


find . -name 'node_modules' -type d -prune -exec rm -rf '{}' '+'


find . -path "*/migrations/*.py" -not -name "__init__.py" -delete


find . -path "*/migrations/*.pyc"  -delete
```

```bash
find "${SEARCH_PATH}" -type f \
    \( -size +100M -or -iregex ".*\.\(tar\|tar\.gz\|tgz\|tar\.bz2\|tar\.lz\|tar\.lrz\|tar\.lzo\|tar\.xz\|zip\|7z\)$" \) \
    -exec sha256sum '{}' '+' | tee SHA256SUMS
```


```bash
while read -r file_path; do if grep -q 'find_string' "${file_path}"; then mv "${file_path}" DEST_DIR/; fi; done < <(find . -name "*.eml" -type f)
```

**Date and time**:

```bash
date +'%Y-%m-%d'  # 2024-06-17
```

```bash
date +"%nDate:%t%d / %B / %Y%t(%A)%nTime:%t%T%t%t(tz: %Z)"
```


**Check if two directories are the same**:

- `-r`, `--recursive`: recursively compare any subdirectories found
- `-q`, `--brief`: report only when files differ

```bash
diff -r -q /path/to/directory1 /path/to/directory2
```


```bash
DIR_PATH="/path/to/directory"
dirname "${DIR_PATH}"     # /path/to
basename "${DIR_PATH}"    # directory
```


```bash
# Fix PDF font
ps2pdf -sFONTPATH="." INPUT_FILE.pdf OUTPUT_FILE.pdf

# "convert" is a great tool to merge images and convert them into a PDF file
# https://imagemagick.org/script/license.php
convert Image-0001.png Image-0002.png Image-0003.png OUTPUT_FILE.pdf

# Or (do not add quotes)
convert $(ls -v Image-000*.png) OUTPUT_FILE.pdf

convert image.png -gravity North -chop 0x45 cropped_image.png
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


## Git

```bash
git show 7b16f41fb7ec3d9b056cc51d11088218a05f61b7:path/to/file
```


<br><br>




## References

- [System Backup with TAR](https://help.ubuntu.com/community/BackupYourSystem/TAR)
- [GNU find](https://www.man7.org/linux/man-pages/man1/find.1.html)
- [Network configuration - Set the hostname](https://wiki.archlinux.org/title/Network_configuration#Set_the_hostname)
- [hostname(7)](https://www.man7.org/linux/man-pages/man7/hostname.7.html)
- [Back up and restore information in Firefox profiles](https://support.mozilla.org/en-US/kb/back-and-restore-information-firefox-profiles)
- [Profiles - Where Firefox stores your bookmarks, passwords and other user data](https://support.mozilla.org/en-US/kb/profiles-where-firefox-stores-user-data)
- [Export Firefox bookmarks to an HTML file to back up or transfer bookmarks](https://support.mozilla.org/en-US/kb/export-firefox-bookmarks-to-backup-or-transfer)
- [Restore bookmarks from backup or move them to another computer](https://support.mozilla.org/en-US/kb/restore-bookmarks-from-backup-or-move-them)
- [The Set Builtin](https://www.gnu.org/software/bash/manual/bash.html#The-Set-Builtin)
- [Making tar Archives More Reproducible](https://www.gnu.org/software/tar/manual/html_node/Reproducibility.html)

