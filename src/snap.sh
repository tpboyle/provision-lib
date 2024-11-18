#!/bin/bash


# SOURCES

source "$LIB_DIR/log.sh"


# ACTIONS

install_snap () {
  name="$1"
  info "snap" "Installing snap $name..."
  sudo snap install "$name"
  info "snap" "  ...Snap installed."
}


# CHECKS

check_snap_is_installed () {
  name="$1"
  snap list | grep "$name"
}


# STATES

snap_is_installed () {
  name="$1"
  if [ ! -n "$(check_snap_is_installed "$name")" ]; then
    install_snap "$name"
  fi
}


