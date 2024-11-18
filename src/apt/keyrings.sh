#!/bin/bash


# SOURCES

source "$LIB_DIR/log.sh"


# HELPERS

apt_keyrings_dir_exists () {
  if [ ! -r /etc/apt/keyrings ]; then
    install -m 0755 -d /etc/apt/keyrings
  fi
}


# ACTIONS

install_keyring () {
  name="$1"
  url="$2"
  keyring_path="/etc/apt/keyrings/$name"
  info "apt" "Installing keyring $name..."
  sudo curl -fsSL "$url" -o "$keyring_path"
  sudo chmod a+r "$keyring_path"
  info "apt" "  ...keyring installed."
}


# STATES

keyring_is_installed () {
  name="$1"
  keyring_url="$2"
  apt_keyrings_dir_exists
  if [ ! -r "/etc/apt/keyrings/$name" ]; then
    install_keyring "$name" "$keyring_url"
  fi
}


