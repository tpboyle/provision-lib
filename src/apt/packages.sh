#!/bin/bash


# SOURCES

source "$LIB_DIR/log.sh"


# CHECKS

package_installed () {
  name="$1"
  dpkg -l "$name" 2> /dev/null | grep "$name" | grep "ii"
}


# ACTIONS

install_package () {
  name="$1"
  info "apt" "Installing $package..."
  sudo apt-get install -y "$name" > /dev/null
  info "apt" "  ...package installed."
}


# STATES

common_packages_are_installed () {
  package_is_installed "ca-certificates"
  package_is_installed "curl"
  package_is_installed "gnupg"
  package_is_installed "apt-transport-https"
}

package_is_installed () {
  package="$1"
  if [ ! -n "$(package_installed "$package")" ]; then
    install_package "$package"
  fi
}



