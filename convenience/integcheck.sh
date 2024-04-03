#!/usr/bin/env bash

set -o nounset -o errexit -o noclobber -o pipefail


if [ "${#}" -ne 1 ]; then
    echo >&2 "1 argument required, ${#} provided"
    exit 1
fi

if [ ! -d "${1}" ]; then
  echo "${1} does not exist."
  exit 1
fi


SEARCH_PATH="${1}"
FULL_SEARCH_PATH="$(realpath "${SEARCH_PATH}")"


echo "Searching in ${FULL_SEARCH_PATH}..."


find "${SEARCH_PATH}" -type f \
    \( -size +100M -or -iregex ".*\.\(tar\|tar\.gz\|tgz\|tar\.bz2\|tar\.lz\|tar\.lrz\|tar\.lzo\|tar\.xz\|zip\|7z\)$" \) \
    -exec sha256sum {} \; | tee SHA256SUMS


chmod 444 SHA256SUMS


# sudo chattr -V +i SHA256SUMS

echo "Done!"

