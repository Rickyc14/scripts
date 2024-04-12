#!/usr/bin/env bash

set -o nounset -o errexit -o noclobber -o pipefail


if [ "${#}" -eq 0 ]; then
    echo "Usage: ${0} <directory-path>"
    exit 1
elif [ "${#}" -ne 1 ]; then
    echo >&2 "Expected 1 argument, got ${#}"
    exit 1
elif [ ! -d "${1}" ]; then
  echo "'${1}' does not exist."
  exit 1
fi


SEARCH_PATH="${1}"
FULL_SEARCH_PATH="$(realpath "${SEARCH_PATH}")"


echo "Searching in '${FULL_SEARCH_PATH}'..."


find "${SEARCH_PATH}" -type f \
    \( -size +100M -or -iregex ".*\.\(tar\|tar\.gz\|tgz\|tar\.bz2\|tar\.lz\|tar\.lrz\|tar\.lzo\|tar\.xz\|zip\|7z\)$" \) \
    -exec sha256sum {} \; | tee SHA256SUMS


chmod 444 SHA256SUMS


# sudo chattr -V +i SHA256SUMS

echo "Done!"

