#!/usr/bin/env bash

set -euo pipefail

docker run --rm -it \
    -v "$(pwd)/tests/init.lua:/home/testuser/.config/nvim/init.lua" \
    -v "$(pwd)/lua/:/home/testuser/.config/nvim/lua/" \
    -v "$(pwd)/tests/:/home/testuser/tests/" \
    -w "/home/testuser/tests" \
    barklan/neovim-tester:latest bash test.sh
