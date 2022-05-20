#!/usr/bin/env bash

set -euo pipefail

basefile="test"
testfile="${basefile}.vim"
ref="${basefile}_ref.txt"
output="${basefile}_output.txt"

nvim -s "$testfile" "$output"

if cmp -s "${output}" "${ref}"; then
    printf 'The file "%s" is the same as "%s"\n' "$output" "$ref"
    rm ${output}
else
    printf 'The file "%s" is different from "%s"\n' "$output" "$ref"
    diff "$output" "$ref"
    rm ${output}
    exit 1
fi
