#!/usr/bin/env sh
# installs the CLI and outputs the downloaded version
set -e

# DOWNLOAD
tsc="$HOME/tsc/library/node/tsc"
download_url="https://github.com/TrustedSmartChain/tsc/releases/download/v1.0.0-alpha1/tsc_1.8.2"
curl -L $download_url -o $tsc --create-dirs
chmod +x $tsc

# ADD ALIAS
alias='alias tsc="~/tsc/library/node/tsc"'
if ! grep -Fxq "$alias" ~/.bashrc; then
    echo $alias >> ~/.bashrc
fi

$tsc version
