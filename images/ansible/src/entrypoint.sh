#! /usr/bin/env bash

set -e

persist_ssh_key() {
  ssh_key_path="$1"
  ssh_key="$2"
  if [[ ! -f "$ssh_key_path" && -n "$ssh_key" ]]; then
    echo "$ssh_key" > "$ssh_key_path"
    chmod 600 "$ssh_key_path"
  fi
}

persist_ssh_key ~/.ssh/id_ed25519 "$ID_ED25519"

exec "$@"
