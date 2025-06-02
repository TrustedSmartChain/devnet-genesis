#!/usr/bin/env sh
# installs the TSC Node CLI and default node instance
set -e

# DOWNLOAD
tsc="$HOME/tsc/library/node/tsc"
download_url="https://github.com/TrustedSmartChain/tsc/releases/download/v1.0.0-alpha1/tsc_1.8.2"
curl $download_url -o $tsc --create-dirs
chmod +x $tsc

# ADD ALIAS
alias='alias tsc="~/tsc/library/node/tsc"'
if ! grep -Fxq "$alias" ~/.bashrc; then
    echo $alias >> ~/.bashrc
fi
# source ~/.bashrc

$tsc version

# INITIALIZE
set +e
$tsc node init -e mainnet
exit_code=$?
set -e
if [ "$exit_code" != 0 ] && [ $exit_code != 99 ]; then
  exit 1
fi

# ACTIVATE
$tsc node activate

# INSTALL SERVICE
$tsc node service install
$tsc node service start

# INSTALL SENTRY
$tsc workloads add tsc.chain.sentry
$tsc sentry install -e mainnet -c -s
