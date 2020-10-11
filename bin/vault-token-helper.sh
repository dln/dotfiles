#!/usr/bin/env bash

# Vault Token helper for the Linux key retention service.
#
# Since version 2.6, the Linux kernel has included a efficiently store
# authentication data on a per thread, per process, per user, or per session
# bases.
#
# Linux Key Management Utilities (keyutils) provides `keyctl` to control
# the facility from the shell.
#
# see https://www.kernel.org/doc/Documentation/security/keys/core.rst
# see https://www.kernel.org/doc/Documentation/security/keys.txt
# see https://lwn.net/Articles/210502/
# see https://www.ibm.com/developerworks/library/l-key-retention/index.html
#
# Vault allows an external programs to be configured as a token helper
# that can get, store, and erase tokens on behalf of the Vault client.
#
# see https://www.vaultproject.io/docs/commands/token-helper.html
#
# To use this script, make it executable and set your ~/.vault file to
# contain:
#
# token_helper = "/path/to/vault-token-helper.sh"

# Exit on error.
set -o errexit
# Exit on error inside any functions or subshells.
set -o errtrace
# Do not allow use of undefined vars.
set -o nounset
# Catch the error if any piped command fails.
set -o pipefail

desc=VAULT_TOKEN:${VAULT_ADDR}

case $1 in
get)
    # If the key is not set, keyctl returns "request_key: Required key not available"
    # on stderr and exits with a non-zero status. The implied
    key_id=$(keyctl request user ${desc} || echo '')
    [ -z ${key_id} ] && exit 0
    keyctl pipe ${key_id}
;;
store)
    # Vault sends the token on stdin but there is no linebreak, so EOF is reached
    # which causes read to return a non-zero status.
    read -r token || true
    echo -n ${token} | keyctl padd user ${desc} @u
;;
erase)
    keyctl purge user ${desc}
;;
esac
