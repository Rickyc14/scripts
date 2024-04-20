#!/usr/bin/env bash
#
# Archive, compress, and compute checksums.

set -o nounset -o errexit -o noclobber -o pipefail

if [ "${#}" -eq 0 ]; then
    echo "Usage: ${0} <directory-path>"
    exit 0
elif [ "${#}" -ne 1 ]; then
    echo "Expected 1 argument, got ${#}" >&2
    exit 1
fi

if ! BASE_DIR="$(realpath --quiet --canonicalize-existing "${1}")"; then
    echo "'${BASE_DIR}' is not a valid path." >&2
    exit 1
fi

readonly BASE_DIR

if [ ! -d "${BASE_DIR}" ] || [ -L "${BASE_DIR}" ]; then
    echo "'${BASE_DIR}' must be a regular directory." >&2
    exit 1
fi

readonly STASH_CHECKSUMS="${BASE_DIR}/SHA256SUMS"

readonly EXPR='s#^\(.\{64\}\)\(\s\{2\}\)'"${BASE_DIR}"'/\(.*\)#\1\2\3#p'

echo "Base directory: ${BASE_DIR}"

while read -r dir_path; do
    dir_name="$(basename "${dir_path}")"
    stash_dir="${BASE_DIR}/.${dir_name}.stash"

    if [ -d "${stash_dir}" ] || ! mkdir "${stash_dir}"; then
        echo "Unable to create directory: ${stash_dir}" >&2
        exit 1
    fi

    find "${dir_path}" -type f -exec sha256sum {} \; \
        | sed -n "${EXPR}" > "${stash_dir}/${dir_name}.sha256"
    
    # compressed archive output
    comparch="${stash_dir}/${dir_name}.tar.bz2"

    echo -e "\nArchiving and compressing: ${dir_name}"

    tar --create \
        --backup=numbered \
        --force-local \
        --verbose --verbose --verbose \
        --bzip2 \
        --file="${comparch}" \
        --directory="${BASE_DIR}" \
        "${dir_name}" > "${comparch}.log"

    sha256sum "${comparch}" \
        | sed -n "${EXPR//"${BASE_DIR}"/"${stash_dir}"}" > "${comparch}.sha256"
    
    # Make stash items read-only before archiving them
    find "${stash_dir}" -type f -exec chmod 444 {} +

    # archived stash
    stash="${BASE_DIR}/${dir_name}.stash"

    echo "Creating stash..."

    readarray -t stash_items < <(find "${stash_dir}" -type f -exec basename --multiple {} +)

    tar --create \
        --backup=numbered \
        --force-local \
        --file="${stash}" \
        --directory="${stash_dir}" \
        "${stash_items[@]}"

    chmod 444 "${stash}"

    sha256sum "${stash}" | sed -n "${EXPR}" >> "${STASH_CHECKSUMS}"

done < <(find "${BASE_DIR}" -mindepth 1 -maxdepth 1 -type d)

chmod 444 "${STASH_CHECKSUMS}"

echo -e "\nEverything has been successfully stashed away."
