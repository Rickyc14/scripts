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

echo "Base directory: ${BASE_DIR}"

while read -r dir_path; do
    dir_name="$(basename "${dir_path}")"
    stash_dir="${BASE_DIR}/.${dir_name}.stash"

    if [ -d "${stash_dir}" ]; then
        echo "Stash directory already exists: ${stash_dir}" >&2
        exit 1
    fi

    if ! mkdir "${stash_dir}"; then
        echo "Unable to create directory: ${stash_dir}" >&2
        exit 1
    fi

    pushd "${BASE_DIR}" > /dev/null

    if ! find "${dir_name}" -type f -exec sha256sum {} \; > "${stash_dir}/${dir_name}_SHA256SUMS"; then
        echo "Unable to compute directory hash: ${dir_path}" >&2
        popd > /dev/null
        exit 1
    fi
    
    popd > /dev/null
    
    # compressed archive output
    comparch="${stash_dir}/${dir_name}.tar.bz2"

    echo "Archiving and compressing: ${dir_name}"

    tar --create \
        --backup=numbered \
        --force-local \
        --verbose --verbose --verbose \
        --bzip2 \
        --file="${comparch}" \
        --directory="${BASE_DIR}" \
        "${dir_name}" > "${comparch}.log"
    
    pushd "${stash_dir}" > /dev/null

    if ! sha256sum "$(basename "${comparch}")" > "${comparch}.sha256"; then
        echo "Unable to compute file hash: ${comparch}" >&2
        exit 1
    fi
    
    popd > /dev/null
    
    # Make stash items read-only before archiving them
    chmod 444 "${stash_dir}/"*

    # archived stash
    stash="${stash_dir}/${dir_name}.stash" 

    echo "Creating stash..."

    readarray -t stash_items < <(find "${stash_dir}" -type f -exec basename --multiple {} +)

    tar --create \
        --backup=numbered \
        --force-local \
        --verbose --verbose --verbose \
        --file="${stash}" \
        --directory="${stash_dir}" \
        "${stash_items[@]}" > "${stash}.log"

    pushd "${stash_dir}" > /dev/null

    if ! sha256sum "$(basename "${stash}")" > "${stash}.sha256"; then
        echo "Unable to compute file hash: ${stash}" >&2
        popd > /dev/null
        exit 1
    fi

    popd > /dev/null

    chmod 444 "${stash_dir}/"*

done < <(find "${BASE_DIR}" -mindepth 1 -maxdepth 1 -type d)

echo "Everything has been successfully stashed away."
