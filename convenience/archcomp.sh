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


BASE_DIR="$(realpath "${1}")"

echo "Archiving and compressing directories in '${BASE_DIR}'..."

while read -r dir_path; do
    if [ -d "${dir_path}" ]; then
        dir_name="$(basename "${dir_path}")"
        output_file="${BASE_DIR}/${dir_name}.tar.bz2"

        if [ -f "${output_file}" ]; then
            echo "Warning: '${output_file}' already exists!"
            echo "Skipping..."
        else
            echo "Archiving and compressing: ${dir_name}"

            tar --create \
                --bzip2 \
                --force-local \
                --file="${output_file}" \
                --directory="${BASE_DIR}" \
                "${dir_name}"
        fi
    fi
done < <(find "${BASE_DIR}" -mindepth 1 -maxdepth 1 -type d)


echo "All directories have been archived and compressed."

